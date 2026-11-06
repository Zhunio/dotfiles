#!/usr/bin/env python3

import json
import sys
from pathlib import Path
from time import time
from urllib.parse import urlencode
from urllib.request import urlopen


class WeatherCache:
    cache_dir = Path.home() / ".cache/tmux"
    cache_file = cache_dir / "weather.json"
    cache_seconds = 10 * 60  # 10 minutes × 60 seconds per minute.

    def __init__(self):
        try:
            cache = json.loads(self.cache_file.read_text())
        except (OSError, ValueError):
            cache = {}

        self.latitude = cache.get("latitude")
        self.longitude = cache.get("longitude")
        self.temperature = cache.get("temperature")
        self.icon = cache.get("icon")
        self.updated_at = cache.get("updated_at", 0)

    def expired(self):
        return time() - self.updated_at >= self.cache_seconds

    def set_cache(self, latitude, longitude, temperature, icon):
        self.latitude = latitude
        self.longitude = longitude
        self.temperature = temperature
        self.icon = icon
        self.updated_at = time()

        self.cache_dir.mkdir(parents=True, exist_ok=True)
        self.cache_file.write_text(json.dumps(vars(self)))


class Weather:
    def __init__(self, city, country):
        self.city = city
        self.country = country

    def get_coordinates(self):
        query = urlencode({"name": self.city, "countryCode": self.country, "count": 1})
        url = f"https://geocoding-api.open-meteo.com/v1/search?{query}"

        with urlopen(url, timeout=3) as response:
            location = json.load(response)["results"][0]

        return location["latitude"], location["longitude"]

    def get_current(self, latitude, longitude):
        query = urlencode({
            "latitude": latitude,
            "longitude": longitude,
            "current": "temperature_2m,weather_code,is_day",
            "temperature_unit": "fahrenheit",
            "timezone": "auto",
        })
        url = f"https://api.open-meteo.com/v1/forecast?{query}"

        with urlopen(url, timeout=3) as response:
            current = json.load(response)["current"]

        return float(current["temperature_2m"]), current["weather_code"], current["is_day"]


# Open-Meteo weather codes: https://open-meteo.com/en/docs#weather_variable_documentation
def get_icon(weather_code, is_day):
    if weather_code in (0, 1):
        return "☀️" if is_day else "🌙"  # Clear day / night
    if weather_code in (2, 3, 45, 48):
        return "☁️"  # Cloudy
    if weather_code in (51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82):
        return "🌧️"  # Rain
    if weather_code in (71, 73, 75, 77, 85, 86):
        return "❄️"  # Snow
    if weather_code in (95, 96, 99):
        return "⛈️"  # Thunderstorm
    return "☁️"  # Unknown code


def main():
    cache = WeatherCache()

    if cache.expired():
        weather = Weather("Cuenca", "EC")
        try:
            latitude, longitude = weather.get_coordinates()
            temperature, weather_code, is_day = weather.get_current(latitude, longitude)
            cache.set_cache(latitude, longitude, temperature, get_icon(weather_code, is_day))
        except (OSError, ValueError, KeyError, IndexError, TypeError):
            pass  # Offline: keep the last reading.

    # tmux runs this twice: `weather.py icon` and `weather.py temperature`.
    if sys.argv[1:] == ["icon"]:
        print(cache.icon or "☁️")
    elif cache.temperature is not None:
        print(f"{cache.temperature:g}°F")
    else:
        print("⚠ ERROR")


if __name__ == "__main__":
    main()
