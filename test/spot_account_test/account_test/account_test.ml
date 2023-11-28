open Binance_ocaml_api.Spot_account;;
open Lwt.Syntax;;
open Utilities;;

let api_key = "API_KEY";;
let secret_key = "SECRET_KEY";;

let base_url = Base_urls.api_default;;
let endpoint = "/api/v3/account";;

let get_account () = let* account_result = Account.get_account base_url endpoint api_key secret_key [("recvWindow", "60000")] in
  let* is_ok_result = Lwt.return (Result.is_ok account_result) in
  let* account = Lwt.return (if is_ok_result then Result.get_ok account_result else failwith "Invalid response result!") in
  let* maker_commission = Lwt.return account.maker_commission in
  Alcotest.(check bool "Account data" true (Decimal.to_string maker_commission = "10")); Lwt.return ();;

let test_get_account switch () = 
  Lwt_switch.add_hook (Some switch) get_account; Lwt.return ();;

let suite () = "Account data", [
    Alcotest_lwt.(test_case "Get account data." `Quick test_get_account)
  ];;