open Utilities;;
open Lwt.Infix;;

module type Parameters = sig
  val url : string
  val symbol : string
  val limit : int
end

module type Old_trade_lookup' = sig
  type t = {
    id : int;
    price : float;
    qty : float;
    quoteQty : float;
    time : int;
    isBuyerMaker : bool;
    isBestMatch : bool
  }

  val get_older_trades : unit -> t list Lwt.t
end

module Make(P : Parameters) : Old_trade_lookup' = struct
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

  let endpoint = Url.build_public P.url "/api/v3/historicalTrades" parameters;;

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

  let get_list_of_data data = let rec get_list_of_data' data acc = match data with
      |`A( head :: tail) -> get_list_of_data' (`A tail) (get_data head :: acc)
      |_ -> List.rev acc
    in get_list_of_data' data [];;
  ;;

  let parse_recent_trade_list json = 
    json >>= fun json' -> Lwt.return (get_list_of_data json');;



  let get_older_trades () = parse_recent_trade_list (Requests.get endpoint);;
end