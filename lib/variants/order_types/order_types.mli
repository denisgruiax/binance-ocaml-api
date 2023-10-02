type t = LIMIT | MARKET | STOP_LOSS | STOP_LOSS_LIMIT 
                 | TAKE_PROFIT | TAKE_PROFIT_LIMIT | LIMIT_MAKER

val wrap : t -> string

val unwrap : string -> t