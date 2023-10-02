type t = GTC | IOC | FOK;;

let wrap = function
  |GTC -> "GTC"
  |IOC -> "IOC"
  |FOK -> "FOK";;

let unwrap = function
  |"GTC" -> GTC
  |"IOC" -> IOC
  |"FOK" -> FOK
  |_-> raise Not_found;;