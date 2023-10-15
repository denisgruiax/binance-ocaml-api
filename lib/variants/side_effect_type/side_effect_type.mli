type t = NO_SIDE_EFFECT | MARGIN_BUY | AUTO_REPAY;;

val wrap : t -> string

val unwrap : string -> t