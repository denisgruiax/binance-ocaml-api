open Utilities;;
open Lwt.Infix;;
open Lwt.Syntax;;

type t = {
  id : Decimal.t;
  price : Decimal.t;
  qty : Decimal.t;
  quote_qty : Decimal.t;
  time : Decimal.t;
  is_buyer_maker : bool;
  is_best_match : bool
};;

let get_data = function
  |`O[
      ("id", `Float id);
      ("price", `String price);
      ("qty", `String qty);
      ("quoteQty", `String quote_qty);
      ("time", `Float time);
      ("isBuyerMaker", `Bool is_buyer_maker);
      ("isBestMatch", `Bool is_best_match);
    ] -> Ok {
      id = Decimal.of_string (string_of_float id);
      price = Decimal.of_string price;
      qty = Decimal.of_string qty;
      quote_qty = Decimal.of_string quote_qty;
      time = Decimal.of_string (string_of_float time);
      is_buyer_maker = is_buyer_maker;
      is_best_match = is_best_match
    }
  |error -> Error (Error_code.get error);;

let printl = function
  |Ok {
      id = id;
      price = price;
      qty = qty;
      quote_qty = quote_qty;
      time = time;
      is_buyer_maker = is_buyer_maker;
      is_best_match = is_best_match
    } -> let* () = Lwt_io.printl (Decimal.to_string id) in
    let* () = Lwt_io.printl (Decimal.to_string price) in
    let* () = Lwt_io.printl (Decimal.to_string qty) in
    let* () = Lwt_io.printl (Decimal.to_string quote_qty) in
    let* () = Lwt_io.printl (Decimal.to_string time) in
    let* () = Lwt_io.printl (string_of_bool is_buyer_maker) in
    let* () = Lwt_io.printl (string_of_bool is_best_match) in
    Lwt_io.printl ""
  |Error error -> Error_code.printl error;;

let print_list t_list = Lwt_list.iter_s (printl) t_list;;

let parse_recent_trade_list json = 
  json >>= fun json' -> Lwt.return (Data.get_list get_data json');;

let get ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = parse_recent_trade_list (Requests.get (Url.build_public base_url endpoint parameters));;