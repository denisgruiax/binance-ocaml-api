type symbol_status = PRE_TRADING | TRADING | POST_TRADING | END_OF_DAY 
                   | HALT | AUCTION_MATCH | BREAK;;

let wrap_symbol_status = function
  |PRE_TRADING -> "PRE_TRADING"
  |TRADING -> "TRADING"
  |POST_TRADING -> "POST_TRADING"
  |END_OF_DAY -> "END_OF_DAY"
  |HALT -> "HALT"
  |AUCTION_MATCH -> "AUCTION_MATCH"
  |BREAK -> "BREAK";;

let unwrap_symbol_status = function
  |"PRE_TRADING" -> PRE_TRADING
  |"TRADING" -> TRADING
  |"POST_TRADING" -> POST_TRADING
  |"END_OF_DAY" -> END_OF_DAY
  |"HALT" -> HALT
  |"AUCTION_MATCH" -> AUCTION_MATCH
  |"BREAK" -> BREAK
  |_ -> raise Not_found;;