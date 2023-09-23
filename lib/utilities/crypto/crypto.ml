let generate_hmac_sha256 payload secret_key =
  let hmac_key = Cstruct.of_string secret_key in
  let payload_cs = Cstruct.of_string payload in
  let hmac = Nocrypto.Hash.SHA256.hmac ~key:hmac_key payload_cs in
  Cstruct.to_string hmac;;

let encode_hmac_to_hex hmac =
  let buffer = Buffer.create (String.length hmac * 2) in
  String.iter (fun character -> Printf.bprintf buffer "%02x" (int_of_char character)) hmac;
  Buffer.contents buffer;;

let create_signature payload secret_key= let hmac = generate_hmac_sha256 payload secret_key in
  encode_hmac_to_hex hmac;;