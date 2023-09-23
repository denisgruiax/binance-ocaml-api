module type BaseUrls'= sig
  val api_default : string
  val api_gcp : string
  val api1 : string
  val api2 : string
  val api3 : string
  val api4 : string
end

module BaseUrls : BaseUrls' = struct
  let api_default = "https://api.binance.com"
  let api_gcp = "https://api-gcp.binance.com"
  let api1 = "https://api1.binance.com"
  let api2 = "https://api2.binance.com"
  let api3 ="https://api3.binance.com"
  let api4 = "https://api4.binance.com"
end

module Crypto = Crypto
module Requests = Requests
module Url = Url