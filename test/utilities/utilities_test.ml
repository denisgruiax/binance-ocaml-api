open Alcotest;;
open Utilities;;
open Lwt.Syntax;;

let api_default () = let* ()  = Lwt.return (check string "api_default" Base_urls.api_default "https://api.binance.com")
  in Lwt.return ();;

let test_api_default switch () = 
  Lwt_switch.add_hook (Some switch) api_default; Lwt.return ();;


let api_gcp () = let* ()  = Lwt.return (check string "api_gcp" Base_urls.api_gcp "https://api-gcp.binance.com")
  in Lwt.return ();;

let test_api_gcp switch () = 
  Lwt_switch.add_hook (Some switch) api_gcp; Lwt.return ();;


let api1 () = let* ()  = Lwt.return (check string "api1" Base_urls.api1 "https://api1.binance.com")
  in Lwt.return ();;

let test_api1 switch () = 
  Lwt_switch.add_hook (Some switch) api1; Lwt.return ();;


let api2 () = let* ()  = Lwt.return (check string "api2" Base_urls.api1 "https://api1.binance.com")
  in Lwt.return ();;

let test_api2 switch () = 
  Lwt_switch.add_hook (Some switch) api2; Lwt.return ();;


let api3 () = let* ()  = Lwt.return (check string "api3" Base_urls.api1 "https://api1.binance.com")
  in Lwt.return ();;

let test_api3 switch () = 
  Lwt_switch.add_hook (Some switch) api3; Lwt.return ();;


let api4 () = let* ()  = Lwt.return (check string "api4" Base_urls.api1 "https://api1.binance.com")
  in Lwt.return ();;
  
let test_api4 switch () = 
  Lwt_switch.add_hook (Some switch) api4; Lwt.return ();;


let suite () = "Utilities endpoints", [
    Alcotest_lwt.test_case "Test of api_default url." `Quick test_api_default;
    Alcotest_lwt.test_case "Test of api_gcp url." `Quick test_api_gcp;
    Alcotest_lwt.test_case "Test of api1 url." `Quick test_api1;
    Alcotest_lwt.test_case "Test of api2 url." `Quick test_api2;
    Alcotest_lwt.test_case "Test of api3 url." `Quick test_api3;
    Alcotest_lwt.test_case "Test of api4 url." `Quick test_api4;
  ] ;;