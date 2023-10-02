type t = RESPONSE | EXEC_STARTED | ALL_DONE;;

let wrap = function
  |RESPONSE -> "RESPONSE"
  |EXEC_STARTED -> "EXEC_STARTED"
  |ALL_DONE -> "ALL_DONE";;

let unwrap = function
  |"RESPONSE" -> RESPONSE
  |"EXEC_STARTED" -> EXEC_STARTED
  |"ALL_DONE" -> ALL_DONE
  |_ -> raise Not_found;;