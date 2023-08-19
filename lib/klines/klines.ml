module type CandleStick = sig
  type candlestick
  val endpoint : string
  val interval : string
  val get_candlesticks : unit -> candlestick list
  val get_list_of_open_price : unit -> float list
  val print_candlesticks : candlestick list -> unit
end;;

module type Parameters = sig
  val klines_url : string
  val symbol : string
  val size : string
end

module Make(P : Parameters) : CandleStick = struct
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

  let endpoint = P.klines_url ^ "?symbol=" ^ P.symbol ^ "&interval=" ^ P.size;;

  let interval = P.size;;

  let get_json_from_api_url endpoint = 
    let ezjsonm =
      Lwt.bind
        (Cohttp_lwt_unix.Client.get (Uri.of_string endpoint))
        (fun (_, body) ->
           Lwt.bind (Cohttp_lwt.Body.to_string body) (fun body_string ->
               let json = Ezjsonm.from_string body_string in
               Lwt.return json))
    in
    Lwt_main.run ezjsonm;;

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

  let parse_kline_data json  = let rec parse_kline_data' json acc = match json with
      |`A (`A head :: tail) -> parse_kline_data' (`A tail) ((get_data head) :: acc)
      |_ -> acc in parse_kline_data' json [];;

  let get_candlesticks () = parse_kline_data (get_json_from_api_url endpoint);;

  let get_list_of_open_price () = let candlesticks = get_candlesticks () in
    let rec get_list_of_open_price' candlesticks acc = match candlesticks with
      |[] -> List.rev acc
      |head::tail -> get_list_of_open_price' tail (head.open_price::acc) in get_list_of_open_price' candlesticks [];;

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
    } -> Printf.printf "%i %0.2f %0.2f %0.2f %0.2f %0.2f %i %0.2f %i %0.2f %0.2f" open_time open_price high_price low_price close_price volume
           close_time quote_asset_volume number_of_trades taker_buy_base_asset_volume taker_buy_quote_asset_volume

  let print_candlesticks candlestick_list = let rec print_inner_lists' candlestick_list = match candlestick_list with
      |[] -> ()
      |l0::ln -> print_candlestick l0 ; print_newline (); print_inner_lists' ln in print_inner_lists' candlestick_list;;
  ;;
end