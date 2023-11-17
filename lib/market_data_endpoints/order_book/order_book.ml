open Utilities;;
open Lwt.Infix;;
open Variants;;

module type Parameters = sig
  val url : string
  val symbol : Symbol.t
  val limit : int
end

module type Order_book' = sig
  type t = {
    last_update_id : int;
    bids_t : (float * float) list;
    asks_t : (float * float) list
  }

  val get_depth : unit -> t Lwt.t
end

module Make(P : Parameters) : Order_book' = struct
  type t = {
    last_update_id : int;
    bids_t : (float * float) list;
    asks_t : (float * float) list
  };;

  let parameters = let open P in [
      ("symbol", Symbol.wrap symbol);
      ("limit", string_of_int(Url.check_limit 1 5000 100 limit))
    ];;

  let endpoint = Url.build_public P.url "/api/v3/depth" parameters;; 

  let get_data = function 
    |[`String val1; `String val2] -> (float_of_string val1 , float_of_string val2)
    |_ -> (0.0, 0.0) ;;

  let get_depth_data = function
    |fields -> {
        last_update_id = Ezjsonm.find fields ["lastUpdateId"] |> Ezjsonm.get_float |> int_of_float;
        bids_t = Ezjsonm.find fields ["bids"] |> Data.get_list_from_list get_data;
        asks_t = Ezjsonm.find fields ["asks"] |> Data.get_list_from_list get_data
      };;

  let parse_depth_data json = 
    json >>= fun json' -> Lwt.return(get_depth_data json');; 

  let get_depth () = parse_depth_data (Requests.get endpoint);;
end