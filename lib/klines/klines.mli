module type CandleStick = sig
  type candlestick
  val endpoint : string
  val interval : string
  val get_candlesticks : unit -> candlestick list
  val print_candlesticks : candlestick list -> unit
end  

module Make : functor (Endpoint : sig val klines_url : string end)
                        (Pair : sig val symbol : string end) 
                        (Interval : sig val size : string end) -> CandleStick