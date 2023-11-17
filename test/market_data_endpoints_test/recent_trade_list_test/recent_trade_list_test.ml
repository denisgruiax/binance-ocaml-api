open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;
open Variants.Symbol;;
module Recent_trade_list' = Recent_trade_list.Make(struct
    let url = Base_urls.api_default
    let symbol = SYMBOL "BNBUSDT"
      let limit = 10
  end)

let check_trade = let open Recent_trade_list' in function
    |{
      id = val1;
      price = val2;
      qty = val3;
      quote_quantity = val4;
      time = val5;
      is_buyer_maker = _;
      is_best_match = _
    } -> match (val1 > 0, val2 > 0.0, val3 > 0.0, val4 > 0.0, val5 > 0) with
      |(true, true, true, true, true) -> true
      |_ -> false;;

let check_list list_of_trades = List.fold_left (fun res elt -> (check_trade elt) && res) true list_of_trades;;

let get_recent_trade_list () = let* recent_trades = Recent_trade_list'.get_recent_trade_list () in
  Alcotest.(check bool "Test recent trade list." true (check_list recent_trades));Lwt.return ();;

let test_get_recent_trade_list switch () =
  Lwt_switch.add_hook (Some switch) get_recent_trade_list;Lwt.return ();;

let suite () = "Recent trade list",[
    Alcotest_lwt.test_case "Test recent trade list." `Quick test_get_recent_trade_list
  ]