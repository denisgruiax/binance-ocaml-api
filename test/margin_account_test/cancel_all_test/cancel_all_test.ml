open Binance_ocaml_api.Margin_account;;
open Lwt.Syntax;;
open Utilities;;

open Variants.Symbol;;

module Cancel_all' = Cancel_all.Make(struct
    let url = Base_urls.api_default
    let api_key = "YOUR_API_KEY"
    let secret_key = "YOUR_SECRET_KEY"
    let symbol = SYMBOL "BTCUSDT"
    let recv_window = 0
  end);;

let cancel_all () = let* response = Cancel_all'.place false in
  Alcotest.(check bool "Test cancel all open order on BTCUSDT symbol" false response); Lwt.return ();;

let test_cancell_all switch () = 
  Lwt_switch.add_hook (Some switch) cancel_all; Lwt.return ();;

let suite ()  = "Cancel all open orders", [
    Alcotest_lwt.test_case "Test cancel all open order on BTCUSDT symbol" `Quick test_cancell_all
  ]