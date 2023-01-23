#!/usr/bin/env python3
# interp.py
# Author: Mark Liffiton [and add your name as an author]
# Date: Sep, 2022
#
# Implementation of an interpreter for CS355 A2
#

from frontend import read, parse


def is_float(atom):
    # Return True if the given atom represents a floating point number, False otherwise.
    try:
        float(atom)
        return True
    except ValueError:
        return False


def is_string(atom):
    # Return True if the given atom represents a string (starting and ending with " double quotes), False otherwise.
    if atom.startswith('"') and atom.endswith('"'):
        return True
    else: 
        return False


def evaluate(node):
    # Given an AST node (with expressions represented as lists and atoms as strings), evaluate it and return its value.
    if isinstance(node, list):
        return evaluate_expr(node)
    else:
        return evaluate_atom(node)


# Use this global dictionary to store the interpreted program's variables.
variables = {}


def assign_var(name, val):
    # Assign the given value to the given variable
    variables.update({name: val})


def lookup_var(name):
    # Return the value of the given variable
    return variables.get(name)



def evaluate_atom(atom):
    # Evaluate an atom (Number, String, or Variable) and return its value
    assert isinstance(atom, str), f"Invalid atom: {atom}"
    if is_float(atom) == True:
        return float(atom)
    elif is_string(atom) == True:
        return atom  
    else:
        return lookup_var(atom)
        


def evaluate_expr(expr):
    # Evaluate an expression and return its value.
    assert isinstance(expr, list), f"Invalid expression: {expr}"

    if expr[0] == 'print':
        if len(expr) > 2:
            print ("invalid expression, please enter only 1 argument")
        else:
            exp = evaluate(expr[1])
            print (exp)
        
    #Evalate expression and return the sum
    elif expr[0] == '+':
        if len(expr) > 3:
            print ("invalid expression, please enter only 2 argument")
        else:
            num1 = evaluate(expr[1])
            num2 = evaluate(expr[2])
            sum1 = float(num1) + float(num2)
            return (sum1)
    
    #Evaluate expression and return the difference
    elif expr[0] == '-':
        if len(expr) > 3:
            print ("invalid expression, please enter only 2 argument")
        else:
            num1 = evaluate(expr[1])
            num2 = evaluate(expr[2])
            difference = float(num1) - float(num2)
            return (difference)
        
    #Evaluate expression and return the product
    elif expr[0] == '*':
        if len(expr) > 3:
            print ("invalid expression, please enter only 2 argument")
        else:
            num1 = evaluate(expr[1])
            num2 = evaluate(expr[2])
            product = num1 * num2
            return (product)
    
    #Evalute expression and return the quotient
    elif expr[0] == '/':
        if len(expr) > 3:
            print ("invalid expression, please enter only 2 argument")
        else:
            num1 = evaluate(expr[1])
            num2 = evaluate(expr[2])
            quotient = float(num1) / float(num2)
            return (quotient)
    
    #Evalute the expression and return whether the first argument is less than the second or not
    elif expr[0] == '<':
        if len(expr) > 3:
            print ("invalid expression, please enter only 2 argument")
        else:
            num1 = evaluate(expr[1])
            num2 = evaluate(expr[2])
            if float(num1) < float(num2):
                return True
            else:
                return False

    #Evalute the expression and return whether the first argument is greater than the second or not
    elif expr[0] == '>':
        if len(expr) > 3:
            print ("invalid expression, please enter only 2 argument")
        else:
            num1 = evaluate(expr[1])
            num2 = evaluate(expr[2])
            if float(num1) > float(num2):
                return True
            else:
                return False
    
    #Evaluta expression and return whether the arguments are equal or not
    elif expr[0] == '==':
        if len(expr) > 3:
            print ("invalid expression, please enter only 2 argument")
        else:
            num1 = evaluate(expr[1])
            num2 = evaluate(expr[2])
            if float(num1) == float(num2):
                return True
            else:
                return False

    #Evalute all expressions in order and return the final value
    elif expr[0] == 'run':
        if len(expr) < 2:
            print ("invalid expression, please enter atleast 1 argument")
        else:
            x = None
            
            for i in range(1, len(expr)):
                x = evaluate(expr[i])
            return x

    #Compare the first expression and return the second argument if true and the third argument if false
    elif expr[0] == 'if':
        if len(expr) < 4:
            print ("invalid expression, please enter only 3 argument")
        else:
            if evaluate(expr[1]) == True:
                expr2 = evaluate(expr[2])
                return expr2
            else: 
                expr3 = evaluate(expr[3])
                return expr3

    #Assigning a value (second argument) to a variable (first arguemnt)
    elif expr[0] == 'let':
        if len(expr) > 3:
            print ("invalid expression, please enter only 2 argument")
        else:
            var = (expr[1])
            val = evaluate(expr[2])
            assign_var(var, val)
        
        

    #evaluate to the AST of the given argument, and assign a function to a variable
    elif expr[0] == 'lambda':
        if len(expr) > 2:
            print ("invalid expression, please enter only 1 argument")
        else:
            expr.pop(0)
            return expr[0]


    #Evaluate argument to an AST, and use a function call to return its value
    elif expr [0] == 'call':
        if len(expr) > 2:
            print ("invalid expression, please enter only 1 argument")
        else:
            return evaluate(evaluate(expr[1]))



        

def main():
    # The main function of our interpreter.
    # Read a program, parse it into its AST, and evaluate that AST.
    instr = read()
    AST = parse(instr)
    evaluate(AST)

    

if __name__ == '__main__':
    main()


