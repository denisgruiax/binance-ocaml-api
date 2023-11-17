let timestamp () = string_of_int(int_of_float ((Unix.gettimeofday ()) *. 1000.0));;

let extract_pairs parameters= List.fold_right (fun elt res -> if Option.is_some elt then Option.get elt :: res else res) parameters [];;

let create_payload parameters = let res = extract_pairs parameters in match res with
  |[] -> ""
  |[(key, value)] -> key ^ "=" ^ value
  |(key, value) :: tail -> key ^ "=" ^ value ^ List.fold_right (fun (key, value) res -> ("&" ^ key ^ "=" ^ value ^ res)) tail "";;

let build_public url endpoint parameters_with_keys =
  let payload = create_payload parameters_with_keys  
  in String.concat "" [url; endpoint; "?"; payload];;

let build_signed url endpoint parameters_with_keys secret_key =
  let current_timestamp = timestamp ()
  in let payload = create_payload (parameters_with_keys @ [Some ("timestamp", current_timestamp)])
  in String.concat "" [url; endpoint; "?"; payload; "&signature="; (Crypto.create_signature payload secret_key)];;

let check_limit minimum maximum default = function
  |limit when limit >= minimum && limit <= maximum -> limit
  |_-> default;;