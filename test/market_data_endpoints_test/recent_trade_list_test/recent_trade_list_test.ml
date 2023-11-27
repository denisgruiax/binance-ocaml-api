open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;

let check_trade = let open Recent_trade_list in function
    |Some {
        id = val1;
        price = val2;
        qty = val3;
        quote_qty = val4;
        time = val5;
        is_buyer_maker = _;
        is_best_match = _
      } -> begin 
        let open Decimal in   
        match (compare val1 zero, compare val2 zero, compare val3 zero, compare val4 zero, compare val5 zero) with
        |(1, 1, 1, 1, 1) -> true
        |_ -> false 
      end
    |None -> false;;

let check_list list_of_trades = List.fold_left (fun res elt -> (check_trade elt) && res) true list_of_trades;;

let base_url = Base_urls.api_default;;
let endpoint = Endpoints.Market_data.recent_trade_list;;
let parameters = [
  ("symbol", "BTCUSDT");
  ("limit", "10")
];;

let get_recent_trade_list () = let* recent_trades = Recent_trade_list.get ~base_url:base_url ~endpoint:endpoint ~parameters:parameters in
  let* () = Recent_trade_list.print_list recent_trades in  
  Alcotest.(check bool "Test recent trade list." true (check_list recent_trades));Lwt.return ();;

Lwt_main.run (get_recent_trade_list ());;

let test_get_recent_trade_list switch () =
  Lwt_switch.add_hook (Some switch) get_recent_trade_list;Lwt.return ();;

let suite () = "Recent trade list",[
    Alcotest_lwt.test_case "Test recent trade list." `Quick test_get_recent_trade_list
  ]