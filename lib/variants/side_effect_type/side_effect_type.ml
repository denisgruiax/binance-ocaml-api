type t = No_side_effect | Margin_buy | Auto_repay;;

let wrap = function
  |No_side_effect -> "NO_SIDE_EFFECT"
  |Margin_buy -> "MARGIN_BUY"
  |Auto_repay -> "AUTO_REPAY";;

let unwrap = function
  |"NO_SIDE_EFFECT" -> No_side_effect
  |"MARGIN_BUY" -> Margin_buy
  |"AUTO_REPAY" -> Auto_repay
  |_ -> raise Not_found;;