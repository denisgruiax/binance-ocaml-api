open Utilities;;
open Lwt.Infix;;

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
};;

let get_data = function
  |[`Float open_time; `String open_price; `String high_price; `String low_price;
    `String close_price; `String volume; `Float close_time; `String quote_asset_volume;
    `Float number_of_trades; `String taker_buy_base_asset_volume; `String taker_buy_quote_asset_volume; _] -> 
    {
      open_time = (int_of_float open_time);
      open_price = (float_of_string open_price);
      high_price = (float_of_string high_price);
      low_price = (float_of_string low_price);
      close_price = (float_of_string close_price);
      volume = (float_of_string volume);
      close_time = (int_of_float close_time);
      quote_asset_volume = (float_of_string quote_asset_volume);
      number_of_trades = (int_of_float number_of_trades);
      taker_buy_base_asset_volume = (float_of_string taker_buy_base_asset_volume);
      taker_buy_quote_asset_volume = (float_of_string taker_buy_quote_asset_volume)
    }
  |_ -> 
    {
      open_time = 0;
      open_price = 0.0;
      high_price = 0.0;
      low_price = 0.0;
      close_price = 0.0;
      volume = 0.0;
      close_time = 0;
      quote_asset_volume = 0.0;
      number_of_trades = 0;
      taker_buy_base_asset_volume = 0.0;
      taker_buy_quote_asset_volume = 0.0
    };; 

let parse_kline_data json = 
  json >>= fun json' -> Lwt.return (Data.get_list_from_list get_data json');;

let get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = parse_kline_data (Requests.get (Url.build_public base_url endpoint parameters));;

let get_open_times ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.open_time)) candlesticks;;

let get_open_prices ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.open_price)) candlesticks;;

let get_high_prices ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.high_price)) candlesticks;;

let get_low_prices ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.low_price)) candlesticks;;

let get_close_prices ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.close_price)) candlesticks;;

let get_volumes ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.volume)) candlesticks;;

let get_close_times ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.close_time)) candlesticks;;

let get_quote_asset_volumes ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.quote_asset_volume)) candlesticks;;

let get_number_of_trades ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.number_of_trades)) candlesticks;;

let get_taker_buy_base_asset_volumes ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.taker_buy_base_asset_volume)) candlesticks;;

let get_taker_buy_quote_asset_volumes ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  get_candlesticks ~base_url:base_url ~endpoint:endpoint ~parameters:parameters 
  >>= fun candlesticks -> Lwt_list.map_p (fun candlestick -> Lwt.return (candlestick.taker_buy_quote_asset_volume)) candlesticks;;


let print_candlestick = function
  |{
    open_time;
    open_price;
    high_price;
    low_price;
    close_price;
    volume;
    close_time;
    quote_asset_volume;
    number_of_trades;
    taker_buy_base_asset_volume;
    taker_buy_quote_asset_volume
  } -> Printf.printf "%i %0.2f %0.2f %0.2f %0.2f %0.2f %i %0.2f %i %0.2f %0.2f\n" open_time open_price high_price low_price close_price volume
         close_time quote_asset_volume number_of_trades taker_buy_base_asset_volume taker_buy_quote_asset_volume

let print_candlesticks candlesticks = List.iter print_candlestick candlesticks;;