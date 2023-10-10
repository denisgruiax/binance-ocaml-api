type t = To_cross_margin_account | To_main_account

val wrap : t -> string

val unwrap : string -> t 