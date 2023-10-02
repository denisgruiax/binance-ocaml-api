type t = ACK | RESULT | FULL;;

let wrap = function
  |ACK -> "ACK"
  |RESULT -> "RESULT"
  |FULL -> "FULL";;

let unwrap = function
  |"ACK" -> ACK
  |"RESULT" -> RESULT
  |"FULL" -> FULL
  |_ -> raise Not_found;;
