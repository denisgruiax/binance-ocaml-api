type t = ONLY_NEW | ONLY_PARTIALLY_FILLED

val wrap : t -> string

val unwrap : string -> t