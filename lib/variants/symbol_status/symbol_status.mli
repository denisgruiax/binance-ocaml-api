type symbol_status = PRE_TRADING | TRADING | POST_TRADING | END_OF_DAY 
                   | HALT | AUCTION_MATCH | BREAK

val wrap_symbol_status : symbol_status -> string

val unwrap_symbol_status : string -> symbol_status