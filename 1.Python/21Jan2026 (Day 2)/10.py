words = ['Identifiers', 'Keywords', 'Datatypes', 'Operators']
c = [w[0] for w in words]  # first character of each word
print(c)

str2 = "the quick brown fox jumps over the lazy dog"
words = str2.split()
a = [(w.upper(), len(w)) for w in words]  # uppercase + length
print(a)