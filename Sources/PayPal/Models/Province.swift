import Vapor

/// Valid state and province codes for countries supported by PayPal.
public enum Province: String, Hashable, CaseIterable, Content {

    /// `CIUDAD AUTÓNOMA DE BUENOS AIRES`
    case buenosAiresCiudad
    
    /// `BUENOS AIRES`
    case buenosAiresProvincia
    
    /// `CATAMARCA`
    case catamarca
    
    /// `CHACO`
    case chaco
    
    /// `CHUBUT`
    case chubut
    
    /// `CORRIENTES`
    case corrientes
    
    /// `CÓRDOBA`
    case córdoba
    
    /// `ENTRE RÍOS`
    case entreRíos
    
    /// `FORMOSA`
    case formosa
    
    /// `JUJUY`
    case jujuy
    
    /// `LA PAMPA`
    case laPampa
    
    /// `LA RIOJA`
    case laRioja
    
    /// `MENDOZA`
    case mendoza
    
    /// `MISIONES`
    case misiones
    
    /// `NEUQUÉN`
    case neuquén
    
    /// `RÍO NEGRO`
    case ríoNegro
    
    /// `SALTA`
    case salta
    
    /// `SAN JUAN`
    case sanJuan
    
    /// `SAN LUIS`
    case sanLuis
    
    /// `SANTA CRUZ`
    case santaCruz
    
    /// `SANTA FE`
    case santaFe
    
    /// `SANTIAGO DEL ESTERO`
    case santiagoDelEstero
    
    /// `TIERRA DEL FUEGO`
    case tierraDelFuego
    
    /// `TUCUMÁN`
    case tucumán
    
    /// `AC`
    case acre
    
    /// `AL`
    case alagoas
    
    /// `AP`
    case amapá
    
    /// `AM`
    case amazonas
    
    /// `BA`
    case bahia
    
    /// `CE`
    case ceará
    
    /// `DF`
    case distritoFederal
    
    /// `ES`
    case espíritoSanto
    
    /// `GO`
    case goiás
    
    /// `MA`
    case maranhão
    
    /// `MT`
    case matoGrosso
    
    /// `MS`
    case matoGrossoDoSul
    
    /// `MG`
    case minasGerais
    
    /// `PR`
    case paraná
    
    /// `PB`
    case paraíba
    
    /// `PA`
    case pará
    
    /// `PE`
    case pernambuco
    
    /// `PI`
    case piauí
    
    /// `RN`
    case rioGrandeDoNorte
    
    /// `RS`
    case rioGrandeDoSul
    
    /// `RJ`
    case rioDeJaneiro
    
    /// `RO`
    case rondônia
    
    /// `RR`
    case roraima
    
    /// `SC`
    case santaCatarina
    
    /// `SE`
    case sergipe
    
    /// `SP`
    case sãoPaulo
    
    /// `TO`
    case tocantins
    
    /// `AB`
    case alberta
    
    /// `BC`
    case britishColumbia
    
    /// `MB`
    case manitoba
    
    /// `NB`
    case newBrunswick
    
    /// `NL`
    case newfoundlandAndLabrador
    
    /// `NT`
    case northwestTerritories
    
    /// `NS`
    case novaScotia
    
    /// `NU`
    case nunavut
    
    /// `ON`
    case ontario
    
    /// `PE`
    case princeEdwardIsland
    
    /// `QC`
    case quebec
    
    /// `SK`
    case saskatchewan
    
    /// `YT`
    case yukon
    
    /// `CN-AH`
    case anhuiSheng
    
    /// `CN-BJ`
    case beijingShi
    
    /// `CN-CQ`
    case chongqingShi
    
    /// `CN-FJ`
    case fujianSheng
    
    /// `CN-GD`
    case guangdongSheng
    
    /// `CN-GS`
    case gansuSheng
    
    /// `CN-GX`
    case guangxiZhuangzuZizhiqu
    
    /// `CN-GZ`
    case guizhouSheng
    
    /// `CN-HA`
    case henanSheng
    
    /// `CN-HB`
    case hubeiSheng
    
    /// `CN-HE`
    case hebeiSheng
    
    /// `CN-HI`
    case hainanSheng
    
    /// `CN-HK`
    case hongKongSAR
    
    /// `CN-HK`
    case xianggangTebiexingzhengqu
    
    /// `CN-HL`
    case heilongjiangSheng
    
    /// `CN-HN`
    case hunanSheng
    
    /// `CN-JL`
    case jilinSheng
    
    /// `CN-JS`
    case jiangsuSheng
    
    /// `CN-JX`
    case jiangxiSheng
    
    /// `CN-LN`
    case liaoningSheng
    
    /// `CN-MO`
    case macaoSAR
    
    /// `CN-MO`
    case macauSAR
    
    /// `CN-MO`
    case aomenTebiexingzhengqu
    
    /// `CN-NM`
    case neiMongolZizhiqu
    
    /// `CN-NX`
    case ningxiaHuizuZizhiqu
    
    /// `CN-QH`
    case qinghaiSheng
    
    /// `CN-SC`
    case sichuanSheng
    
    /// `CN-SD`
    case shandongSheng
    
    /// `CN-SH`
    case shanghaiShi
    
    /// `CN-SN`
    case shaanxiSheng
    
    /// `CN-SX`
    case shanxiSheng
    
    /// `CN-TJ`
    case tianjinShi
    
    /// `CN-TW`
    case taiwanSheng
    
    /// `CN-XJ`
    case xinjiangUygurZizhiqu
    
    /// `CN-XZ`
    case xizangZizhiqu
    
    /// `CN-YN`
    case yunnanSheng
    
    /// `CN-ZJ`
    case zhejiangSheng
    
    /// `Andaman and Nicobar Islands`
    case andamanAndNicobarIslands
    
    /// `Andhra Pradesh`
    case andhraPradesh
    
    /// `APO`
    case armyPostOffice
    
    /// `Arunachal Pradesh`
    case arunachalPradesh
    
