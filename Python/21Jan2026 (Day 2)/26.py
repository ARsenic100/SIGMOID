#opening a file
f = open('testfile.txt', 'w')
print('File Name:', f.name)
print('File Mode:', f.mode)
print('Is the file readable:', f.readable())
print('Is the file writable:', f.writable())
print('Is the file closed:', f.closed)
f.close()
print('Is the file closed:', f.closed)

#writing a file
f1 = open('testfile.txt', 'w')
for i in range(25):
    f1.write('This is a sample line ' + str(i + 1) + '\n')
f1.close()
print('Is the file closed:', f1.closed)

#reading data
f2 = open('testfile.txt', 'r')
print('File Name:', f2.name)
print('File Mode:', f2.mode)
print('Is the file readable:', f2.readable())
print('Is the file writable:', f2.writable())

lines = f2.readlines()
for line in lines:
    print(line.strip())  # strip() removes newline characters

f2.close()
print('Is the file closed:', f2.closed)

#appending a file
f1 = open('testfile.txt', 'a')
for i in range(25):
    f1.write('This is a sample line ' + str(i + 1) + '\n')
f1.close()
print('Is the file closed:', f1.closed)

# automaticlly closes fileeee
with open('testfile.txt', 'w') as f1:
    for i in range(25):
        f1.write('This is a sample line ' + str(i + 1) + '\n')
print('Is the file closed:', f1.closed)