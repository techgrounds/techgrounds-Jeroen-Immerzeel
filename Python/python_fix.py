
length = 0
my_list = [18, 7, 43, 32, 68]
for number in my_list:

    if len(my_list) == length+1:

        
        print(number + my_list[0])

    else:

        
        print(number + my_list[length+1])
    length += 1