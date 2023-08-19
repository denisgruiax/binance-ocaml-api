module type CandleStick = sig
  type candlestick
  val endpoint : string
  val interval : string
  val get_candlesticks : unit -> candlestick list
  val get_list_of_open_price : unit -> float list
  val print_candlesticks : candlestick list -> unit
end  

module type Parameters = sig
  val klines_url : string
  val symbol : string
  val size : string
end

module Make : functor (P : Parameters) -> CandleStick