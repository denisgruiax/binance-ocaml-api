open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;

module Current_average_price' = Current_average_price.Make(struct
    let url = Base_urls.api_default
    let symbol = "XRPUSDT"
  end)

let get_current_average_price () = let* average_price = Current_average_price'.get_current_average_price () in
  Alcotest.(check bool "Check XRPUSDT average price." true (average_price.price > 0.0)); Lwt.return ();;

let test_get_current_average_price switch () = 
  Lwt_switch.add_hook (Some switch) get_current_average_price; Lwt.return ();;

let suite () = "Current average price", [
  Alcotest_lwt.test_case "Check XRPUSDT average price." `Quick test_get_current_average_price 
]