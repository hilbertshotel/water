import os
import rdstdin

include messages
include lexer


proc on() =
  echo waterOn
  while true:
    let input = readLineFromStdin(":: ")
    case input:
    of "": continue
    of ":q": break
    else: echo tokenize(input)
  echo waterOff


proc main() =
  let args = commandLineParams()
  case args.len:
  of 0: on()
  else: echo doesNotTake


main()
