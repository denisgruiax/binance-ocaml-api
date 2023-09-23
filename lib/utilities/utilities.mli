module type BaseUrls' =
  sig
    val api_default : string
    val api_gcp : string
    val api1 : string
    val api2 : string
    val api3 : string
    val api4 : string
  end

module BaseUrls : BaseUrls'

module Requests = Requests
module Crypto = Crypto
module Url = Url