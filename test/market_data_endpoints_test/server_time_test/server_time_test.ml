open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;

let get_server_time () = let* time_result = Server_time.get ~base_url:Base_urls.api_default ~endpoint:Endpoints.Market_data.server_time in
let* is_valid_result = Lwt.return (Result.is_ok time_result) in
let* time = Lwt.return (if is_valid_result then Result.get_ok time_result else failwith "Invalid result response!") in  
Alcotest.(check bool "Test server time." true Decimal.(time > zero)); Lwt.return ();;

let test_server_time switch () = 
  Lwt_switch.add_hook (Some switch) get_server_time; Lwt.return ();;

let suite () = "Server time", [
    Alcotest_lwt.test_case "Test server time." `Quick test_server_time
  ]