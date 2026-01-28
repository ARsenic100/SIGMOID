amount = 1000; rate = 10; years = 5
for i in range(years):
    amount = amount + amount*rate/100
print(amount)