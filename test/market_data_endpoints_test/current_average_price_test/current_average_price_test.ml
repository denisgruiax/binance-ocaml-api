open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;

let url = Base_urls.api_default;;
let endpoint = Endpoints.Market_data.current_average_price;;
let parameters = ["symbol", "XRPUSDT"];;

let get_current_average_price () = let* response_option = Current_average_price.get ~base_url:url ~endpoint:endpoint ~parameters:parameters in
  let* response = Lwt.return (Option.get response_option) in
  Alcotest.(check bool "Check XRPUSDT average price." true (response.price > Decimal.zero)); Lwt.return ();;

let test_get_current_average_price switch () = 
  Lwt_switch.add_hook (Some switch) get_current_average_price; Lwt.return ();;

let suite () = "Current average price", [
    Alcotest_lwt.test_case "Check XRPUSDT average price." `Quick test_get_current_average_price 
  ]