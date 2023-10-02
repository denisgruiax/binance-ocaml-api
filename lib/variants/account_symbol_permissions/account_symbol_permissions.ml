type account_symbol_permissions = SPOT | MARGIN | LEVERAGED
                                | TRD_GRP_002 | TRD_GRP_003 | TRD_GRP_004 | TRD_GRP_005
                                | TRD_GRP_006 | TRD_GRP_007 | TRD_GRP_008 | TRD_GRP_009 
                                | TRD_GRP_010 | TRD_GRP_011 | TRD_GRP_012 | TRD_GRP_013 
                                | TRD_GRP_014 | TRD_GRP_015 | TRD_GRP_016 | TRD_GRP_017 
                                | TRD_GRP_018 | TRD_GRP_019 | TRD_GRP_020 | TRD_GRP_021
                                | TRD_GRP_022 | TRD_GRP_023;;

let wrap_account_symbol_permissions = function 
    SPOT -> "SPOT" 
  | MARGIN -> "MARGIN"
  | LEVERAGED -> "LEVERAGED"
  | TRD_GRP_002 -> "TRD_GRP_002"
  | TRD_GRP_003 -> "TRD_GRP_003"
  | TRD_GRP_004 -> "TRD_GRP_004"
  | TRD_GRP_005 -> "TRD_GRP_005"
  | TRD_GRP_006 ->"TRD_GRP_006"
  | TRD_GRP_007 ->"TRD_GRP_007"
  | TRD_GRP_008 ->"TRD_GRP_008"
  | TRD_GRP_009 ->"TRD_GRP_009"
  | TRD_GRP_010 ->"TRD_GRP_010"
  | TRD_GRP_011 ->"TRD_GRP_011"
  | TRD_GRP_012 ->"TRD_GRP_012"
  | TRD_GRP_013 ->"TRD_GRP_013"
  | TRD_GRP_014 ->"TRD_GRP_014"
  | TRD_GRP_015 ->"TRD_GRP_015"
  | TRD_GRP_016 ->"TRD_GRP_016"
  | TRD_GRP_017 ->"TRD_GRP_017"
  | TRD_GRP_018 ->"TRD_GRP_018"
  | TRD_GRP_019 ->"TRD_GRP_019"
  | TRD_GRP_020 ->"TRD_GRP_020"
  | TRD_GRP_021 ->"TRD_GRP_021"
  | TRD_GRP_022 ->"TRD_GRP_022"
  | TRD_GRP_023 ->"TRD_GRP_023";;

let unwrap_account_symbol_permissions = function 
    "SPOT" -> SPOT
  | "MARGIN" -> MARGIN
  | "LEVERAGED" -> LEVERAGED
  | "TRD_GRP_002" -> TRD_GRP_002
  | "TRD_GRP_003" -> TRD_GRP_003
  | "TRD_GRP_004" -> TRD_GRP_004
  | "TRD_GRP_005" -> TRD_GRP_005
  | "TRD_GRP_006" -> TRD_GRP_006
  | "TRD_GRP_007" -> TRD_GRP_007
  | "TRD_GRP_008" -> TRD_GRP_008
  | "TRD_GRP_009" -> TRD_GRP_009
  | "TRD_GRP_010" -> TRD_GRP_010
  | "TRD_GRP_011" -> TRD_GRP_011
  | "TRD_GRP_012" -> TRD_GRP_012
  | "TRD_GRP_013" -> TRD_GRP_013
  | "TRD_GRP_014" -> TRD_GRP_014
  | "TRD_GRP_015" -> TRD_GRP_015
  | "TRD_GRP_016" -> TRD_GRP_016
  | "TRD_GRP_017" -> TRD_GRP_017
  | "TRD_GRP_018" -> TRD_GRP_018
  | "TRD_GRP_019" -> TRD_GRP_019
  | "TRD_GRP_020" -> TRD_GRP_020
  | "TRD_GRP_021" -> TRD_GRP_021
  | "TRD_GRP_022" -> TRD_GRP_022
  | "TRD_GRP_023" -> TRD_GRP_023
  | _ -> raise Not_found;;