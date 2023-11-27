open Utilities;;
open Lwt.Infix;;

type commission_rate = {
  maker : Decimal.t;
  taker : Decimal.t;
  buyer : Decimal.t;
  seller : Decimal.t
};;

type balance = {
  asset : string;
  free : Decimal.t;
  locked : Decimal.t
};;

type account = {
  maker_commission : Decimal.t;
  taker_commision : Decimal.t;
  buyer_commission : Decimal.t;
  seller_commission : Decimal.t;
  commission_rates : commission_rate option;
  can_trade : bool;
  can_withdraw : bool;
  can_deposit : bool;
  brokered : bool;
  require_self_trade_prevention : bool;
  prevent_sor : bool;
  update_time : Decimal.t;
  account_type : string;
  balances : balance option list;
  permissions : string list;
  uid : Decimal.t
};;

let get_commission_rates = function
  |`O[
      ("maker", `String maker);
      ("taker", `String taker);
      ("buyer", `String buyer);
      ("seller", `String seller);
    ] -> Some {
      maker = Decimal.of_string maker;
      taker = Decimal.of_string taker;
      buyer = Decimal.of_string buyer;
      seller = Decimal.of_string seller;
    }
  |_ -> None;;

let print_commission_rates = function
  |Some commission_rate -> begin match commission_rate with
      |{
        maker = maker;
        taker = taker;
        buyer = buyer;
        seller = seller
      } -> let open Decimal in Lwt_io.printf "maker = %s\ntaker = %s\nbuyer = %s\nseller = %s\n" (to_string maker) (to_string taker) (to_string buyer) (to_string seller)
    end
  |None -> Lwt.return ();;

let get_balance = function
  |`O[
      ("asset", `String asset);
      ("free", `String free);
      ("locked", `String locked)
    ] -> Some{
      asset = asset;
      free = Decimal.of_string free;
      locked = Decimal.of_string locked
    }
  |_ -> None;;

let get_balances balances = Data.get_list get_balance balances;;

let print_balance = function
  |Some balance -> begin match balance with 
      |{
        asset = asset;
        free = free;
        locked = locked
      } -> Lwt_io.printf "asset = %s\nfree = %s\nlocked = %s\n\n" asset (Decimal.to_string free) (Decimal.to_string locked) end
  |None -> Lwt.return ();;

let print_balances balances = Lwt_list.iter_s (print_balance) balances;;

let get_permissions permissions = Data.get_list (fun permission -> Ezjsonm.get_string permission) permissions;;

let print_permissions permissions = Lwt_list.iter_s (Lwt_io.printl) permissions;;

let get_data = function
  |`O[
      ("makerCommission", `Float maker_commission);
      ("takerCommission", `Float taker_commision);
      ("buyerCommission", `Float buyer_commission);
      ("sellerCommission", `Float seller_commission);
      ("commissionRates", commission_rates);
      ("canTrade", `Bool can_trade);
      ("canWithdraw", `Bool can_withdraw);
      ("canDeposit", `Bool can_deposit);
      ("brokered", `Bool brokered);
      ("requireSelfTradePrevention", `Bool require_self_trade_prevention);
      ("preventSor", `Bool prevent_sor);
      ("updateTime",`Float update_time);
      ("accountType", `String account_type);
      ("balances", balances);
      ("permissions", permissions);
      ("uid", `Float uid);
    ] -> Some {
      maker_commission = Decimal.of_int (int_of_float maker_commission);
      taker_commision = Decimal.of_int (int_of_float taker_commision);
      buyer_commission = Decimal.of_int (int_of_float buyer_commission);
      seller_commission = Decimal.of_int (int_of_float seller_commission);
      commission_rates = get_commission_rates commission_rates;
      can_trade = can_trade;
      can_withdraw = can_withdraw;
      can_deposit = can_deposit;
      brokered = brokered;
      require_self_trade_prevention = require_self_trade_prevention;
      prevent_sor = prevent_sor;
      update_time = Decimal.of_int (int_of_float update_time);
      account_type = account_type;
      balances = get_balances balances;
      permissions = get_permissions permissions;
      uid = Decimal.of_int (int_of_float uid)
    }
  |_ -> None

let parse_response json = 
  json >>= fun json' -> Lwt.return(get_data json');;

let get_account base_url endpoint api_key secret_key parameters = 
  let url = Url.build_signed base_url endpoint parameters secret_key in
  parse_response (Requests.get_signed url (Requests.create_header api_key));;

let print_account = function
  |Some account -> begin match account with 
      |{
        maker_commission = maker_commission;
        taker_commision = taker_commision;
        buyer_commission = buyer_commission;
        seller_commission = seller_commission;
        commission_rates = commission_rates;
        can_trade = can_trade;
        can_withdraw = can_withdraw;
        can_deposit = can_deposit;
        brokered = brokered;
        require_self_trade_prevention = require_self_trade_prevention;
        prevent_sor = prevent_sor;
        update_time = update_time;
        account_type = account_type;
        balances = balances;
        permissions = permissions;
        uid = uid
      } -> let open Lwt.Syntax in
        let* () = Lwt_io.printf "maker_commission : %s\n" (Decimal.to_string maker_commission) in
        let* () = Lwt_io.printf "taker_commission : %s\n" (Decimal.to_string taker_commision) in
        let* () = Lwt_io.printf "buyer_commission : %s\n" (Decimal.to_string buyer_commission) in
        let* () = Lwt_io.printf "seller_commission : %s\n" (Decimal.to_string seller_commission) in
        let* () = Lwt_io.printf "commission_rates :\n" in
        let* () = print_commission_rates commission_rates in
        let* () = Lwt_io.printf "can_trade : %s\n" (string_of_bool can_trade) in
        let* () = Lwt_io.printf "can_withdraw : %s\n" (string_of_bool can_withdraw) in
        let* () = Lwt_io.printf "can_deposit : %s\n" (string_of_bool can_deposit) in
        let* () = Lwt_io.printf "brokered : %s\n" (string_of_bool brokered) in
        let* () = Lwt_io.printf "require_self_trade_prevention : %s\n" (string_of_bool require_self_trade_prevention) in
        let* () = Lwt_io.printf "prevent_sor : %s\n" (string_of_bool  prevent_sor) in
        let* () = Lwt_io.printf "update_time : %s\n" (Decimal.to_string update_time) in
        let* () = Lwt_io.printf "account_type : %s\n" (account_type) in
        let* () = Lwt_io.printf "balances: \n" in
        let* () = print_balances balances in
        let* () = Lwt_io.printf "permissions: \n" in
        let* () = print_permissions permissions in
        let* () = Lwt_io.printf "uid : %s\n" (Decimal.to_string uid) in
        Lwt.return ()
    end
  |None -> Lwt_io.printf "Wrong API response for account fetch!";;