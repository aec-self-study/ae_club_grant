my_first_list = ['apple', 1, 'banana', 2]
cal_lookup = {'apple': 95, 'banana': 105, 'orange': 45}

for item in my_first_list:
    if isinstance(item, str):
        print(cal_lookup[item])
    else:
        print(item**2)

grants_fruit_list = ['apple', 'orange', 'watermelon']

def square_fruit_values(my_list, my_dictionary):
    for item in my_list:
        try:
            print(my_dictionary[item]**2)
        except:
            print(item + " does not exist in dictionary")