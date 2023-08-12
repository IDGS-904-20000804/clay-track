
import time
from controllers.mainProcessAnalytics import mainProcessAnalytics
from fillingDatabase.fillDatabase import fillDatabase


def main():
  seconds = 30
  fillDatabase()
  print('\nStarting process\n')
  while True:
    print(f"\nExecuting code every {seconds} seconds\n")
    mainProcessAnalytics()
    time.sleep(seconds)


if __name__ == "__main__":
  main()
