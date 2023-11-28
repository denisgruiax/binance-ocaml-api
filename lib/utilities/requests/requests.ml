open Lwt.Syntax;;

let default_error_if_exception = let open Ezjsonm in function
    |response -> try from_string response with |Parse_error _ -> Ezjsonm.from_string "{\"code\":-1000, \"msg\":\"Ezjsonm Parse_error exception!\"}";;

let create_header api_key = Cohttp.Header.init_with "X-MBX-APIKEY" api_key;;

let get url = 
  let* uri = Lwt.return (Uri.of_string url) 
  in let* (_, body) = Cohttp_lwt_unix.Client.get uri
  in let* body_string = Cohttp_lwt.Body.to_string body
  in let* json = Lwt.return (default_error_if_exception body_string)
  in Lwt.return json;;

let get_signed url headers =
  let* uri = Lwt.return (Uri.of_string url)
  in let* (_, body) = Cohttp_lwt_unix.Client.get uri ~headers
  in let* body_string = Cohttp_lwt.Body.to_string body
  in let* json = Lwt.return (default_error_if_exception body_string)
  in Lwt.return json;;

let post url headers = 
  let* uri = Lwt.return (Uri.of_string url)
  in let* (_, body) = Cohttp_lwt_unix.Client.post uri ~headers ~body:(Cohttp_lwt.Body.empty)
  in let* body_string = Cohttp_lwt.Body.to_string body
  in let* json = Lwt.return (default_error_if_exception body_string)
  in Lwt.return json;;

let delete url headers = 
  let* uri = Lwt.return (Uri.of_string url)
  in let* (_, body) = Cohttp_lwt_unix.Client.delete uri ~headers ~body:(Cohttp_lwt.Body.empty)
  in let* body_string = Cohttp_lwt.Body.to_string body
  in let* json = Lwt.return (default_error_if_exception body_string)
  in Lwt.return json;;