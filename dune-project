(lang dune 3.14)

(name binance_ocaml_api)

(generate_opam_files true)

(source
 (github denisgruiax/binance-ocaml-api))

(authors "Denis Gruia")

(maintainers "Denis Gruia")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name binance_ocaml_api)
 (synopsis
  "A lightweight OCaml library for interacting with the Binance API.")
 (depends ocaml dune))

(package
 (name margin_account)
 (synopsis
  "Contains modules for interacting with the margin wallet of a Binance account for placing leveraged orders."))

(package
 (name market_data_endpoints)
 (synopsis
  "Contains modules for getting data from the Binance market like price of a pair or a list of candlesticks.")
 (depends ocaml dune))

(package
 (name error_code)
 (synopsis
  "Contains modules for holding the error codes from Binance API inside a record.")
 (depends ocaml dune))

(package
 (name spot_account)
 (synopsis
  "Contains modules for interacting with a spot account of Binance.")
 (depends ocaml dune))

(package
 (name spot_trading)
 (synopsis
  "Contains modules for interacting with the trading functionalities of a Binance account.")
 (depends ocaml dune))

(package
 (name utilities)
 (synopsis
  "A module that hold multiple modules that help in code reuse, structure the code in a modular way and write others auxiliar functions.")
 (depends ocaml dune))

(package
 (name variants)
 (synopsis
  "A module that hold multiple enums used by Binance and and implemented with variant data types.")
 (depends ocaml dune))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
