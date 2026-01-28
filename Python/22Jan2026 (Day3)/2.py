import random
from datetime import datetime

def get_stock_rate():
    return random.randint(-8, 20)

def get_savings_rate():
    return random.randint(2, 7)

def get_amount(initial, rate_fn, years):
    amount = initial
    for _ in range(years):
        amount += amount *rate_fn() / 100
    return amount

def run_simulation():
    years= 20
    investments = [('stocks', 500), ('savings', 500)]
    rates= {'stocks': get_stock_rate, 'savings': get_savings_rate}
    total= 0

    for item in investments:
        category= item[0]
        amount = item[1]
        rate_fn = rates[category]
        total+= get_amount(amount, rate_fn , years)

    return total

output= []
for run in range(1000):
    output.append(run_simulation())

with open('simulation.txt', 'a') as f:
    f.write(50 * '-'+ '\n')
    f.write('Execution Time' + str(datetime.now()) + '\n')
    f.write(str(max(output)) + '\n')
    f.write(str(min(output)) + '\n')
    f.write(str(sum(output)/len(output)) + '\n')
    f.write( 'Execution Time:' + str(datetime.now()) + '\n')
    f.write(50 * '-'+ '\n')





