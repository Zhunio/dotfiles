import os


def getenv(name):
    return os.environ.get(name, "")
