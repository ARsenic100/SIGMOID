# Nested dictionaries
market = {}
print(market)             # Prints {}
print(type(market))       # <class 'dict'>

market['store1'] = {}
market['store2'] = {}
print(market)

market['store1']['name'] = 'Online Store'
market['store2']['name'] = 'Offline Store'
print(market)

# Adding a list of items (dictionaries) under 'store1'
market['store1']['items'] = [
    {'name': 'headset', 'price': 5000},
    {'name': 'iphone', 'price': 100000}
]

print(market)

import json
print(json.dumps(market, indent=4))

#1
print(market['store1']['name'])
#2
items = market['store1']['items']
for e in items:
	print(e['name'])
	if e['name'] == 'iphone':
		print(e['price'])
