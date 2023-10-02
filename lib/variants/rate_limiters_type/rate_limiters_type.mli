type t = REQUEST_WEIGHT | ORDERS | RAW_REQUESTS;;

val wrap : t -> string

val unwrap : string -> t