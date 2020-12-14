import strutils

proc prettify*(input: seq[string]): string =
    let str = input[0]
    let double = str.split('.')
    
    if double[1].parseInt == 0:
        double[0]
    else:
        str
