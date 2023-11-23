open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;

let get_server_time () = let* time = Server_time.get ~base_url:Base_urls.api_default ~endpoint:Endpoints.Market_data.server_time in
  Alcotest.(check bool "Test server time." true (time > 0)); Lwt.return ();;

let test_server_time switch () = 
  Lwt_switch.add_hook (Some switch) get_server_time; Lwt.return ();;

let suite () = "Server time", [
    Alcotest_lwt.test_case "Test server time." `Quick test_server_time
  ]