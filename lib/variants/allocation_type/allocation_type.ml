type t = SOR;;

let wrap = function
  |SOR -> "SOR";;

let unwrap = function
  |"SOR" -> SOR
  |_ -> raise Not_found;;