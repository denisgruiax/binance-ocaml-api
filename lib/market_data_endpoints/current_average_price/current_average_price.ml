open Utilities;;
open Lwt.Infix;;

module type Parameters = sig
  val url : string
  val symbol : string
end

module type Current_average_price' = sig
  type t = {
    mins : int;
    price : float
  }

  val get_current_average_price : unit -> t Lwt.t
end

module Make(P : Parameters) : Current_average_price' = struct
  type t = {
    mins : int;
    price : float
  };;

  let parameters = [
    ("symbol", P.symbol)
  ];;

  let endpoint = Url.build_public P.url "/api/v3/avgPrice" parameters;;

  let get_data = function
    |fields -> {
        mins = Ezjsonm.(find fields ["mins"] |> get_float |> int_of_float);
        price = Ezjsonm.(find fields ["price"] |> get_string |> float_of_string)
      }

  let parse_data json = json >>= fun json' -> Lwt.return (get_data json');;

  let get_current_average_price () = parse_data (Requests.get endpoint);;
end