    /// `Assam`
    case assam
    
    /// `Bihar`
    case bihar
    
    /// `Chandigarh`
    case chandigarh
    
    /// `Chhattisgarh`
    case chhattisgarh
    
    /// `Dadra and Nagar Haveli`
    case dadraAndNagarHaveli
    
    /// `Daman and Diu`
    case damanAndDiu
    
    /// `Delhi (NCT)`
    case delhi
    
    /// `Goa`
    case goa
    
    /// `Gujarat`
    case gujarat
    
    /// `Haryana`
    case haryana
    
    /// `Himachal Pradesh`
    case himachalPradesh
    
    /// `Jammu and Kashmir`
    case jammuAndKashmir
    
    /// `Jharkhand`
    case jharkhand
    
    /// `Karnataka`
    case karnataka
    
    /// `Kerala`
    case kerala
    
    /// `Lakshadweep`
    case lakshadweep
    
    /// `Madhya Pradesh`
    case madhyaPradesh
    
    /// `Maharashtra`
    case maharashtra
    
    /// `Manipur`
    case manipur
    
    /// `Meghalaya`
    case meghalaya
    
    /// `Mizoram`
    case mizoram
    
    /// `Nagaland`
    case nagaland
    
    /// `Odisha`
    case odisha
    
    /// `Puducherry`
    case puducherry
    
    /// `Punjab`
    case punjab
    
    /// `Rajasthan`
    case rajasthan
    
    /// `Sikkim`
    case sikkim
    
    /// `Tamil Nadu`
    case tamilNadu
    
    /// `Telangana`
    case telangana
    
    /// `Tripura`
    case tripura
    
    /// `Uttar Pradesh`
    case uttarPradesh
    
    /// `Uttarakhand`
    case uttarakhand
    
    /// `West Bengal`
    case westBengal
    
    /// `ID-BA`
    case bali
    
    /// `ID-BB`
    case bangkaBelitung
    
    /// `ID-BT`
    case banten
    
    /// `ID-BE`
    case bengkulu
    
    /// `ID-YO`
    case diYogyakarta
    
    /// `ID-JK`
    case dkiJakarta
    
    /// `ID-GO`
    case gorontalo
    
    /// `ID-JA`
    case jambi
    
    /// `ID-JB`
    case jawaBarat
    
    /// `ID-JT`
    case jawaTengah
    
    /// `ID-JI`
    case jawaTimur
    
    /// `ID-KB`
    case kalimantanBarat
    
    /// `ID-KS`
    case kalimantanSelatan
    
    /// `ID-KT`
    case kalimantanTengah
    
    /// `ID-KI`
    case kalimantanTimur
    
    /// `ID-KU`
    case kalimantanUtara
    
    /// `ID-KR`
    case kepulauanRiau
    
    /// `ID-LA`
    case lampung
    
    /// `ID-MA`
    case maluku
    
    /// `ID-MU`
    case malukuUtara
    
    /// `ID-AC`
    case nanggroeAcehDarussalam
    
    /// `ID-NB`
    case nusaTenggaraBarat
    
    /// `ID-NT`
    case nusaTenggaraTimur
    
    /// `ID-PA`
    case papua
    
    /// `ID-PB`
    case papuaBarat
    
    /// `ID-RI`
    case riau
    
    /// `ID-SR`
    case sulawesiBarat
    
    /// `ID-SN`
    case sulawesiSelatan
    
    /// `ID-ST`
    case sulawesiTengah
    
    /// `ID-SG`
    case sulawesiTenggara
    
    /// `ID-SA`
    case sulawesiUtara
    
    /// `ID-SB`
    case sumateraBarat
    
    /// `ID-SS`
    case sumateraSelatan
    
    /// `ID-SU`
    case sumateraUtara
    
    /// `AG`
    case agrigento
    
    /// `AL`
    case alessandria
    
    /// `AN`
    case ancona
    
    /// `AO`
    case aosta
    
    /// `AR`
    case arezzo
    
    /// `AP`
    case ascoliPiceno
    
    /// `AT`
    case asti
    
    /// `AV`
    case avellino
    
    /// `BA`
    case bari
    
    /// `BT`
    case barlettaAndriaTrani
    
    /// `BL`
    case belluno
    
    /// `BN`
    case benevento
    
    /// `BG`
    case bergamo
    
    /// `BI`
    case biella
    
    /// `BO`
    case bologna
    
    /// `BZ`
    case bolzano
    
    /// `BS`
    case brescia
    
    /// `BR`
    case brindisi
    
    /// `CA`
    case cagliari
    
    /// `CL`
    case caltanissetta
    
    /// `CB`
    case campobasso
    
    /// `CI`
    case carboniaIglesias
    
    /// `CE`
    case caserta
    
    /// `CT`
    case catania
    
    /// `CZ`
    case catanzaro
    
    /// `CH`
    case chieti
    
    /// `CO`
    case como
    
    /// `CS`
    case cosenza
    
    /// `CR`
    case cremona
    
    /// `KR`
    case crotone
    
    /// `CN`
    case cuneo
    
    /// `EN`
    case enna
    
    /// `FM`
    case fermo
    
    /// `FE`
    case ferrara
    
    /// `FI`
    case firenze
    
    /// `FG`
    case foggia
    
    /// `FC`
    case forlìCesena
    
    /// `FR`
    case frosinone
    
    /// `GE`
    case genova
    
    /// `GO`
    case gorizia
    
    /// `GR`
    case grosseto
    
    /// `IM`
    case imperia
    
    /// `IS`
    case isernia
    
    /// `AQ`
    case laquila
    
    /// `SP`
    case laSpezia
    
    /// `LT`
    case latina
    
    /// `LE`
    case lecce
    
    /// `LC`
    case lecco
    
    /// `LI`
    case livorno
    
    /// `LO`
    case lodi
    
    /// `LU`
    case lucca
    
    /// `MC`
    case macerata
    
    /// `MN`
    case mantova
    
    /// `MS`
    case massaCarrara
    
