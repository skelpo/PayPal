import Vapor

/// The valid country codes for PayPal resources.
public enum Country: String, Hashable, CaseIterable, Content {
    
    /// `AL`
    ///
    /// ALBANIA
    case albania = "AL"
    
    /// `DZ`
    ///
    /// ALGERIA
    case algeria = "DZ"
    
    /// `AD`
    ///
    /// ANDORRA
    case andorra = "AD"
    
    /// `AO`
    ///
    /// ANGOLA
    case angola = "AO"
    
    /// `AI`
    ///
    /// ANGUILLA
    case anguilla = "AI"
    
    /// `AG`
    ///
    /// ANTIGUA & BARBUDA
    case antiguaBarbuda = "AG"
    
    /// `AR`
    ///
    /// ARGENTINA
    case argentina = "AR"
    
    /// `AM`
    ///
    /// ARMENIA
    case armenia = "AM"
    
    /// `AW`
    ///
    /// ARUBA
    case aruba = "AW"
    
    /// `AU`
    ///
    /// AUSTRALIA
    case australia = "AU"
    
    /// `AT`
    ///
    /// AUSTRIA
    case austria = "AT"
    
    /// `AZ`
    ///
    /// AZERBAIJAN
    case azerbaijan = "AZ"
    
    /// `BS`
    ///
    /// BAHAMAS
    case bahamas = "BS"
    
    /// `BH`
    ///
    /// BAHRAIN
    case bahrain = "BH"
    
    /// `BB`
    ///
    /// BARBADOS
    case barbados = "BB"
    
    /// `BY`
    ///
    /// BELARUS
    case belarus = "BY"
    
    /// `BE`
    ///
    /// BELGIUM
    case belgium = "BE"
    
    /// `BZ`
    ///
    /// BELIZE
    case belize = "BZ"
    
    /// `BJ`
    ///
    /// BENIN
    case benin = "BJ"
    
    /// `BM`
    ///
    /// BERMUDA
    case bermuda = "BM"
    
    /// `BT`
    ///
    /// BHUTAN
    case bhutan = "BT"
    
    /// `BO`
    ///
    /// BOLIVIA
    case bolivia = "BO"
    
    /// `BA`
    ///
    /// BOSNIA & HERZEGOVINA
    case bosniaHerzegovina = "BA"
    
    /// `BW`
    ///
    /// BOTSWANA
    case botswana = "BW"
    
    /// `BR`
    ///
    /// BRAZIL
    case brazil = "BR"
    
    /// `VG`
    ///
    /// BRITISH VIRGIN ISLANDS
    case britishVirginIslands = "VG"
    
    /// `BN`
    ///
    /// BRUNEI
    case brunei = "BN"
    
    /// `BG`
    ///
    /// BULGARIA
    case bulgaria = "BG"
    
    /// `BF`
    ///
    /// BURKINA FASO
    case burkinaFaso = "BF"
    
    /// `BI`
    ///
    /// BURUNDI
    case burundi = "BI"
    
    /// `KH`
    ///
    /// CAMBODIA
    case cambodia = "KH"
    
    /// `CM`
    ///
    /// CAMEROON
    case cameroon = "CM"
    
    /// `CA`
    ///
    /// CANADA
    case canada = "CA"
    
    /// `CV`
    ///
    /// CAPE VERDE
    case capeVerde = "CV"
    
    /// `KY`
    ///
    /// CAYMAN ISLANDS
    case caymanIslands = "KY"
    
    /// `TD`
    ///
    /// CHAD
    case chad = "TD"
    
    /// `CL`
    ///
    /// CHILE
    case chile = "CL"
    
    /// `C2`
    ///
    /// CHINA
    case china = "C2"
    
    /// `CO`
    ///
    /// COLOMBIA
    case colombia = "CO"
    
    /// `KM`
    ///
    /// COMOROS
    case comoros = "KM"
    
    /// `CG`
    ///
    /// CONGO - BRAZZAVILLE
    case congoBrazzaville = "CG"
    
    /// `CD`
    ///
    /// CONGO - KINSHASA
    case congoKinshasa = "CD"
    
    /// `CK`
    ///
    /// COOK ISLANDS
    case cookIslands = "CK"
    
    /// `CR`
    ///
    /// COSTA RICA
    case costaRica = "CR"
    
    /// `CI`
    ///
    /// CÔTE D’IVOIRE
    case côteDivoire = "CI"
    
    /// `HR`
    ///
    /// CROATIA
    case croatia = "HR"
    
    /// `CY`
    ///
    /// CYPRUS
    case cyprus = "CY"
    
    /// `CZ`
    ///
    /// CZECH REPUBLIC
    case czechRepublic = "CZ"
    
    /// `DK`
    ///
    /// DENMARK
    case denmark = "DK"
    
