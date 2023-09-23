let timestamp () = string_of_int(int_of_float ((Unix.gettimeofday ()) *. 1000.0));;

let create_payload = function
  |[] -> ""
  |[(key, value)] -> "?" ^ key ^ "=" ^ value
  |(key, value) :: tail -> "?" ^ key ^ "=" ^ value ^ List.fold_right (fun (key, value) res -> "&" ^ key ^ "=" ^ value ^ res) tail "";;

let build_public url endpoint parameters_with_keys =
  let payload = create_payload parameters_with_keys  
  in url ^ endpoint ^ payload;;

let build_signed url endpoint parameters_with_keys secret_key = 
  let payload = create_payload parameters_with_keys 
  in url ^ endpoint ^ payload ^ "&timestamp=" ^ (timestamp ()) ^"&signature=" ^ (Crypto.create_signature payload secret_key)