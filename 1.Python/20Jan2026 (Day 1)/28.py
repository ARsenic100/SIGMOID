# loops with else block
cart = [10, 20, 30, 50]
for item in cart:
    if item >= 100:
        print("This order can't be processed")
        break
    print(item)
else:
    print("All cart items processed in the order")