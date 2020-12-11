# UTILITY FUNCTIONS
def isBracket(char):
    return char in "()"

def lenBrackets(input):
    return len([x for x in input if isBracket(x)])

def bracketPosition(input, positions):
    for index, char in enumerate(input):
        if isBracket(char): positions.append(index)
    return positions


# MAIN FUNCTIONS
def insert(result, input):
    for index, char in enumerate(input):
        if char == 'x':
            input[index] = result
            return input


def evaluate(exp):
   # handle multiplication and division
    for index, char in enumerate(exp): 
        if char == '*':
            result = int(exp[index-1]) * int(exp[index+1])
            exp = [ *exp[:index-1], str(result), *exp[index+2:] ]
        elif char == '/':
            result = int(exp[index-1]) / int(exp[index+1])
            exp = [ *exp[:index-1], str(result), *exp[index+2:] ]
        
    # handle addition and subtraction
    for index, char in enumerate(exp):
        if char == '+':
            result = int(exp[index-1]) + int(exp[index+1])
            exp = [ *exp[:index-1], str(result), *exp[index+2:] ]
        elif char == '-':
            result = int(exp[index-1]) - int(exp[index+1])
            exp = [ *exp[:index-1], str(result), *exp[index+2:] ]

    return exp[0]


def parse(input):
    # validate lengths
    if len(input) == 1: return input[0]
    if lenBrackets(input) == 0: return evaluate(input)
        
    # get index positions of brackets
    positions = bracketPosition(input, [])
    mid = len(positions) // 2
    left = positions[mid-1]
    right = positions[mid]

    # evaluate inner most expression
    innerExp = input[left+1:right]
    result = evaluate(innerExp)

    # insert result back into input
    input = [ *input[:left], 'x', *input[right+1:] ]
    output = insert(result, input)
   
    return parse(output)


def main():
    # input = ['(', '(', '7', '*', '1', '+', '7', ')'] # already tokenized
    while 1:
        inpt = input(":: ")
        
        if lenBrackets(inpt) % 2 != 0:
            print("invalid expression")
            break
    
        try:
            output = parse(inpt)
        except:
            print("invalid expression")
            break

        print(output)


main()
