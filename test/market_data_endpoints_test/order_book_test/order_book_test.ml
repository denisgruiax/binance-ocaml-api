open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;

let url = Base_urls.api_default;;
let endpoint = Endpoints.Market_data.order_book;;
let parameters = [
  ("symbol", "EGLDUSDT");
  ("limit", "10")
];;

let check_pair (x, y) = match (Decimal.(compare x zero), Decimal.(compare y zero)) with
  |1, 1 -> true
  |_ -> false;;

let check_list list_of_orders = List.fold_left (fun res elt -> (check_pair elt) && res) true list_of_orders;;

let check_depth = let open Order_book in function
    |Ok {
        last_update_id = last_update_id;
        bids = bids;
        asks = asks
      } -> if (last_update_id > Decimal.zero && check_list bids && check_list asks) 
      then true else false
    |Error _ -> false;;

let get_depth_data () = let* depth = Order_book.get_depth ~base_url:url ~endpoint:endpoint ~parameters:parameters in
  Alcotest.(check bool "Test depth data." true (check_depth depth)); Lwt.return ();;

let test_get_depth_data switch () = 
  Lwt_switch.add_hook (Some switch) get_depth_data; Lwt.return ();;

let suite () = "Order book",[
    Alcotest_lwt.test_case "Test depth data." `Quick test_get_depth_data
  ]