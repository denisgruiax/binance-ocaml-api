open Binance_ocaml_api.Spot_account;;
open Lwt.Syntax;;
open Utilities;;

let api_key = "Your api key";;
let secret_key = "Your secret key";;

let base_url = Base_urls.api_default;;
let endpoint = "/api/v3/account";;

let get_account () = let* account_opt = Account.get_account base_url endpoint api_key secret_key [("recvWindow", "60000")]
  in let* account = Lwt.return (Option.get account_opt)
  in let* () = Account.print_account account_opt
  in let* maker_commission = Lwt.return account.maker_commission
  in Alcotest.(check bool "Account data" true (Decimal.to_string maker_commission = "10")); Lwt.return ();;

let test_get_account switch () = 
  Lwt_switch.add_hook (Some switch) get_account; Lwt.return ();;

let suite () = "Account data", [
    Alcotest_lwt.(test_case "Get account data." `Quick test_get_account)
  ]