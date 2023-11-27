type t = ONLY_NEW | ONLY_PARTIALLY_FILLED;;

let wrap = function
  |ONLY_NEW -> "ONLY_NEW"
  |ONLY_PARTIALLY_FILLED -> "ONLY_PARTIALLY_FILLED";;

let unwrap = function
  |"ONLY_NEW" -> ONLY_NEW
  |"ONLY_PARTIALLY_FILLED" -> ONLY_PARTIALLY_FILLED
  |_ -> raise Not_found;;