type t = EXECUTING | ALL_DONE | REJECT

val wrap : t -> string

val unwrap : string -> t