type t = GTC | IOC | FOK

val wrap : t -> string

val unwrap : string -> t