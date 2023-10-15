type t = SYMBOL of string | SYMBOLS of string list;;

val wrap : t -> string

val unwrap : string -> t