open Binance_ocaml_api.Market_data_endpoints;;
open Utilities;;
open Lwt.Syntax;;

let server_connectivity () = 
  let* connectivity_result = Test_connectivity.get ~base_url:Base_urls.api_default ~endpoint:Endpoints.Market_data.test_connectivity in
  let* is_valid_result = Lwt.return (Result.is_ok connectivity_result) in
  let* connectivity = Lwt.return (if is_valid_result then Result.get_ok connectivity_result else failwith "Invalid response result!")
  in Alcotest.(check string "Test server connectivity." "{}" connectivity); Lwt.return ();;

let test_server_connectivity switch () = 
  Lwt_switch.add_hook (Some switch) server_connectivity ; Lwt.return ();;

let suite () = "Test connectivity", [
    Alcotest_lwt.test_case "Test server connectivity" `Quick test_server_connectivity
  ];;