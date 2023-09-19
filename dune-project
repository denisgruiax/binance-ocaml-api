(lang dune 3.7)

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
 (synopsis "A lightweight OCaml library for interacting with the Binance API.")
 (description "A lightweight OCaml library for interacting with the Binance API.")
 (depends ocaml dune)
 (tags
  (topics "to describe" your project)))

(package
 (name utilities)
 (synopsis "Will be defined.")
 (description "Will be defined.")
 (depends ocaml dune))

(package
 (name spot_account)
 (synopsis "Will be defined.")
 (description "Will be defined.")
 (depends ocaml dune))

(package
 (name market_data_endpoints)
 (synopsis "Will be defined.")
 (description "Will be defined.")
 (depends ocaml dune))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
