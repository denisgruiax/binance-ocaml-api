let wrap = function
  |false -> "FALSE"
  |true -> "TRUE";;

let unwrap = function
  |"FALSE" -> false
  |"TRUE" -> true
  |_ -> raise Not_found