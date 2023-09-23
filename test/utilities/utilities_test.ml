open Alcotest;;
open Utilities;;

let api_default () = check string "api_default" BaseUrls.api_default "https://api.binance.com";;
let api_gcp () = check string "api_gcp" BaseUrls.api_gcp "https://api-gcp.binance.com";;
let api1 () = check string "api1" BaseUrls.api1 "https://api1.binance.com";;
let api2 () = check string "api2" BaseUrls.api1 "https://api1.binance.com";;
let api3 () = check string "api3" BaseUrls.api1 "https://api1.binance.com";;
let api4 () = check string "api4" BaseUrls.api1 "https://api1.binance.com";;

let suite () = "Enpoints", [
    test_case "api_default" `Quick api_default;
    test_case "api_gcp" `Quick api_gcp;
    test_case "api1" `Quick api1;
    test_case "api2" `Quick api2;
    test_case "api3" `Quick api3;
    test_case "api4" `Quick api4;
  ] ;;