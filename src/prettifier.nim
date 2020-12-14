import strutils

proc prettify*(input: seq[string]): string =
    let str = input[0]
    let double = str.split('.')
    
    if double[1].parseInt == 0: return double[0]

    for i in countdown(str.len-1, 0):
        if str[i] != '0':
            return str[0 .. i] 
