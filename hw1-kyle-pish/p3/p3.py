'''
Kyle Pish
CS355
Assignment 1 p3.py
'''
#prompt user to input a string
inputString = input("Enter a string (Tpye nothing and hit enter to end input): ")
stringList = list()

#while loop to add input to stringList until user enters ""
while inputString != "": 
    stringList.append(inputString);
    inputString = input("Enter a string (Type nothing and hit enter to end input): ")

#sorting list alphabetically
stringList.sort()

#calculating index of correct value and outputting the correct elements
middle = int(len(stringList) / 2)
firstMiddleLast = (stringList[0], stringList[middle], stringList[-1])
print(firstMiddleLast);
