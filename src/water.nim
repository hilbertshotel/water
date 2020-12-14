import os
import rdstdin

import msg
import tokenizer
import evaluator
import prettifier


proc on() =
    echo msg.waterOn
    while true:
        let input = readLineFromStdin(":: ")
        case input:
        of "": continue
        of ":q": break
        else:

            # validate number of brackets
            if numberOfBrackets(input) mod 2 != 0:
                echo errorInvalid
                continue
            
            # tokenize
            var tokens: seq[string]
            try:
                tokens = tokenizer.tokenize(input)
            except:
                echo errorInvalid
                continue
            
            # evaluate
            var evaluation: seq[string]
            try:
                evaluation = evaluator.evaluateExpression(tokens)
            except:
                echo errorInvalid
                continue
            
            # prettify
            echo prettifier.prettify(evaluation)

    echo msg.waterOff


proc main() =
    let args = commandLineParams()
    case args.len:
    of 0: on()
    else: echo msg.errorArgs


main()