    /// `MT`
    case matera
    
    /// `VS`
    case medioCampidano
    
    /// `ME`
    case messina
    
    /// `MI`
    case milano
    
    /// `MO`
    case modena
    
    /// `MB`
    case monzaEDellaBrianza
    
    /// `NA`
    case napoli
    
    /// `NO`
    case novara
    
    /// `NU`
    case nuoro
    
    /// `OG`
    case ogliastra
    
    /// `OT`
    case olbiaTempio
    
    /// `OR`
    case oristano
    
    /// `PD`
    case padova
    
    /// `PA`
    case palermo
    
    /// `PR`
    case parma
    
    /// `PV`
    case pavia
    
    /// `PG`
    case perugia
    
    /// `PU`
    case pesaroEUrbino
    
    /// `PE`
    case pescara
    
    /// `PC`
    case piacenza
    
    /// `PI`
    case pisa
    
    /// `PT`
    case pistoia
    
    /// `PN`
    case pordenone
    
    /// `PZ`
    case potenza
    
    /// `PO`
    case prato
    
    /// `RG`
    case ragusa
    
    /// `RA`
    case ravenna
    
    /// `RC`
    case reggioCalabria
    
    /// `RE`
    case reggioEmilia
    
    /// `RI`
    case rieti
    
    /// `RN`
    case rimini
    
    /// `RM`
    case roma
    
    /// `RO`
    case rovigo
    
    /// `SA`
    case salerno
    
    /// `SS`
    case sassari
    
    /// `SV`
    case savona
    
    /// `SI`
    case siena
    
    /// `SR`
    case siracusa
    
    /// `SO`
    case sondrio
    
    /// `TA`
    case taranto
    
    /// `TE`
    case teramo
    
    /// `TR`
    case terni
    
    /// `TO`
    case torino
    
    /// `TP`
    case trapani
    
    /// `TN`
    case trento
    
    /// `TV`
    case treviso
    
    /// `TS`
    case trieste
    
    /// `UD`
    case udine
    
    /// `VA`
    case varese
    
    /// `VE`
    case venezia
    
    /// `VB`
    case verbanoCusioOssola
    
    /// `VC`
    case vercelli
    
    /// `VR`
    case verona
    
    /// `VV`
    case viboValentia
    
    /// `VI`
    case vicenza
    
    /// `VT`
    case viterbo
    
    /// `AICHI-KEN`
    case aichi
    
    /// `AKITA-KEN`
    case akita
    
    /// `AOMORI-KEN`
    case aomori
    
    /// `CHIBA-KEN`
    case chiba
    
    /// `EHIME-KEN`
    case ehime
    
    /// `FUKUI-KEN`
    case fukui
    
    /// `FUKUOKA-KEN`
    case fukuoka
    
    /// `FUKUSHIMA-KEN`
    case fukushima
    
    /// `GIFU-KEN`
    case gifu
    
    /// `GUNMA-KEN`
    case gunma
    
    /// `HIROSHIMA-KEN`
    case hiroshima
    
    /// `HOKKAIDO`
    case hokkaido
    
    /// `HYOGO-KEN`
    case hyogo
    
    /// `IBARAKI-KEN`
    case ibaraki
    
    /// `ISHIKAWA-KEN`
    case ishikawa
    
    /// `IWATE-KEN`
    case iwate
    
    /// `KAGAWA-KEN`
    case kagawa
    
    /// `KAGOSHIMA-KEN`
    case kagoshima
    
    /// `KANAGAWA-KEN`
    case kanagawa
    
    /// `KOCHI-KEN`
    case kochi
    
    /// `KUMAMOTO-KEN`
    case kumamoto
    
    /// `KYOTO-FU`
    case kyoto
    
    /// `MIE-KEN`
    case mie
    
    /// `MIYAGI-KEN`
    case miyagi
    
    /// `MIYAZAKI-KEN`
    case miyazaki
    
    /// `NAGANO-KEN`
    case nagano
    
    /// `NAGASAKI-KEN`
    case nagasaki
    
    /// `NARA-KEN`
    case nara
    
    /// `NIIGATA-KEN`
    case niigata
    
    /// `OITA-KEN`
    case oita
    
    /// `OKAYAMA-KEN`
    case okayama
    
    /// `OKINAWA-KEN`
    case okinawa
    
    /// `OSAKA-FU`
    case osaka
    
    /// `SAGA-KEN`
    case saga
    
    /// `SAITAMA-KEN`
    case saitama
    
    /// `SHIGA-KEN`
    case shiga
    
    /// `SHIMANE-KEN`
    case shimane
    
    /// `SHIZUOKA-KEN`
    case shizuoka
    
    /// `TOCHIGI-KEN`
    case tochigi
    
    /// `TOKUSHIMA-KEN`
    case tokushima
    
    /// `TOKYO-TO`
    case tokyo
    
    /// `TOTTORI-KEN`
    case tottori
    
    /// `TOYAMA-KEN`
    case toyama
    
    /// `WAKAYAMA-KEN`
    case wakayama
    
    /// `YAMAGATA-KEN`
    case yamagata
    
    /// `YAMAGUCHI-KEN`
    case yamaguchi
    
    /// `YAMANASHI-KEN`
    case yamanashi
    
    /// `AGS`
    case aguascalientes
    
    /// `BC`
    case bajaCalifornia
    
    /// `BCS`
    case bajaCaliforniaSur
    
    /// `CAMP`
    case campeche
    
    /// `CHIS`
    case chiapas
    
    /// `CHIH`
    case chihuahua
    
    /// `CDMX`
    case ciudadDeMéxico
    
    /// `COAH`
    case coahuila
    
    /// `COL`
    case colima
    
    /// `DGO`
    case durango
    
    /// `MEX`
    case estadoDeMéxico
    
    /// `GTO`
    case guanajuato
    
    /// `GRO`
    case guerrero
    
    /// `HGO`
    case hidalgo
    
    /// `JAL`
    case jalisco
    
    /// `MICH`
    case michoacán
    
