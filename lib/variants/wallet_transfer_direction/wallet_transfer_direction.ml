type t = MARGIN | SPOT;;

let wrap = function
  |MARGIN -> "1"
  |SPOT -> "2";;

let unwrap = function
  |"1" -> MARGIN
  |"2" -> SPOT
  |_ -> raise Not_found;;