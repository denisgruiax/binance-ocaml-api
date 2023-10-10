type t = False | True;;

let wrap = function
  |False -> "FALSE"
  |True -> "TRUE";;

let unwrap = function
  |"FALSE" -> False
  |"TRUE" -> True
  |_ -> raise Not_found