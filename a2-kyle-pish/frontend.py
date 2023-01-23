# frontend.py
# Author: Mark Liffiton
# Date: Sep, 2022
#
# Functions implementing the front-end of the interpreter for CS355 A2
#
import sys


def read():
    # Read an entire file into a string
    # Either reads from a file if a filename is given on the commandline or from stdin if not
    try:
        fileobj = open(sys.argv[1], 'r')
    except IndexError:
        fileobj = sys.stdin
    with fileobj as f:
        return f.read()


def parse(string):
    # Tokenize and parse a program string into an AST.
    # Expression nodes in the AST are represented as lists,
    # with each component of the expression a separate element in the list.

    # Ensure parentheses are split from other tokens
    string = string.replace('(', ' ( ')
    string = string.replace(')', ' ) ')
    # Simply split the entire program on any whitespace to get a list of tokens
    tokens = string.split()

    # Use a stack to iteratively parse the tokens into an AST
    struc = []
    cur = struc
    stack = []
    stack.append(cur)

    for part in tokens:
        if part == '(':
            new = []
            cur.append(new)
            cur = new
            stack.append(cur)
        elif part == ')':
            stack.pop()
            cur = stack[-1]
        else:
            cur.append(part)

    assert len(struc) == 1, "Invalid program.  A valid program contains exactly one ( ) expression at the outermost level."
    # return the one expression of the program
    return struc[0]
