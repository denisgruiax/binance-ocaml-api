open Utilities;;
open Lwt.Infix;;

module type Parameters = sig
  val url : string
  val symbol : string
  val limit : int
end

module type Recent_trade_list' = sig
  type t = {
    id : int;
    price : float;
    qty : float;
    quoteQty : float;
    time : int;
    isBuyerMaker : bool;
    isBestMatch : bool
  }

  val get_recent_trade_list : unit -> t list Lwt.t
end

module Make(P : Parameters) : Recent_trade_list' = struct
  type t = {
    id : int;
    price : float;
    qty : float;
    quoteQty : float;
    time : int;
    isBuyerMaker : bool;
    isBestMatch : bool
  };;

  let parameters = let open P in [
      ("symbol", symbol);
      ("limit", string_of_int(Url.check_limit 1 1000 500 limit))
    ];;

  let endpoint = Url.build_public P.url "/api/v3/trades" parameters;;

  let get_data = function
    |fields
      -> {
          id = int_of_float (Ezjsonm.(find fields ["id"] |> get_float));
          price = float_of_string Ezjsonm.(find fields ["price"] |> get_string);
          qty = float_of_string  Ezjsonm.(find fields ["qty"] |> get_string);
          quoteQty = float_of_string  Ezjsonm.(find fields ["quoteQty"] |> get_string);
          time = int_of_float (Ezjsonm.(find fields ["time"] |> get_float));
          isBuyerMaker = Ezjsonm.(find fields ["isBuyerMaker"] |> get_bool);
          isBestMatch = Ezjsonm.(find fields ["isBestMatch"] |> get_bool);
        }

  let parse_recent_trade_list json = 
    json >>= fun json' -> Lwt.return (Data.get_list get_data json');;

  let get_recent_trade_list () = parse_recent_trade_list (Requests.get endpoint);;
end