type t = BUY | SELL;;

let wrap = function
  |BUY -> "BUY"
  |SELL -> "SELL";;

let unwrap = function
  |"BUY" -> BUY
  |"SELL" -> SELL
  |_ -> raise Not_found;;