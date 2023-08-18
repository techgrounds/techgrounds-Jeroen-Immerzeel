

import os
import csv

new_dict = {}

new_dict["Firstname"] = input("What is your first name? ")
new_dict["Lastname"] = input("What is your last name? ")
new_dict["Jobtitle"] = input("What is your job title? ")
new_dict["Company"] = input("For which company do you work? ")

csv_file_path = "new_dict.csv"

file_exist = os.path.exists(csv_file_path)

with open(csv_file_path, "a", newline="") as csv_file:
    csv_writer=csv.writer(csv_file)
    if not file_exist:
        csv_writer.writerow(new_dict.keys())
    csv_writer.writerow(new_dict.values())


