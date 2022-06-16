from datetime import datetime, time

now = datetime.now()
timestamp = 1639933350

last_timpestemp = timestamp + 60

# print("Current Time =", now)
# print("Current Time =", timestamp)
# print (last_timpestemp)
for i in range (60):
  dictionary = {}
  with open("logfile.txt", "r") as f:
    for line in f:
      v = line.split()
      if int(v[0]) > timestamp and int(v[0]) < last_timpestemp:
        if v[1] not in dictionary:
          dictionary[v[1]] = 1
        else:
          dictionary[v[1]] = dictionary[v[1]] + 1
    
    print(dictionary)
    timestamp=last_timpestemp
    last_timpestemp=last_timpestemp+60
