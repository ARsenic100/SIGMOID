amount = 1000; rate = 10
amount_1_year= amount + amount*rate/100
amount_2_year= amount_1_year + amount_1_year*rate/100
amount_3_year= amount_2_year + amount_2_year*rate/100
amount_4_year= amount_3_year + amount_3_year*rate/100
amount_5_year= amount_4_year + amount_4_year*rate/100

print(amount_5_year)

#using loop
for _ in range(5):
    amount= amount + amount * rate/ 100
print(amount)

#using functions
def get_amount(initial, rate, years):
    for _ in range(years):
         initial+= initial * rate/ 100
    return initial
print(get_amount(1000, 10, 5))


#Collections for organising data
years=20
investments= [('stocks', 500), ('savings', 500)]
rates= {'stocks': 8, 'savings': 4}

for item in investments:
    category= item[0]
    amount = item[1]
    rate= rates[category]
    print(category, amount , rate)


