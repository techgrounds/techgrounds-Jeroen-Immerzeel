import random

attempt = 1
wins = 0

print("Lets play a number guessing game.")
print("I will pick a number between 1 and 100, and you will try to guess that number as quickly as possible.")
print("Each attempt to guess will be counted")

randomNumber = 1 #(random.randint(1, 100))

while True:
    guess = int(input("Which number do you want to guess?"))
    if guess <= 0: 
        print("That is not a valid number. Try again")
    elif guess == randomNumber:
        print("You win!")
        wins += 1
        print("It took you", str(attempt), "tries to guess the number!")
        print("The total amount of guesses over all numbers is: ", str(attempt))
        print("And this is win number: ", wins)
        gameOn = input("Do you want to continue?(y/n) ")
        if  gameOn == "y":
            randomNumber = (random.randint(1, 100))
            continue
        else:
            break
    elif guess <= randomNumber:
        print("Too low")
        attempt += 1
    elif guess >= randomNumber:
        print("Too high")
        attempt += 1
    else:
        continue