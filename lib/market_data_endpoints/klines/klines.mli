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
  
val get_candlesticks : base_url:string -> endpoint:string -> parameters:(string * string) list -> candlestick list Lwt.t
val get_open_times : base_url:string -> endpoint:string -> parameters:(string * string) list -> int list Lwt.t
val get_open_prices : base_url:string -> endpoint:string -> parameters:(string * string) list -> float list Lwt.t
val get_high_prices : base_url:string -> endpoint:string -> parameters:(string * string) list -> float list Lwt.t
val get_low_prices : base_url:string -> endpoint:string -> parameters:(string * string) list -> float list Lwt.t
val get_close_prices : base_url:string -> endpoint:string -> parameters:(string * string) list -> float list Lwt.t
val get_volumes : base_url:string -> endpoint:string -> parameters:(string * string) list -> float list Lwt.t
val get_close_times : base_url:string -> endpoint:string -> parameters:(string * string) list -> int list Lwt.t
val get_quote_asset_volumes : base_url:string -> endpoint:string -> parameters:(string * string) list -> float list Lwt.t
val get_number_of_trades : base_url:string -> endpoint:string -> parameters:(string * string) list -> int list Lwt.t
val get_taker_buy_base_asset_volumes : base_url:string -> endpoint:string -> parameters:(string * string) list -> float list Lwt.t
val get_taker_buy_quote_asset_volumes : base_url:string -> endpoint:string -> parameters:(string * string) list -> float list Lwt.t

val print_candlesticks : candlestick list -> unit