    /// `DJ`
    ///
    /// DJIBOUTI
    case djibouti = "DJ"
    
    /// `DM`
    ///
    /// DOMINICA
    case dominica = "DM"
    
    /// `DO`
    ///
    /// DOMINICAN REPUBLIC
    case dominicanRepublic = "DO"
    
    /// `EC`
    ///
    /// ECUADOR
    case ecuador = "EC"
    
    /// `EG`
    ///
    /// EGYPT
    case egypt = "EG"
    
    /// `SV`
    ///
    /// EL SALVADOR
    case elSalvador = "SV"
    
    /// `ER`
    ///
    /// ERITREA
    case eritrea = "ER"
    
    /// `EE`
    ///
    /// ESTONIA
    case estonia = "EE"
    
    /// `ET`
    ///
    /// ETHIOPIA
    case ethiopia = "ET"
    
    /// `FK`
    ///
    /// FALKLAND ISLANDS
    case falklandIslands = "FK"
    
    /// `FO`
    ///
    /// FAROE ISLANDS
    case faroeIslands = "FO"
    
    /// `FJ`
    ///
    /// FIJI
    case fiji = "FJ"
    
    /// `FI`
    ///
    /// FINLAND
    case finland = "FI"
    
    /// `FR`
    ///
    /// FRANCE
    case france = "FR"
    
    /// `GF`
    ///
    /// FRENCH GUIANA
    case frenchGuiana = "GF"
    
    /// `PF`
    ///
    /// FRENCH POLYNESIA
    case frenchPolynesia = "PF"
    
    /// `GA`
    ///
    /// GABON
    case gabon = "GA"
    
    /// `GM`
    ///
    /// GAMBIA
    case gambia = "GM"
    
    /// `GE`
    ///
    /// GEORGIA
    case georgia = "GE"
    
    /// `DE`
    ///
    /// GERMANY
    case germany = "DE"
    
    /// `GI`
    ///
    /// GIBRALTAR
    case gibraltar = "GI"
    
    /// `GR`
    ///
    /// GREECE
    case greece = "GR"
    
    /// `GL`
    ///
    /// GREENLAND
    case greenland = "GL"
    
    /// `GD`
    ///
    /// GRENADA
    case grenada = "GD"
    
    /// `GP`
    ///
    /// GUADELOUPE
    case guadeloupe = "GP"
    
    /// `GT`
    ///
    /// GUATEMALA
    case guatemala = "GT"
    
    /// `GN`
    ///
    /// GUINEA
    case guinea = "GN"
    
    /// `GW`
    ///
    /// GUINEA-BISSAU
    case guineaBissau = "GW"
    
    /// `GY`
    ///
    /// GUYANA
    case guyana = "GY"
    
    /// `HN`
    ///
    /// HONDURAS
    case honduras = "HN"
    
    /// `HK`
    ///
    /// HONG KONG SAR CHINA
    case hongKongSarChina = "HK"
    
    /// `HU`
    ///
    /// HUNGARY
    case hungary = "HU"
    
    /// `IS`
    ///
    /// ICELAND
    case iceland = "IS"
    
    /// `IN`
    ///
    /// INDIA
    case india = "IN"
    
    /// `ID`
    ///
    /// INDONESIA
    case indonesia = "ID"
    
    /// `IE`
    ///
    /// IRELAND
    case ireland = "IE"
    
    /// `IL`
    ///
    /// ISRAEL
    case israel = "IL"
    
    /// `IT`
    ///
    /// ITALY
    case italy = "IT"
    
    /// `JM`
    ///
    /// JAMAICA
    case jamaica = "JM"
    
    /// `JP`
    ///
    /// JAPAN
    case japan = "JP"
    
    /// `JO`
    ///
    /// JORDAN
    case jordan = "JO"
    
    /// `KZ`
    ///
    /// KAZAKHSTAN
    case kazakhstan = "KZ"
    
    /// `KE`
    ///
    /// KENYA
    case kenya = "KE"
    
    /// `KI`
    ///
    /// KIRIBATI
    case kiribati = "KI"
    
    /// `KW`
    ///
    /// KUWAIT
    case kuwait = "KW"
    
    /// `KG`
    ///
    /// KYRGYZSTAN
    case kyrgyzstan = "KG"
    
    /// `LA`
    ///
    /// LAOS
    case laos = "LA"
    
    /// `LV`
    ///
    /// LATVIA
    case latvia = "LV"
    
    /// `LS`
    ///
    /// LESOTHO
    case lesotho = "LS"
    
    /// `LI`
    ///
    /// LIECHTENSTEIN
    case liechtenstein = "LI"
    
    /// `LT`
    ///
    /// LITHUANIA
    case lithuania = "LT"
    
    /// `LU`
    ///
    /// LUXEMBOURG
    case luxembourg = "LU"
    
