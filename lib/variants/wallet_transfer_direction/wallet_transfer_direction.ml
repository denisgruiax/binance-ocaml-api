type t = To_cross_margin_account | To_main_account;;

let wrap = function
  |To_cross_margin_account -> "1"
  |To_main_account -> "2";;

let unwrap = function
  |"1" -> To_cross_margin_account
  |"2" -> To_main_account
  |_ -> raise Not_found;;