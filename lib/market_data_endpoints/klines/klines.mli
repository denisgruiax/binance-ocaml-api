module type Parameters = sig
  val url : string
  val symbol : string
  val interval : string
  val startTime : int
  val endTime : int
  val limit : int
end

module type CandleStick = sig
  type candlestick = {
    open_time : int;
    open_price : float;
    high_price : float;
    low_price : float;
    close_price : float;
    volume : float;
    close_time : int;
    quote_asset_volume : float;
    number_of_trades : int;
    taker_buy_base_asset_volume : float;
    taker_buy_quote_asset_volume : float
  }
  
  val endpoint : string
  val interval : string
  val get_candlesticks : unit -> candlestick list Lwt.t
  val get_open_times : unit -> int list Lwt.t
  val get_open_prices : unit -> float list Lwt.t
  val get_high_prices : unit -> float list Lwt.t
  val get_low_prices : unit -> float list Lwt.t
  val get_close_prices : unit -> float list Lwt.t
  val get_volumes : unit -> float list Lwt.t
  val get_close_times : unit -> int list Lwt.t
  val get_quote_asset_volumes : unit -> float list Lwt.t
  val get_number_of_trades : unit -> int list Lwt.t
  val get_taker_buy_base_asset_volumes : unit -> float list Lwt.t
  val get_taker_buy_quote_asset_volumes : unit -> float list Lwt.t

  val print_candlesticks : candlestick list -> unit
end  

module Make : functor (P : Parameters) -> CandleStick