type t = NO_SIDE_EFFECT | MARGIN_BUY | AUTO_REPAY;;

let wrap = function
  |NO_SIDE_EFFECT -> "NO_SIDE_EFFECT"
  |MARGIN_BUY -> "MARGIN_BUY"
  |AUTO_REPAY -> "AUTO_REPAY";;

let unwrap = function
  |"NO_SIDE_EFFECT" -> NO_SIDE_EFFECT
  |"MARGIN_BUY" -> MARGIN_BUY
  |"AUTO_REPAY" -> AUTO_REPAY
  |_ -> raise Not_found;;