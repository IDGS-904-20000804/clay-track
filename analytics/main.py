
import time
from controllers.mainProcessAnalytics import mainProcessAnalytics
from databases.fillDatabase import fillDatabase


def main():
  seconds = 30
  fillDatabase()
  # mainProcessAnalytics()
  while True:
    print(f"Executing code every {seconds} seconds")
    mainProcessAnalytics()
    time.sleep(seconds)


if __name__ == "__main__":
  main()
