open Binance_ocaml_api.Margin_account;;
open Lwt.Syntax;;
open Utilities;;

open Variants.Symbol;;
open Variants.Wallet_transfer_direction;;

module Transfer = Cross_margin_account_transfer.Make(struct
    let url = Base_urls.api_default  
    let api_key = "YOUR_BINANCE_API_KEY"
    let secret_key = "YOUR_BINANCE_SECRET_KEY"
    let asset = Symbol "SOL"
    let amount = 1.0
    let type_of_transfer = To_cross_margin_account
    let recvWindow = 5000
  end)

let place_transfer () = let* id = Transfer.place_transfer () in
  Alcotest.(check bool "Test SOL asset trabsfer from spot to margin account." true (id > 0));Lwt.return ();;

let test_place_transfer switch () =
  Lwt_switch.add_hook (Some switch) place_transfer;Lwt.return ();; 

let suite () = "Cross margin account transfer", [
    Alcotest_lwt.test_case "Test SOL asset trabsfer from spot to margin account." `Quick test_place_transfer
  ]