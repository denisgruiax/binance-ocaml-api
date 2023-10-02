type t = RESPONSE | EXEC_STARTED | ALL_DONE;;

val wrap : t -> string

val unwrap : string -> t