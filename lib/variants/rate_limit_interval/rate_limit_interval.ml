type t = SECOND | MINUTE | DAY ;;

let wrap = function
  |SECOND -> "SECOND"
  |MINUTE -> "MINUTE"
  |DAY -> "DAY";;

let unwrap = function
  |"SECOND" -> SECOND
  |"MINUTE" -> MINUTE
  |"DAY" -> DAY
  |_ -> raise Not_found;;