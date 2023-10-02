type t = PRE_TRADING | TRADING | POST_TRADING | END_OF_DAY 
                   | HALT | AUCTION_MATCH | BREAK

val wrap : t -> string

val unwrap : string -> t