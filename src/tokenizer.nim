import strutils

func tokenize*(input: string): seq[string] =
    var
        output: seq[string]
        temp: string
        mark = 0

    for i, c in input:
        if c == '-' and (i == 0 or input[i-1] == '(') and isDigit(input[i+1]):
            temp.add($c)
            mark = 1

        elif mark == 0 and isDigit(c):
            temp.add($c)
            mark = 1

        elif isDigit(c) or c == '.':
            temp.add($c)

        elif c in "+-*/()":
            if temp.len > 0:
                output.add(temp)
                temp = ""
                mark = 0
            output.add($c)
            
    if temp.len > 0: output.add(temp)
    
    output 
