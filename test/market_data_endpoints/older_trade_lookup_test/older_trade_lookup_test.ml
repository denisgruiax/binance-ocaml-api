open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;
open Variants.Symbol;;

module Old_trade_lookup' = Old_trade_lookup.Make(struct
    let url = Base_urls.api_default
    let symbol = Symbol "SOLUSDT"
    let limit = 10
  end)

let check_trade = let open Old_trade_lookup' in function
    |{
      id = val1;
      price = val2;
      qty = val3;
      quoteQty = val4;
      time = val5;
      isBuyerMaker = _;
      isBestMatch = _
    } -> match (val1 > 0, val2 > 0.0, val3 > 0.0, val4 > 0.0, val5 > 0) with
      |(true, true, true, true, true) -> true
      |_ -> false;;

let check_list list_of_trades = List.fold_left (fun res elt -> (check_trade elt) && res) true list_of_trades;;

let get_older_trades () = let* older_trades = Old_trade_lookup'.get_older_trades () in
  Alcotest.(check bool "Test older trades." true (check_list older_trades));Lwt.return ();;

let test_get_older_trades switch () =
  Lwt_switch.add_hook (Some switch) get_older_trades; Lwt.return ();;

let suite () = "Older trade lookup",[
    Alcotest_lwt.test_case "Test older trades" `Quick test_get_older_trades
  ]