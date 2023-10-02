type t = BUY | SELL;;

let wrap = function
  |BUY -> "BUY"
  |SELL -> "SELL";;

let wrap = function
  |"BUY" -> BUY
  |"SELL" -> SELL
  |_ -> raise Not_found;;