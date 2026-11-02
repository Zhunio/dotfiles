#!/usr/bin/env python3

import json
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
        self.updated_at = cache.get("updated_at", 0)

    def expired(self):
        return time() - self.updated_at >= self.cache_seconds

    def set_cache(self, latitude, longitude, temperature):
        self.latitude = latitude
        self.longitude = longitude
        self.temperature = temperature
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

    def get_temperature(self, latitude, longitude):
        query = urlencode({
            "latitude": latitude,
            "longitude": longitude,
            "current": "temperature_2m",
            "temperature_unit": "celsius",
            "timezone": "auto",
        })
        url = f"https://api.open-meteo.com/v1/forecast?{query}"

        with urlopen(url, timeout=3) as response:
            weather = json.load(response)

        return float(weather["current"]["temperature_2m"])


def main():
    cache = WeatherCache()

    if cache.expired():
        weather = Weather("Gualaquiza", "EC")
        try:
            latitude, longitude = weather.get_coordinates()
            temperature = weather.get_temperature(latitude, longitude)
            cache.set_cache(latitude, longitude, temperature)
            print(f"{temperature:g}°C")
        except (OSError, ValueError, KeyError, IndexError, TypeError):
            if cache.temperature is not None:
                print(f"{cache.temperature:g}°C")  # Offline: show the last reading.
            else:
                print("⚠ ERROR")
    else:
        print(f"{cache.temperature:g}°C")


if __name__ == "__main__":
    main()
