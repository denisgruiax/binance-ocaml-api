module type BaseApis' =
  sig
    val api_default : string
    val api_gcp : string
    val api1 : string
    val api2 : string
    val api3 : string
    val api4 : string
  end
module BaseApis :
  sig
    val api_default : string
    val api_gcp : string
    val api1 : string
    val api2 : string
    val api3 : string
    val api4 : string
  end
module type Endpoints =
  sig
    val agg_trades : string
    val avg_price : string
    val depth : string
    val exchange_info : string
    val klines : string
    val ping : string
    val ticker : string
    val ticker_24hr : string
    val ticker_bookTicker : string
    val ticker_price : string
    val time : string
    val trades : string
    val ui_klines : string
  end
module EndApis :
  sig
    val agg_trades : string
    val avg_price : string
    val depth : string
    val exchange_info : string
    val klines : string
    val ping : string
    val ticker : string
    val ticker_24hr : string
    val ticker_bookTicker : string
    val ticker_price : string
    val time : string
    val trades : string
    val ui_klines : string
  end
module Make : functor (BaseApi : sig val api : string end) -> Endpoints
