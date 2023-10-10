type t = Symbol of string | Symbols of string list;;

let list_to_string symbols = "[" ^ String.concat "," symbols ^ "]";;

let string_to_list symbols = 
  let substring = String.(sub symbols 1 ((length symbols)-2)) 
  in String.split_on_char ',' substring;;

let wrap = function
  |Symbol symbol -> symbol
  |Symbols symbols -> list_to_string symbols;;

let unwrap symbols = match String.get symbols 0 with
  |'A' .. 'Z' -> Symbol symbols
  |'[' -> Symbols (string_to_list symbols)
  |_ -> Symbol "\"\"";;