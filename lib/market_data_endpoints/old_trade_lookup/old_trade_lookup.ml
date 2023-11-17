open Utilities;;
open Lwt.Infix;;
open Variants;;
module type Parameters = sig
  val url : string
  val symbol : Symbol.t
  val limit : int
  val from_id : int
end

module type Old_trade_lookup' = sig
  type t = {
    id : int;
    price : float;
    qty : float;
    quote_quantity : float;
    time : int;
    is_buyer_maker : bool;
    is_best_match : bool
  }

  val get_older_trades : unit -> t list Lwt.t
end

module Make(P : Parameters) : Old_trade_lookup' = struct
  type t = {
    id : int;
    price : float;
    qty : float;
    quote_quantity : float;
    time : int;
    is_buyer_maker : bool;
    is_best_match : bool
  };;

  let parameters = let open P in [
      ("symbol", Symbol.wrap symbol);
      ("limit", string_of_int(Url.check_limit 1 1000 500 limit));
      ("fromId", string_of_int P.from_id)
    ];;

  let endpoint = Url.build_public P.url "/api/v3/historicalTrades" parameters;;

  let get_data = function
    |fields
      -> {
          id = int_of_float (Ezjsonm.(find fields ["id"] |> get_float));
          price = float_of_string Ezjsonm.(find fields ["price"] |> get_string);
          qty = float_of_string  Ezjsonm.(find fields ["qty"] |> get_string);
          quote_quantity = float_of_string Ezjsonm.(find fields ["quoteQty"] |> get_string);
          time = int_of_float (Ezjsonm.(find fields ["time"] |> get_float));
          is_buyer_maker = Ezjsonm.(find fields ["isBuyerMaker"] |> get_bool);
          is_best_match = Ezjsonm.(find fields ["isBestMatch"] |> get_bool);
        };;

  let parse_recent_trade_list json = 
    json >>= fun json' -> Lwt.return (Data.get_list get_data json');;

  let get_older_trades () = parse_recent_trade_list (Requests.get endpoint);;
end