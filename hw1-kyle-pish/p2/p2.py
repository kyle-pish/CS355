'''
Kyle Pish
CS355
Assignment 1 p2.py
'''

#import math for access to math.pi
import math

#variable declaration and prompt user for input
diameter = input("Enter the diameter of the canteloupe in inches: \n")
diameter = float(diameter)
price = input("Enter the price of the canteloupe in dollars: \n")
price = float(price)

#calculations
CubicInches = ((4/3) * math.pi * ((diameter/2)**3))
#calculation of final value ronded to 2 decimal points
PricePerCubicInch = round (price / CubicInches, 2)

#output final value
print (PricePerCubicInch)