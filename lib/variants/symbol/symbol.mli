type t = Symbol of string | Symbols of string list;;

val wrap : t -> string

val unwrap : string -> t