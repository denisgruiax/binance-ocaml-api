open Utilities;;
open Lwt.Infix;;

type t = {
  last_update_id : Decimal.t;
  bids : (Decimal.t * Decimal.t) list;
  asks : (Decimal.t * Decimal.t) list
};;

let get_data = let open Decimal in function 
    |[`String val1; `String val2] -> (of_string val1 , of_string val2)
    |_ -> (zero, zero) ;;

let get_depth_data = function
  |`O[
      ("lastUpdateId", `Float last_update_id);
      ("bids", bids);
      ("asks", asks)
    ] -> Some {
      last_update_id = Decimal.of_string (string_of_float last_update_id);
      bids = Data.get_list_from_list get_data bids;
      asks = Data.get_list_from_list get_data asks        
    }
  |_ -> None;;

let parse_depth_data json = 
  json >>= fun json' -> Lwt.return(get_depth_data json');; 

let get_depth ~base_url:base_url ~endpoint:endpoint ~parameters:parameters = 
  parse_depth_data (Requests.get (Url.build_public base_url endpoint parameters));;