    /// `MOR`
    case morelos
    
    /// `NAY`
    case nayarit
    
    /// `NL`
    case nuevoLeón
    
    /// `OAX`
    case oaxaca
    
    /// `PUE`
    case puebla
    
    /// `QRO`
    case querétaro
    
    /// `Q ROO`
    case quintanaRoo
    
    /// `SLP`
    case sanLuisPotosí
    
    /// `SIN`
    case sinaloa
    
    /// `SON`
    case sonora
    
    /// `TAB`
    case tabasco
    
    /// `TAMPS`
    case tamaulipas
    
    /// `TLAX`
    case tlaxcala
    
    /// `VER`
    case veracruz
    
    /// `YUC`
    case yucatán
    
    /// `ZAC`
    case zacatecas
    
    /// `Amnat Charoen`
    case amnatCharoen
    
    /// `Ang Thong`
    case angThong
    
    /// `Bangkok`
    case bangkok
    
    /// `Bueng Kan`
    case buengKan
    
    /// `Buri Ram`
    case buriRam
    
    /// `Chachoengsao`
    case chachoengsao
    
    /// `Chai Nat`
    case chaiNat
    
    /// `Chaiyaphum`
    case chaiyaphum
    
    /// `Chanthaburi`
    case chanthaburi
    
    /// `Chiang Mai`
    case chiangMai
    
    /// `Chiang Rai`
    case chiangRai
    
    /// `Chon Buri`
    case chonBuri
    
    /// `Chumphon`
    case chumphon
    
    /// `Kalasin`
    case kalasin
    
    /// `Kamphaeng Phet`
    case kamphaengPhet
    
    /// `Kanchanaburi`
    case kanchanaburi
    
    /// `Khon Kaen`
    case khonKaen
    
    /// `Krabi`
    case krabi
    
    /// `Lampang`
    case lampang
    
    /// `Lamphun`
    case lamphun
    
    /// `Loei`
    case loei
    
    /// `Lop Buri`
    case lopBuri
    
    /// `Mae Hong Son`
    case maeHongSon
    
    /// `Maha Sarakham`
    case mahaSarakham
    
    /// `Mukdahan`
    case mukdahan
    
    /// `Nakhon Nayok`
    case nakhonNayok
    
    /// `Nakhon Pathom`
    case nakhonPathom
    
    /// `Nakhon Phanom`
    case nakhonPhanom
    
    /// `Nakhon Ratchasima`
    case nakhonRatchasima
    
    /// `Nakhon Sawan`
    case nakhonSawan
    
    /// `Nakhon Si Thammarat`
    case nakhonSiThammarat
    
    /// `Nan`
    case nan
    
    /// `Narathiwat`
    case narathiwat
    
    /// `Nong Bua Lamphu`
    case nongBuaLamphu
    
    /// `Nong Khai`
    case nongKhai
    
    /// `Nonthaburi`
    case nonthaburi
    
    /// `Pathum Thani`
    case pathumThani
    
    /// `Pattani`
    case pattani
    
    /// `Phang Nga`
    case phangNga
    
    /// `Phatthalung`
    case phatthalung
    
    /// `Phatthaya`
    case phatthaya
    
    /// `Phayao`
    case phayao
    
    /// `Phetchabun`
    case phetchabun
    
    /// `Phetchaburi`
    case phetchaburi
    
    /// `Phichit`
    case phichit
    
    /// `Phitsanulok`
    case phitsanulok
    
    /// `Phra Nakhon Si Ayutthaya`
    case phraNakhonSiAyutthaya
    
    /// `Phrae`
    case phrae
    
    /// `Phuket`
    case phuket
    
    /// `Prachin Buri`
    case prachinBuri
    
    /// `Prachuap Khiri Khan`
    case prachuapKhiriKhan
    
    /// `Ranong`
    case ranong
    
    /// `Ratchaburi`
    case ratchaburi
    
    /// `Rayong`
    case rayong
    
    /// `Roi Et`
    case roiEt
    
    /// `Sa Kaeo`
    case saKaeo
    
    /// `Sakon Nakhon`
    case sakonNakhon
    
    /// `Samut Prakan`
    case samutPrakan
    
    /// `Samut Sakhon`
    case samutSakhon
    
    /// `Samut Songkhram`
    case samutSongkhram
    
    /// `Saraburi`
    case saraburi
    
    /// `Satun`
    case satun
    
    /// `Si Sa Ket`
    case siSaKet
    
    /// `Sing Buri`
    case singBuri
    
    /// `Songkhla`
    case songkhla
    
    /// `Sukhothai`
    case sukhothai
    
    /// `Suphan Buri`
    case suphanBuri
    
    /// `Surat Thani`
    case suratThani
    
    /// `Surin`
    case surin
    
    /// `Tak`
    case tak
    
    /// `Trang`
    case trang
    
    /// `Trat`
    case trat
    
    /// `Ubon Ratchathani`
    case ubonRatchathani
    
    /// `Udon Thani`
    case udonThani
    
    /// `Uthai Thani`
    case uthaiThani
    
    /// `Uttaradit`
    case uttaradit
    
    /// `Yala`
    case yala
    
    /// `Yasothon`
    case yasothon
    
    /// `AL`
    case alabama
    
    /// `AK`
    case alaska
    
    /// `AZ`
    case arizona
    
    /// `AR`
    case arkansas
    
    /// `CA`
    case california
    
    /// `CO`
    case colorado
    
    /// `CT`
    case connecticut
    
    /// `DE`
    case delaware
    
    /// `DC`
    case districtOfColumbia
    
    /// `FL`
    case florida
    
    /// `GA`
    case georgia
    
    /// `HI`
    case hawaii
    
    /// `ID`
    case idaho
    
    /// `IL`
    case illinois
    
    /// `IN`
    case indiana
    
    /// `IA`
    case iowa
    
    /// `KS`
    case kansas
    
    /// `KY`
    case kentucky
    
    /// `LA`
    case louisiana
    
