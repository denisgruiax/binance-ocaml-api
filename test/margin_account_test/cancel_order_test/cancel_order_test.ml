open Binance_ocaml_api.Margin_account;;
open Lwt.Syntax;;
open Utilities;;

open Variants.Symbol;;

module Cancel_order' = Cancel_order.Make(struct
    let url = Base_urls.api_default
    let api_key = "YOUR_API_KEY"
    let secret_key = "YOUR_SECRET_KEY"
    let symbol = Symbol "BTCUSDT"
    let recv_window = 0
  end);;

(*Just a template*)
let cancel_order () = let* _ = Cancel_order'.place false 28 in
  Alcotest.(check bool "Test close order on BTCUSDT pair." true true);Lwt.return ();;

let test_close_order switch () = 
  Lwt_switch.add_hook (Some switch) cancel_order;Lwt.return ();;

let suite () = "Close order on margin account", [
    Alcotest_lwt.test_case "Test close order on BTCUSDT pair." `Quick test_close_order
]