type t = No_side_effect | Margin_buy | Auto_repay;;

val wrap : t -> string

val unwrap : string -> t