    /// `ME`
    case maine
    
    /// `MD`
    case maryland
    
    /// `MA`
    case massachusetts
    
    /// `MI`
    case michigan
    
    /// `MN`
    case minnesota
    
    /// `MS`
    case mississippi
    
    /// `MO`
    case missouri
    
    /// `MT`
    case montana
    
    /// `NE`
    case nebraska
    
    /// `NV`
    case nevada
    
    /// `NH`
    case newHampshire
    
    /// `NJ`
    case newJersey
    
    /// `NM`
    case newMexico
    
    /// `NY`
    case newYork
    
    /// `NC`
    case northCarolina
    
    /// `ND`
    case northDakota
    
    /// `OH`
    case ohio
    
    /// `OK`
    case oklahoma
    
    /// `OR`
    case oregon
    
    /// `PA`
    case pennsylvania
    
    /// `PR`
    case puertoRico
    
    /// `RI`
    case rhodeIsland
    
    /// `SC`
    case southCarolina
    
    /// `SD`
    case southDakota
    
    /// `TN`
    case tennessee
    
    /// `TX`
    case texas
    
    /// `UT`
    case utah
    
    /// `VT`
    case vermont
    
    /// `VA`
    case virginia
    
    /// `WA`
    case washington
    
    /// `WV`
    case westVirginia
    
    /// `WI`
    case wisconsin
    
    /// `WY`
    case wyoming
    
    /// `AA`
    case armedForcesAmericas
    
    /// `AE`
    case armedForcesEurope
    
    /// `AP`
    case armedForcesPacific
    
    /// `AS`
    case americanSamoa
    
    /// `FM`
    case federatedStatesOfMicronesia
    
    /// `GU`
    case guam
    
    /// `MH`
    case marshallIslands
    
    /// `MP`
    case northernMarianaIslands
    
    /// `PW`
    case palau
    
    /// `VI`
    case virginIslands
    
