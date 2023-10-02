type t = REQUEST_WEIGHT | ORDERS | RAW_REQUESTS;;

let wrap = function
  |REQUEST_WEIGHT -> "REQUEST_WEIGHT"
  |ORDERS -> "ORDERS"
  |RAW_REQUESTS -> "RAW_REQUESTS";;

let unwrap = function
  |"REQUEST_WEIGHT" -> REQUEST_WEIGHT
  |"ORDERS" -> ORDERS
  |"RAW_REQUESTS" -> RAW_REQUESTS
  |_ -> raise Not_found;;