    /// `MK`
    ///
    /// MACEDONIA
    case macedonia = "MK"
    
    /// `MG`
    ///
    /// MADAGASCAR
    case madagascar = "MG"
    
    /// `MW`
    ///
    /// MALAWI
    case malawi = "MW"
    
    /// `MY`
    ///
    /// MALAYSIA
    case malaysia = "MY"
    
    /// `MV`
    ///
    /// MALDIVES
    case maldives = "MV"
    
    /// `ML`
    ///
    /// MALI
    case mali = "ML"
    
    /// `MT`
    ///
    /// MALTA
    case malta = "MT"
    
    /// `MH`
    ///
    /// MARSHALL ISLANDS
    case marshallIslands = "MH"
    
    /// `MQ`
    ///
    /// MARTINIQUE
    case martinique = "MQ"
    
    /// `MR`
    ///
    /// MAURITANIA
    case mauritania = "MR"
    
    /// `MU`
    ///
    /// MAURITIUS
    case mauritius = "MU"
    
    /// `YT`
    ///
    /// MAYOTTE
    case mayotte = "YT"
    
    /// `MX`
    ///
    /// MEXICO
    case mexico = "MX"
    
    /// `FM`
    ///
    /// MICRONESIA
    case micronesia = "FM"
    
    /// `MD`
    ///
    /// MOLDOVA
    case moldova = "MD"
    
    /// `MC`
    ///
    /// MONACO
    case monaco = "MC"
    
    /// `MN`
    ///
    /// MONGOLIA
    case mongolia = "MN"
    
    /// `ME`
    ///
    /// MONTENEGRO
    case montenegro = "ME"
    
    /// `MS`
    ///
    /// MONTSERRAT
    case montserrat = "MS"
    
    /// `MA`
    ///
    /// MOROCCO
    case morocco = "MA"
    
    /// `MZ`
    ///
    /// MOZAMBIQUE
    case mozambique = "MZ"
    
    /// `NA`
    ///
    /// NAMIBIA
    case namibia = "NA"
    
    /// `NR`
    ///
    /// NAURU
    case nauru = "NR"
    
    /// `NP`
    ///
    /// NEPAL
    case nepal = "NP"
    
    /// `NL`
    ///
    /// NETHERLANDS
    case netherlands = "NL"
    
    /// `NC`
    ///
    /// NEW CALEDONIA
    case newCaledonia = "NC"
    
    /// `NZ`
    ///
    /// NEW ZEALAND
    case newZealand = "NZ"
    
    /// `NI`
    ///
    /// NICARAGUA
    case nicaragua = "NI"
    
    /// `NE`
    ///
    /// NIGER
    case niger = "NE"
    
    /// `NG`
    ///
    /// NIGERIA
    case nigeria = "NG"
    
    /// `NU`
    ///
    /// NIUE
    case niue = "NU"
    
    /// `NF`
    ///
    /// NORFOLK ISLAND
    case norfolkIsland = "NF"
    
    /// `NO`
    ///
    /// NORWAY
    case norway = "NO"
    
    /// `OM`
    ///
    /// OMAN
    case oman = "OM"
    
    /// `PW`
    ///
    /// PALAU
    case palau = "PW"
    
    /// `PA`
    ///
    /// PANAMA
    case panama = "PA"
    
    /// `PG`
    ///
    /// PAPUA NEW GUINEA
    case papuaNewGuinea = "PG"
    
    /// `PY`
    ///
    /// PARAGUAY
    case paraguay = "PY"
    
    /// `PE`
    ///
    /// PERU
    case peru = "PE"
    
    /// `PH`
    ///
    /// PHILIPPINES
    case philippines = "PH"
    
    /// `PN`
    ///
    /// PITCAIRN ISLANDS
    case pitcairnIslands = "PN"
    
    /// `PL`
    ///
    /// POLAND
    case poland = "PL"
    
    /// `PT`
    ///
    /// PORTUGAL
    case portugal = "PT"
    
    /// `QA`
    ///
    /// QATAR
    case qatar = "QA"
    
    /// `RE`
    ///
    /// RÉUNION
    case reunion = "RE"
    
    /// `RO`
    ///
    /// ROMANIA
    case romania = "RO"
    
    /// `RU`
    ///
    /// RUSSIA
    case russia = "RU"
    
    /// `RW`
    ///
    /// RWANDA
    case rwanda = "RW"
    
    /// `WS`
    ///
    /// SAMOA
    case samoa = "WS"
    
    /// `SM`
    ///
    /// SAN MARINO
    case sanMarino = "SM"
    
    /// `ST`
    ///
    /// SÃO TOMÉ & PRÍNCIPE
    case saoTomePríncipe = "ST"
    