    /// See [`RawRepresentable.rawValue`](https://developer.apple.com/documentation/swift/rawrepresentable/1540698-rawvalue).
    public var rawValue: String {
        switch self {
        case .buenosAiresCiudad: return "CIUDAD AUTÓNOMA DE BUENOS AIRES"
        case .buenosAiresProvincia: return "BUENOS AIRES"
        case .catamarca: return "CATAMARCA"
        case .chaco: return "CHACO"
        case .chubut: return "CHUBUT"
        case .corrientes: return "CORRIENTES"
        case .córdoba: return "CÓRDOBA"
        case .entreRíos: return "ENTRE RÍOS"
        case .formosa: return "FORMOSA"
        case .jujuy: return "JUJUY"
        case .laPampa: return "LA PAMPA"
        case .laRioja: return "LA RIOJA"
        case .mendoza: return "MENDOZA"
        case .misiones: return "MISIONES"
        case .neuquén: return "NEUQUÉN"
        case .ríoNegro: return "RÍO NEGRO"
        case .salta: return "SALTA"
        case .sanJuan: return "SAN JUAN"
        case .sanLuis: return "SAN LUIS"
        case .santaCruz: return "SANTA CRUZ"
        case .santaFe: return "SANTA FE"
        case .santiagoDelEstero: return "SANTIAGO DEL ESTERO"
        case .tierraDelFuego: return "TIERRA DEL FUEGO"
        case .tucumán: return "TUCUMÁN"
        case .acre: return "AC"
        case .alagoas: return "AL"
        case .amapá: return "AP"
        case .amazonas: return "AM"
        case .bahia: return "BA"
        case .ceará: return "CE"
        case .distritoFederal: return "DF"
        case .espíritoSanto: return "ES"
        case .goiás: return "GO"
        case .maranhão: return "MA"
        case .matoGrosso: return "MT"
        case .matoGrossoDoSul: return "MS"
        case .minasGerais: return "MG"
        case .paraná: return "PR"
        case .paraíba: return "PB"
        case .pará: return "PA"
        case .pernambuco: return "PE"
        case .piauí: return "PI"
        case .rioGrandeDoNorte: return "RN"
        case .rioGrandeDoSul: return "RS"
        case .rioDeJaneiro: return "RJ"
        case .rondônia: return "RO"
        case .roraima: return "RR"
        case .santaCatarina: return "SC"
        case .sergipe: return "SE"
        case .sãoPaulo: return "SP"
        case .tocantins: return "TO"
        case .alberta: return "AB"
        case .britishColumbia: return "BC"
        case .manitoba: return "MB"
        case .newBrunswick: return "NB"
        case .newfoundlandAndLabrador: return "NL"
        case .northwestTerritories: return "NT"
        case .novaScotia: return "NS"
        case .nunavut: return "NU"
        case .ontario: return "ON"
        case .princeEdwardIsland: return "PE"
        case .quebec: return "QC"
        case .saskatchewan: return "SK"
        case .yukon: return "YT"
        case .anhuiSheng: return "CN-AH"
        case .beijingShi: return "CN-BJ"
        case .chongqingShi: return "CN-CQ"
        case .fujianSheng: return "CN-FJ"
        case .guangdongSheng: return "CN-GD"
        case .gansuSheng: return "CN-GS"
        case .guangxiZhuangzuZizhiqu: return "CN-GX"
        case .guizhouSheng: return "CN-GZ"
        case .henanSheng: return "CN-HA"
        case .hubeiSheng: return "CN-HB"
        case .hebeiSheng: return "CN-HE"
        case .hainanSheng: return "CN-HI"
        case .hongKongSAR: return "CN-HK"
        case .xianggangTebiexingzhengqu: return "CN-HK"
        case .heilongjiangSheng: return "CN-HL"
        case .hunanSheng: return "CN-HN"
        case .jilinSheng: return "CN-JL"
        case .jiangsuSheng: return "CN-JS"
        case .jiangxiSheng: return "CN-JX"
        case .liaoningSheng: return "CN-LN"
        case .macaoSAR: return "CN-MO"
        case .macauSAR: return "CN-MO"
        case .aomenTebiexingzhengqu: return "CN-MO"
        case .neiMongolZizhiqu: return "CN-NM"
        case .ningxiaHuizuZizhiqu: return "CN-NX"
        case .qinghaiSheng: return "CN-QH"
        case .sichuanSheng: return "CN-SC"
        case .shandongSheng: return "CN-SD"
        case .shanghaiShi: return "CN-SH"
        case .shaanxiSheng: return "CN-SN"
        case .shanxiSheng: return "CN-SX"
        case .tianjinShi: return "CN-TJ"
        case .taiwanSheng: return "CN-TW"
        case .xinjiangUygurZizhiqu: return "CN-XJ"
        case .xizangZizhiqu: return "CN-XZ"
        case .yunnanSheng: return "CN-YN"
        case .zhejiangSheng: return "CN-ZJ"
        case .andamanAndNicobarIslands: return "Andaman and Nicobar Islands"
        case .andhraPradesh: return "Andhra Pradesh"
        case .armyPostOffice: return "APO"
        case .arunachalPradesh: return "Arunachal Pradesh"
        case .assam: return "Assam"
        case .bihar: return "Bihar"
        case .chandigarh: return "Chandigarh"
        case .chhattisgarh: return "Chhattisgarh"
        case .dadraAndNagarHaveli: return "Dadra and Nagar Haveli"
        case .damanAndDiu: return "Daman and Diu"
        case .delhi: return "Delhi (NCT)"
        case .goa: return "Goa"
        case .gujarat: return "Gujarat"
        case .haryana: return "Haryana"
        case .himachalPradesh: return "Himachal Pradesh"
        case .jammuAndKashmir: return "Jammu and Kashmir"
        case .jharkhand: return "Jharkhand"
        case .karnataka: return "Karnataka"
        case .kerala: return "Kerala"
        case .lakshadweep: return "Lakshadweep"
        case .madhyaPradesh: return "Madhya Pradesh"
        case .maharashtra: return "Maharashtra"
        case .manipur: return "Manipur"
        case .meghalaya: return "Meghalaya"
        case .mizoram: return "Mizoram"
        case .nagaland: return "Nagaland"
        case .odisha: return "Odisha"
        case .puducherry: return "Puducherry"
        case .punjab: return "Punjab"
        case .rajasthan: return "Rajasthan"
        case .sikkim: return "Sikkim"
        case .tamilNadu: return "Tamil Nadu"
        case .telangana: return "Telangana"
        case .tripura: return "Tripura"
        case .uttarPradesh: return "Uttar Pradesh"
        case .uttarakhand: return "Uttarakhand"
        case .westBengal: return "West Bengal"
        case .bali: return "ID-BA"
        case .bangkaBelitung: return "ID-BB"
        case .banten: return "ID-BT"
        case .bengkulu: return "ID-BE"
        case .diYogyakarta: return "ID-YO"
        case .dkiJakarta: return "ID-JK"
        case .gorontalo: return "ID-GO"
        case .jambi: return "ID-JA"
        case .jawaBarat: return "ID-JB"
        case .jawaTengah: return "ID-JT"
        case .jawaTimur: return "ID-JI"
        case .kalimantanBarat: return "ID-KB"
        case .kalimantanSelatan: return "ID-KS"
        case .kalimantanTengah: return "ID-KT"
        case .kalimantanTimur: return "ID-KI"
        case .kalimantanUtara: return "ID-KU"
        case .kepulauanRiau: return "ID-KR"
        case .lampung: return "ID-LA"
        case .maluku: return "ID-MA"
        case .malukuUtara: return "ID-MU"
        case .nanggroeAcehDarussalam: return "ID-AC"
        case .nusaTenggaraBarat: return "ID-NB"
        case .nusaTenggaraTimur: return "ID-NT"
        case .papua: return "ID-PA"
        case .papuaBarat: return "ID-PB"
        case .riau: return "ID-RI"
        case .sulawesiBarat: return "ID-SR"
        case .sulawesiSelatan: return "ID-SN"
        case .sulawesiTengah: return "ID-ST"
        case .sulawesiTenggara: return "ID-SG"
        case .sulawesiUtara: return "ID-SA"
        case .sumateraBarat: return "ID-SB"
        case .sumateraSelatan: return "ID-SS"
        case .sumateraUtara: return "ID-SU"
        case .agrigento: return "AG"
        case .alessandria: return "AL"
        case .ancona: return "AN"
        case .aosta: return "AO"
        case .arezzo: return "AR"
        case .ascoliPiceno: return "AP"
        case .asti: return "AT"
        case .avellino: return "AV"
        case .bari: return "BA"
        case .barlettaAndriaTrani: return "BT"
        case .belluno: return "BL"
        case .benevento: return "BN"
        case .bergamo: return "BG"
        case .biella: return "BI"
        case .bologna: return "BO"
        case .bolzano: return "BZ"
        case .brescia: return "BS"
        case .brindisi: return "BR"
        case .cagliari: return "CA"
        case .caltanissetta: return "CL"
        case .campobasso: return "CB"
        case .carboniaIglesias: return "CI"
        case .caserta: return "CE"
        case .catania: return "CT"
        case .catanzaro: return "CZ"
        case .chieti: return "CH"
        case .como: return "CO"
        case .cosenza: return "CS"
        case .cremona: return "CR"
        case .crotone: return "KR"
        case .cuneo: return "CN"
        case .enna: return "EN"
        case .fermo: return "FM"
        case .ferrara: return "FE"
        case .firenze: return "FI"
        case .foggia: return "FG"
        case .forlìCesena: return "FC"
        case .frosinone: return "FR"
        case .genova: return "GE"
        case .gorizia: return "GO"
        case .grosseto: return "GR"
        case .imperia: return "IM"
        case .isernia: return "IS"
        case .laquila: return "AQ"
        case .laSpezia: return "SP"
        case .latina: return "LT"
        case .lecce: return "LE"
        case .lecco: return "LC"
        case .livorno: return "LI"
        case .lodi: return "LO"
        case .lucca: return "LU"
        case .macerata: return "MC"
        case .mantova: return "MN"
        case .massaCarrara: return "MS"
        case .matera: return "MT"
        case .medioCampidano: return "VS"
        case .messina: return "ME"
        case .milano: return "MI"
        case .modena: return "MO"
        case .monzaEDellaBrianza: return "MB"
        case .napoli: return "NA"
        case .novara: return "NO"
        case .nuoro: return "NU"
        case .ogliastra: return "OG"
        case .olbiaTempio: return "OT"
        case .oristano: return "OR"
        case .padova: return "PD"
        case .palermo: return "PA"
        case .parma: return "PR"
        case .pavia: return "PV"
        case .perugia: return "PG"
        case .pesaroEUrbino: return "PU"
        case .pescara: return "PE"
        case .piacenza: return "PC"
        case .pisa: return "PI"
        case .pistoia: return "PT"
        case .pordenone: return "PN"
        case .potenza: return "PZ"
        case .prato: return "PO"
        case .ragusa: return "RG"
        case .ravenna: return "RA"
        case .reggioCalabria: return "RC"
        case .reggioEmilia: return "RE"
        case .rieti: return "RI"
        case .rimini: return "RN"
        case .roma: return "RM"
        case .rovigo: return "RO"
        case .salerno: return "SA"
        case .sassari: return "SS"
        case .savona: return "SV"
        case .siena: return "SI"
        case .siracusa: return "SR"
        case .sondrio: return "SO"
        case .taranto: return "TA"
        case .teramo: return "TE"
        case .terni: return "TR"
        case .torino: return "TO"
        case .trapani: return "TP"
        case .trento: return "TN"
        case .treviso: return "TV"
        case .trieste: return "TS"
        case .udine: return "UD"
        case .varese: return "VA"
        case .venezia: return "VE"
        case .verbanoCusioOssola: return "VB"
        case .vercelli: return "VC"
        case .verona: return "VR"
        case .viboValentia: return "VV"
        case .vicenza: return "VI"
        case .viterbo: return "VT"
        case .aichi: return "AICHI-KEN"
        case .akita: return "AKITA-KEN"
        case .aomori: return "AOMORI-KEN"
        case .chiba: return "CHIBA-KEN"
        case .ehime: return "EHIME-KEN"
        case .fukui: return "FUKUI-KEN"
        case .fukuoka: return "FUKUOKA-KEN"
        case .fukushima: return "FUKUSHIMA-KEN"
        case .gifu: return "GIFU-KEN"
        case .gunma: return "GUNMA-KEN"
        case .hiroshima: return "HIROSHIMA-KEN"
        case .hokkaido: return "HOKKAIDO"
        case .hyogo: return "HYOGO-KEN"
        case .ibaraki: return "IBARAKI-KEN"
        case .ishikawa: return "ISHIKAWA-KEN"
        case .iwate: return "IWATE-KEN"
        case .kagawa: return "KAGAWA-KEN"
        case .kagoshima: return "KAGOSHIMA-KEN"
        case .kanagawa: return "KANAGAWA-KEN"
        case .kochi: return "KOCHI-KEN"
        case .kumamoto: return "KUMAMOTO-KEN"
        case .kyoto: return "KYOTO-FU"
        case .mie: return "MIE-KEN"
        case .miyagi: return "MIYAGI-KEN"
        case .miyazaki: return "MIYAZAKI-KEN"
        case .nagano: return "NAGANO-KEN"
        case .nagasaki: return "NAGASAKI-KEN"
        case .nara: return "NARA-KEN"
        case .niigata: return "NIIGATA-KEN"
        case .oita: return "OITA-KEN"
        case .okayama: return "OKAYAMA-KEN"
        case .okinawa: return "OKINAWA-KEN"
        case .osaka: return "OSAKA-FU"
        case .saga: return "SAGA-KEN"
        case .saitama: return "SAITAMA-KEN"
        case .shiga: return "SHIGA-KEN"
        case .shimane: return "SHIMANE-KEN"
        case .shizuoka: return "SHIZUOKA-KEN"
        case .tochigi: return "TOCHIGI-KEN"
        case .tokushima: return "TOKUSHIMA-KEN"
        case .tokyo: return "TOKYO-TO"
        case .tottori: return "TOTTORI-KEN"
        case .toyama: return "TOYAMA-KEN"
        case .wakayama: return "WAKAYAMA-KEN"
        case .yamagata: return "YAMAGATA-KEN"
        case .yamaguchi: return "YAMAGUCHI-KEN"
        case .yamanashi: return "YAMANASHI-KEN"
        case .aguascalientes: return "AGS"
        case .bajaCalifornia: return "BC"
        case .bajaCaliforniaSur: return "BCS"
        case .campeche: return "CAMP"
        case .chiapas: return "CHIS"
        case .chihuahua: return "CHIH"
        case .ciudadDeMéxico: return "CDMX"
        case .coahuila: return "COAH"
        case .colima: return "COL"
        case .durango: return "DGO"
        case .estadoDeMéxico: return "MEX"
        case .guanajuato: return "GTO"
        case .guerrero: return "GRO"
        case .hidalgo: return "HGO"
        case .jalisco: return "JAL"
        case .michoacán: return "MICH"
        case .morelos: return "MOR"
        case .nayarit: return "NAY"
        case .nuevoLeón: return "NL"
        case .oaxaca: return "OAX"
        case .puebla: return "PUE"
        case .querétaro: return "QRO"
        case .quintanaRoo: return "Q ROO"
        case .sanLuisPotosí: return "SLP"
        case .sinaloa: return "SIN"
        case .sonora: return "SON"
        case .tabasco: return "TAB"
        case .tamaulipas: return "TAMPS"
        case .tlaxcala: return "TLAX"
        case .veracruz: return "VER"
        case .yucatán: return "YUC"
        case .zacatecas: return "ZAC"
        case .amnatCharoen: return "Amnat Charoen"
        case .angThong: return "Ang Thong"
        case .bangkok: return "Bangkok"
        case .buengKan: return "Bueng Kan"
        case .buriRam: return "Buri Ram"
        case .chachoengsao: return "Chachoengsao"
        case .chaiNat: return "Chai Nat"
        case .chaiyaphum: return "Chaiyaphum"
        case .chanthaburi: return "Chanthaburi"
        case .chiangMai: return "Chiang Mai"
        case .chiangRai: return "Chiang Rai"
        case .chonBuri: return "Chon Buri"
        case .chumphon: return "Chumphon"
        case .kalasin: return "Kalasin"
        case .kamphaengPhet: return "Kamphaeng Phet"
        case .kanchanaburi: return "Kanchanaburi"
        case .khonKaen: return "Khon Kaen"
        case .krabi: return "Krabi"
        case .lampang: return "Lampang"
        case .lamphun: return "Lamphun"
        case .loei: return "Loei"
        case .lopBuri: return "Lop Buri"
        case .maeHongSon: return "Mae Hong Son"
        case .mahaSarakham: return "Maha Sarakham"
        case .mukdahan: return "Mukdahan"
        case .nakhonNayok: return "Nakhon Nayok"
        case .nakhonPathom: return "Nakhon Pathom"
        case .nakhonPhanom: return "Nakhon Phanom"
        case .nakhonRatchasima: return "Nakhon Ratchasima"
        case .nakhonSawan: return "Nakhon Sawan"
        case .nakhonSiThammarat: return "Nakhon Si Thammarat"
        case .nan: return "Nan"
        case .narathiwat: return "Narathiwat"
        case .nongBuaLamphu: return "Nong Bua Lamphu"
        case .nongKhai: return "Nong Khai"
        case .nonthaburi: return "Nonthaburi"
        case .pathumThani: return "Pathum Thani"
        case .pattani: return "Pattani"
        case .phangNga: return "Phang Nga"
        case .phatthalung: return "Phatthalung"
        case .phatthaya: return "Phatthaya"
        case .phayao: return "Phayao"
        case .phetchabun: return "Phetchabun"
        case .phetchaburi: return "Phetchaburi"
        case .phichit: return "Phichit"
        case .phitsanulok: return "Phitsanulok"
        case .phraNakhonSiAyutthaya: return "Phra Nakhon Si Ayutthaya"
        case .phrae: return "Phrae"
        case .phuket: return "Phuket"
        case .prachinBuri: return "Prachin Buri"
        case .prachuapKhiriKhan: return "Prachuap Khiri Khan"
        case .ranong: return "Ranong"
        case .ratchaburi: return "Ratchaburi"
        case .rayong: return "Rayong"
        case .roiEt: return "Roi Et"
        case .saKaeo: return "Sa Kaeo"
        case .sakonNakhon: return "Sakon Nakhon"
        case .samutPrakan: return "Samut Prakan"
        case .samutSakhon: return "Samut Sakhon"
        case .samutSongkhram: return "Samut Songkhram"
        case .saraburi: return "Saraburi"
        case .satun: return "Satun"
        case .siSaKet: return "Si Sa Ket"
        case .singBuri: return "Sing Buri"
        case .songkhla: return "Songkhla"
        case .sukhothai: return "Sukhothai"
        case .suphanBuri: return "Suphan Buri"
        case .suratThani: return "Surat Thani"
        case .surin: return "Surin"
        case .tak: return "Tak"
        case .trang: return "Trang"
        case .trat: return "Trat"
        case .ubonRatchathani: return "Ubon Ratchathani"
        case .udonThani: return "Udon Thani"
        case .uthaiThani: return "Uthai Thani"
        case .uttaradit: return "Uttaradit"
        case .yala: return "Yala"
        case .yasothon: return "Yasothon"
        case .alabama: return "AL"
        case .alaska: return "AK"
        case .arizona: return "AZ"
        case .arkansas: return "AR"
        case .california: return "CA"
        case .colorado: return "CO"
        case .connecticut: return "CT"
        case .delaware: return "DE"
        case .districtOfColumbia: return "DC"
        case .florida: return "FL"
        case .georgia: return "GA"
        case .hawaii: return "HI"
        case .idaho: return "ID"
        case .illinois: return "IL"
        case .indiana: return "IN"
        case .iowa: return "IA"
        case .kansas: return "KS"
        case .kentucky: return "KY"
        case .louisiana: return "LA"
        case .maine: return "ME"
        case .maryland: return "MD"
        case .massachusetts: return "MA"
        case .michigan: return "MI"
        case .minnesota: return "MN"
        case .mississippi: return "MS"
        case .missouri: return "MO"
        case .montana: return "MT"
        case .nebraska: return "NE"
        case .nevada: return "NV"
        case .newHampshire: return "NH"
        case .newJersey: return "NJ"
        case .newMexico: return "NM"
        case .newYork: return "NY"
        case .northCarolina: return "NC"
        case .northDakota: return "ND"
        case .ohio: return "OH"
        case .oklahoma: return "OK"
        case .oregon: return "OR"
        case .pennsylvania: return "PA"
        case .puertoRico: return "PR"
        case .rhodeIsland: return "RI"
        case .southCarolina: return "SC"
        case .southDakota: return "SD"
        case .tennessee: return "TN"
        case .texas: return "TX"
        case .utah: return "UT"
        case .vermont: return "VT"
        case .virginia: return "VA"
        case .washington: return "WA"
        case .westVirginia: return "WV"
        case .wisconsin: return "WI"
        case .wyoming: return "WY"
        case .armedForcesAmericas: return "AA"
        case .armedForcesEurope: return "AE"
        case .armedForcesPacific: return "AP"
        case .americanSamoa: return "AS"
        case .federatedStatesOfMicronesia: return "FM"
        case .guam: return "GU"
        case .marshallIslands: return "MH"
        case .northernMarianaIslands: return "MP"
        case .palau: return "PW"
        case .virginIslands: return "VI"
        }
    }
}
