type t = OCO;;

let wrap =  function
  |OCO -> "OCO";;

let unwrap = function
  |"OCO" -> OCO
  |_ -> raise Not_found;;