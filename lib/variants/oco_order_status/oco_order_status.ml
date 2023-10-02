type t = EXECUTING | ALL_DONE | REJECT;;

let wrap = function
  |EXECUTING -> "EXECUTING"
  |ALL_DONE -> "ALL_DONE"
  |REJECT -> "REJECT";;

let unwrap = function
  |"EXECUTING" -> EXECUTING
  |"ALL_DONE" -> ALL_DONE
  |"REJECT" -> REJECT
  |_ -> raise Not_found;;