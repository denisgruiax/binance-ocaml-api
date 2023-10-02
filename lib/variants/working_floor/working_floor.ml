type t = EXCHANGE | SOR;;

let wrap = function
  |EXCHANGE -> "EXCHANGE"
  |SOR -> "SOR";;

let unwrap = function
  |"EXCHANGE" -> EXCHANGE
  |"SOR" -> SOR
  |_ -> raise Not_found;;

  