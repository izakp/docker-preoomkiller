import string
import random

def randomString(stringLength=100):
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(stringLength))

def main():
  _buffer = []
  while True:
    _buffer.append(randomString())

if __name__ == "__main__":
  main()
