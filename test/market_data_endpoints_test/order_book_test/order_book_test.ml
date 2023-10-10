open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;
open Variants.Symbol;;

module Order_book'  = Order_book.Make(struct
    let url = Base_urls.api_default
    let symbol = Symbol "EGLDUSDT"
    let limit = 10 
  end)

let check_pair (x, y) = match (x > 0.0, y > 0.0) with
  |true, true -> true
  |_ -> false;;

let check_list list_of_orders = List.fold_left (fun res elt -> (check_pair elt) && res) true list_of_orders;;

let check_depth = let open Order_book' in function
    |{lastUpdateId = val1; 
      bids_t = bids;
      asks_t = asks}
      -> if (val1 > 0 && check_list bids && check_list asks) 
      then true else false;;

let get_depth_data () = let* depth = Order_book'.get_depth () in
  Alcotest.(check bool "Test depth data." true (check_depth depth)); Lwt.return ();;

let test_get_depth_data switch () = 
  Lwt_switch.add_hook (Some switch) get_depth_data; Lwt.return ();;

let suite () = "Order book",[
    Alcotest_lwt.test_case "Test depth data." `Quick test_get_depth_data
  ]