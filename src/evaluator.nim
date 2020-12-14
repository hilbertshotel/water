import sequtils
import strutils


# UTILITY FUNCTIONS
func numberOfBrackets*(input: string): int =
    input.filter(func(c: char): bool = c in "()").len

func numberOfBrackets*(input: seq[string]): int =
    input.filter(func(s: string): bool = s in ["(", ")"]).len

template calcAndInsert(exp: seq[string], i: int, op: untyped): seq[string] =
    let calc = op(exp[i-1].parseFloat, exp[i+1].parseFloat)
    exp[0 .. (i-2)] & calc.formatFloat & exp[(i+2) .. ^1]


# MAIN FUNCTIONS
func evaluate(input: seq[string]): seq[string] =
    var
        exp = input
        num = exp.filter(func(s: string): bool = s in ["*", "/"]).len

    # evaluate multiplication and division
    while num > 0:
        for i, str in exp:
            if str == "*":
                exp = calcAndInsert(exp, i, `*`)
                num -= 1
                break

            elif str == "/":
                exp = calcAndInsert(exp, i, `/`)
                num -= 1
                break
    
    # evaluate addition and subtraction
    num = exp.filter(func(s: string): bool = s in ["+", "-"]).len
    while num > 0:
        for i, str in exp:
            if str == "+":
                exp = calcAndInsert(exp, i, `+`)
                num -= 1
                break
            
            elif str == "-":
                exp = calcAndInsert(exp, i, `-`)
                num -= 1
                break
    
    return exp


func evaluateExpression*(input: seq[string]): seq[string] =
    if input.len == 1: return input
    if input.numberOfBrackets == 0: return input.evaluate

    # pick a bracketed expression to evaluate
    var
        mark = 0
        exp = input

    for i, s in input:
        if s == "(":
            mark = i
        
        elif s == ")":
            let inner = input[mark+1 .. i-1].evaluate
            exp = input[0 .. mark-1] & inner & input[i+1 .. ^1]
            return exp.evaluateExpression