    /// `SA`
    ///
    /// SAUDI ARABIA
    case saudiArabia = "SA"
    
    /// `SN`
    ///
    /// SENEGAL
    case senegal = "SN"
    
    /// `RS`
    ///
    /// SERBIA
    case serbia = "RS"
    
    /// `SC`
    ///
    /// SEYCHELLES
    case seychelles = "SC"
    
    /// `SL`
    ///
    /// SIERRA LEONE
    case sierraLeone = "SL"
    
    /// `SG`
    ///
    /// SINGAPORE
    case singapore = "SG"
    
    /// `SK`
    ///
    /// SLOVAKIA
    case slovakia = "SK"
    
    /// `SI`
    ///
    /// SLOVENIA
    case slovenia = "SI"
    
    /// `SB`
    ///
    /// SOLOMON ISLANDS
    case solomonIslands = "SB"
    
    /// `SO`
    ///
    /// SOMALIA
    case somalia = "SO"
    
    /// `ZA`
    ///
    /// SOUTH AFRICA
    case southAfrica = "ZA"
    
    /// `KR`
    ///
    /// SOUTH KOREA
    case southKorea = "KR"
    
    /// `ES`
    ///
    /// SPAIN
    case spain = "ES"
    
    /// `LK`
    ///
    /// SRI LANKA
    case sriLanka = "LK"
    
    /// `SH`
    ///
    /// ST. HELENA
    case stHelena = "SH"
    
    /// `KN`
    ///
    /// ST. KITTS & NEVIS
    case stKittsNevis = "KN"
    
    /// `LC`
    ///
    /// ST. LUCIA
    case stLucia = "LC"
    
    /// `PM`
    ///
    /// ST. PIERRE & MIQUELON
    case stPierreMiquelon = "PM"
    
    /// `VC`
    ///
    /// ST. VINCENT & GRENADINES
    case stVincentGrenadines = "VC"
    
    /// `SR`
    ///
    /// SURINAME
    case suriname = "SR"
    
    /// `SJ`
    ///
    /// SVALBARD & JAN MAYEN
    case svalbardJanMayen = "SJ"
    
    /// `SZ`
    ///
    /// SWAZILAND
    case swaziland = "SZ"
    
    /// `SE`
    ///
    /// SWEDEN
    case sweden = "SE"
    
    /// `CH`
    ///
    /// SWITZERLAND
    case switzerland = "CH"
    
    /// `TW`
    ///
    /// TAIWAN
    case taiwan = "TW"
    
    /// `TJ`
    ///
    /// TAJIKISTAN
    case tajikistan = "TJ"
    
    /// `TZ`
    ///
    /// TANZANIA
    case tanzania = "TZ"
    
    /// `TH`
    ///
    /// THAILAND
    case thailand = "TH"
    
    /// `TG`
    ///
    /// TOGO
    case togo = "TG"
    
    /// `TO`
    ///
    /// TONGA
    case tonga = "TO"
    
    /// `TT`
    ///
    /// TRINIDAD & TOBAGO
    case trinidadTobago = "TT"
    
    /// `TN`
    ///
    /// TUNISIA
    case tunisia = "TN"
    
    /// `TM`
    ///
    /// TURKMENISTAN
    case turkmenistan = "TM"
    
    /// `TC`
    ///
    /// TURKS & CAICOS ISLANDS
    case turksCaicosIslands = "TC"
    
    /// `TV`
    ///
    /// TUVALU
    case tuvalu = "TV"
    
    /// `UG`
    ///
    /// UGANDA
    case uganda = "UG"
    
    /// `UA`
    ///
    /// UKRAINE
    case ukraine = "UA"
    
    /// `AE`
    ///
    /// UNITED ARAB EMIRATES
    case unitedArabEmirates = "AE"
    
    /// `GB`
    ///
    /// UNITED KINGDOM
    case unitedKingdom = "GB"
    
    /// `US`
    ///
    /// UNITED STATES
    case unitedStates = "US"
    
    /// `UY`
    ///
    /// URUGUAY
    case uruguay = "UY"
    
    /// `VU`
    ///
    /// VANUATU
    case vanuatu = "VU"
    
    /// `VA`
    ///
    /// VATICAN CITY
    case vaticanCity = "VA"
    
    /// `VE`
    ///
    /// VENEZUELA
    case venezuela = "VE"
    
    /// `VN`
    ///
    /// VIETNAM
    case vietnam = "VN"
    
    /// `WF`
    ///
    /// WALLIS & FUTUNA
    case wallisFutuna = "WF"
    
    /// `YE`
    ///
    /// YEMEN
    case yemen = "YE"
    
    /// `ZM`
    ///
    /// ZAMBIA
    case zambia = "ZM"
    
    /// `ZW`
    ///
    /// ZIMBABWE
    case zimbabwe = "ZW"
}
