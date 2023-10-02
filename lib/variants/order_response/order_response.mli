type t = ACK | RESULT | FULL;;

val wrap : t -> string

val unwrap : string -> t