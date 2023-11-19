open Lwt.Syntax;;

let create_header api_key = Cohttp.Header.init_with "X-MBX-APIKEY" api_key;;

let get url = 
  let* uri = Lwt.return (Uri.of_string url) 
  in let* (_, body) = Cohttp_lwt_unix.Client.get uri
  in let* body_string = Cohttp_lwt.Body.to_string body
  in let* json = Lwt.return(Ezjsonm.from_string body_string)
  in Lwt.return json;;

let get_signed url headers =
  let* uri = Lwt.return (Uri.of_string url)
  in let* (_, body) = Cohttp_lwt_unix.Client.get uri ~headers
  in let* body_string = Cohttp_lwt.Body.to_string body
  in let* json = Lwt.return(Ezjsonm.from_string body_string)
  in Lwt.return json;;

let post url headers = 
  let* uri = Lwt.return (Uri.of_string url)
  in let* (_, body) = Cohttp_lwt_unix.Client.post uri ~headers ~body:(Cohttp_lwt.Body.empty)
  in let* body_string = Cohttp_lwt.Body.to_string body
  in let* json = Lwt.return(Ezjsonm.from_string body_string)
  in Lwt.return json;;

let delete url headers = 
  let* uri = Lwt.return (Uri.of_string url)
  in let* (_, body) = Cohttp_lwt_unix.Client.delete uri ~headers ~body:(Cohttp_lwt.Body.empty)
  in let* body_string = Cohttp_lwt.Body.to_string body
  in let* json = Lwt.return(Ezjsonm.from_string body_string)
  in Lwt.return json;;