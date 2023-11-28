open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;


let url = Base_urls.api_default;;
let endpoint = Endpoints.Market_data.old_trade_lookup;;
let parameters = [
  ("symbol", "SOLUSDT");
  ("limit", "10");
];;

let check_trade = let open Old_trade_lookup in function
    |Ok {
        id = val1;
        price = val2;
        qty = val3;
        quote_qty = val4;
        time = val5;
        is_buyer_maker = _;
        is_best_match = _
      } -> let open Decimal in
      begin match (compare val1 zero, compare val2 zero, compare val3 zero, compare val4 zero, compare val5 zero) with
        |(1, 1, 1, 1, 1) -> true
        |_ -> false
      end
    |Error _ -> false;;

let check_list list_of_trades = List.fold_left (fun res elt -> (check_trade elt) && res) true list_of_trades;;

let get_older_trades () = let* older_trades = Old_trade_lookup.get ~base_url:url ~endpoint:endpoint ~parameters:parameters in
  Alcotest.(check bool "Test older trades." true (check_list older_trades));Lwt.return ();;

let test_get_older_trades switch () =
  Lwt_switch.add_hook (Some switch) get_older_trades; Lwt.return ();;

let suite () = "Older trade lookup",[
    Alcotest_lwt.test_case "Test older trades" `Quick test_get_older_trades
  ]