type t = SYMBOL of string | SYMBOLS of string list;;

let list_to_string symbols = "[" ^ String.concat "," symbols ^ "]";;

let string_to_list symbols = 
  let substring = String.(sub symbols 1 ((length symbols)-2)) 
  in String.split_on_char ',' substring;;

let wrap = function
  |SYMBOL symbol -> symbol
  |SYMBOLS symbols -> list_to_string symbols;;

let unwrap symbols = match String.get symbols 0 with
  |'A' .. 'Z' -> SYMBOL symbols
  |'[' -> SYMBOLS (string_to_list symbols)
  |_ -> SYMBOL "\"\"";;