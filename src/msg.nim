import strformat

const err = "\x1B[1m\x1B[31merror:\x1B[0m"

const errorArgs* = &"{err} Water does not take arguments"
const errorInvalid* = &"{err} invalid expression"
const waterOn* = "Water \x1B[34mon\x1B[0m"
const waterOff* = "Water \x1B[33moff\x1B[0m"
