import Vapor

/// Valid state and province codes for countries supported by PayPal.
public enum Province: String, Hashable, CaseIterable, Content {

    /// `CIUDAD AUTÓNOMA DE BUENOS AIRES`
    case ciudadAutónomaDeBuenosAires = "CIUDAD AUTÓNOMA DE BUENOS AIRES"
    
    /// `BUENOS AIRES`
    case buenosAires = "BUENOS AIRES"
    
    /// `CATAMARCA`
    case catamarca = "CATAMARCA"
    
    /// `CHACO`
    case chaco = "CHACO"
    
    /// `CHUBUT`
    case chubut = "CHUBUT"
    
    /// `CORRIENTES`
    case corrientes = "CORRIENTES"
    
    /// `CÓRDOBA`
    case córdoba = "CÓRDOBA"
    
    /// `ENTRE RÍOS`
    case entreRíos = "ENTRE RÍOS"
    
    /// `FORMOSA`
    case formosa = "FORMOSA"
    
    /// `JUJUY`
    case jujuy = "JUJUY"
    
    /// `LA PAMPA`
    case laPampa = "LA PAMPA"
    
    /// `LA RIOJA`
    case laRioja = "LA RIOJA"
    
    /// `MENDOZA`
    case mendoza = "MENDOZA"
    
    /// `MISIONES`
    case misiones = "MISIONES"
    
    /// `NEUQUÉN`
    case neuquén = "NEUQUÉN"
    
    /// `RÍO NEGRO`
    case ríoNegro = "RÍO NEGRO"
    
    /// `SALTA`
    case salta = "SALTA"
    
    /// `SAN JUAN`
    case sanJuan = "SAN JUAN"
    
    /// `SAN LUIS`
    case sanLuis = "SAN LUIS"
    
    /// `SANTA CRUZ`
    case santaCruz = "SANTA CRUZ"
    
    /// `SANTA FE`
    case santaFe = "SANTA FE"
    
    /// `SANTIAGO DEL ESTERO`
    case santiagoDelEstero = "SANTIAGO DEL ESTERO"
    
    /// `TIERRA DEL FUEGO`
    case tierraDelFuego = "TIERRA DEL FUEGO"
    
    /// `TUCUMÁN`
    case tucumán = "TUCUMÁN"
    
    /// `AC`
    case ac = "AC"
    
    /// `AL`
    case al = "AL"
    
    /// `AP`
    case ap = "AP"
    
    /// `AM`
    case am = "AM"
    
    /// `BA`
    case ba = "BA"
    
    /// `CE`
    case ce = "CE"
    
    /// `DF`
    case df = "DF"
    
    /// `ES`
    case es = "ES"
    
    /// `GO`
    case go = "GO"
    
    /// `MA`
    case ma = "MA"
    
    /// `MT`
    case mt = "MT"
    
    /// `MS`
    case ms = "MS"
    
    /// `MG`
    case mg = "MG"
    
    /// `PR`
    case pr = "PR"
    
    /// `PB`
    case pb = "PB"
    
    /// `PA`
    case pa = "PA"
    
    /// `PE`
    case pe = "PE"
    
    /// `PI`
    case pi = "PI"
    
    /// `RN`
    case rn = "RN"
    
    /// `RS`
    case rs = "RS"
    
    /// `RJ`
    case rj = "RJ"
    
    /// `RO`
    case ro = "RO"
    
    /// `RR`
    case rr = "RR"
    
    /// `SC`
    case sc = "SC"
    
    /// `SE`
    case se = "SE"
    
    /// `SP`
    case sp = "SP"
    
    /// `TO`
    case to = "TO"
    
    /// `AB`
    case ab = "AB"
    
    /// `BC`
    case bc = "BC"
    
    /// `MB`
    case mb = "MB"
    
    /// `NB`
    case nb = "NB"
    
    /// `NL`
    case nl = "NL"
    
    /// `NT`
    case nt = "NT"
    
    /// `NS`
    case ns = "NS"
    
    /// `NU`
    case nu = "NU"
    
    /// `ON`
    case on = "ON"
    
    /// `QC`
    case qc = "QC"
    
    /// `SK`
    case sk = "SK"
    
    /// `YT`
    case yt = "YT"
    
    /// `CN-AH`
    case cnAh = "CN-AH"
    
    /// `CN-BJ`
    case cnBj = "CN-BJ"
    
    /// `CN-CQ`
    case cnCq = "CN-CQ"
    
    /// `CN-FJ`
    case cnFj = "CN-FJ"
    
    /// `CN-GD`
    case cnGd = "CN-GD"
    
    /// `CN-GS`
    case cnGs = "CN-GS"
    
    /// `CN-GX`
    case cnGx = "CN-GX"
    
    /// `CN-GZ`
    case cnGz = "CN-GZ"
    
    /// `CN-HA`
    case cnHa = "CN-HA"
    
    /// `CN-HB`
    case cnHb = "CN-HB"
    
    /// `CN-HE`
    case cnHe = "CN-HE"
    
    /// `CN-HI`
    case cnHi = "CN-HI"
    
    /// `CN-HK`
    case cnHk = "CN-HK"
    
    /// `CN-HL`
    case cnHl = "CN-HL"
    
    /// `CN-HN`
    case cnHn = "CN-HN"
    
    /// `CN-JL`
    case cnJl = "CN-JL"
    
    /// `CN-JS`
    case cnJs = "CN-JS"
    
    /// `CN-JX`
    case cnJx = "CN-JX"
    
    /// `CN-LN`
    case cnLn = "CN-LN"
    
    /// `CN-MO`
    case cnMo = "CN-MO"
    
    /// `CN-NM`
    case cnNm = "CN-NM"
    
    /// `CN-NX`
    case cnNx = "CN-NX"
    
    /// `CN-QH`
    case cnQh = "CN-QH"
    
    /// `CN-SC`
    case cnSc = "CN-SC"
    
    /// `CN-SD`
    case cnSd = "CN-SD"
    
    /// `CN-SH`
    case cnSh = "CN-SH"
    
    /// `CN-SN`
    case cnSn = "CN-SN"
    
    /// `CN-SX`
    case cnSx = "CN-SX"
    
    /// `CN-TJ`
    case cnTj = "CN-TJ"
    
    /// `CN-TW`
    case cnTw = "CN-TW"
    
    /// `CN-XJ`
    case cnXj = "CN-XJ"
    
    /// `CN-XZ`
    case cnXz = "CN-XZ"
    
    /// `CN-YN`
    case cnYn = "CN-YN"
    
    /// `CN-ZJ`
    case cnZj = "CN-ZJ"
    
    /// `Andaman and Nicobar Islands`
    case andamanAndNicobarIslands = "Andaman and Nicobar Islands"
    
    /// `Andhra Pradesh`
    case andhraPradesh = "Andhra Pradesh"
    
    /// `APO`
    case apo = "APO"
    
    /// `Arunachal Pradesh`
    case arunachalPradesh = "Arunachal Pradesh"
    
    /// `Assam`
    case assam = "Assam"
    
    /// `Bihar`
    case bihar = "Bihar"
    
    /// `Chandigarh`
    case chandigarh = "Chandigarh"
    
    /// `Chhattisgarh`
    case chhattisgarh = "Chhattisgarh"
    
    /// `Dadra and Nagar Haveli`
    case dadraAndNagarHaveli = "Dadra and Nagar Haveli"
    
    /// `Daman and Diu`
    case damanAndDiu = "Daman and Diu"
    
    /// `Delhi (NCT)`
    case delhiNCT = "Delhi (NCT)"
    
    /// `Goa`
    case goa = "Goa"
    
    /// `Gujarat`
    case gujarat = "Gujarat"
    
    /// `Haryana`
    case haryana = "Haryana"
    
    /// `Himachal Pradesh`
    case himachalPradesh = "Himachal Pradesh"
    
    /// `Jammu and Kashmir`
    case jammuAndKashmir = "Jammu and Kashmir"
    
    /// `Jharkhand`
    case jharkhand = "Jharkhand"
    
    /// `Karnataka`
    case karnataka = "Karnataka"
    
    /// `Kerala`
    case kerala = "Kerala"
    
    /// `Lakshadweep`
    case lakshadweep = "Lakshadweep"
    
    /// `Madhya Pradesh`
    case madhyaPradesh = "Madhya Pradesh"
    
    /// `Maharashtra`
    case maharashtra = "Maharashtra"
    
    /// `Manipur`
    case manipur = "Manipur"
    
    /// `Meghalaya`
    case meghalaya = "Meghalaya"
    
    /// `Mizoram`
    case mizoram = "Mizoram"
    
    /// `Nagaland`
    case nagaland = "Nagaland"
    
    /// `Odisha`
    case odisha = "Odisha"
    
    /// `Puducherry`
    case puducherry = "Puducherry"
    
    /// `Punjab`
    case punjab = "Punjab"
    
    /// `Rajasthan`
    case rajasthan = "Rajasthan"
    
    /// `Sikkim`
    case sikkim = "Sikkim"
    
    /// `Tamil Nadu`
    case tamilNadu = "Tamil Nadu"
    
    /// `Telangana`
    case telangana = "Telangana"
    
    /// `Tripura`
    case tripura = "Tripura"
    
    /// `Uttar Pradesh`
    case uttarPradesh = "Uttar Pradesh"
    
    /// `Uttarakhand`
    case uttarakhand = "Uttarakhand"
    
    /// `West Bengal`
    case westBengal = "West Bengal"
    
    /// `ID-BA`
    case idBa = "ID-BA"
    
    /// `ID-BB`
    case idBb = "ID-BB"
    
    /// `ID-BT`
    case idBt = "ID-BT"
    
    /// `ID-BE`
    case idBe = "ID-BE"
    
    /// `ID-YO`
    case idYo = "ID-YO"
    
    /// `ID-JK`
    case idJk = "ID-JK"
    
    /// `ID-GO`
    case idGo = "ID-GO"
    
    /// `ID-JA`
    case idJa = "ID-JA"
    
    /// `ID-JB`
    case idJb = "ID-JB"
    
    /// `ID-JT`
    case idJt = "ID-JT"
    
    /// `ID-JI`
    case idJi = "ID-JI"
    
    /// `ID-KB`
    case idKb = "ID-KB"
    
    /// `ID-KS`
    case idKs = "ID-KS"
    
    /// `ID-KT`
    case idKt = "ID-KT"
    
    /// `ID-KI`
    case idKi = "ID-KI"
    
    /// `ID-KU`
    case idKu = "ID-KU"
    
    /// `ID-KR`
    case idKr = "ID-KR"
    
    /// `ID-LA`
    case idLa = "ID-LA"
    
    /// `ID-MA`
    case idMa = "ID-MA"
    
    /// `ID-MU`
    case idMu = "ID-MU"
    
    /// `ID-AC`
    case idAc = "ID-AC"
    
    /// `ID-NB`
    case idNb = "ID-NB"
    
    /// `ID-NT`
    case idNt = "ID-NT"
    
    /// `ID-PA`
    case idPa = "ID-PA"
    
    /// `ID-PB`
    case idPb = "ID-PB"
    
    /// `ID-RI`
    case idRi = "ID-RI"
    
    /// `ID-SR`
    case idSr = "ID-SR"
    
    /// `ID-SN`
    case idSn = "ID-SN"
    
    /// `ID-ST`
    case idSt = "ID-ST"
    
    /// `ID-SG`
    case idSg = "ID-SG"
    
    /// `ID-SA`
    case idSa = "ID-SA"
    
    /// `ID-SB`
    case idSb = "ID-SB"
    
    /// `ID-SS`
    case idSs = "ID-SS"
    
    /// `ID-SU`
    case idSu = "ID-SU"
    
    /// `AG`
    case ag = "AG"
    
    /// `AN`
    case an = "AN"
    
    /// `AO`
    case ao = "AO"
    
    /// `AR`
    case ar = "AR"
    
    /// `AT`
    case at = "AT"
    
    /// `AV`
    case av = "AV"
    
    /// `BT`
    case bt = "BT"
    
    /// `BL`
    case bl = "BL"
    
    /// `BN`
    case bn = "BN"
    
    /// `BG`
    case bg = "BG"
    
    /// `BI`
    case bi = "BI"
    
    /// `BO`
    case bo = "BO"
    
    /// `BZ`
    case bz = "BZ"
    
    /// `BS`
    case bs = "BS"
    
    /// `BR`
    case br = "BR"
    
    /// `CA`
    case ca = "CA"
    
    /// `CL`
    case cl = "CL"
    
    /// `CB`
    case cb = "CB"
    
    /// `CI`
    case ci = "CI"
    
    /// `CT`
    case ct = "CT"
    
    /// `CZ`
    case cz = "CZ"
    
    /// `CH`
    case ch = "CH"
    
    /// `CO`
    case co = "CO"
    
    /// `CS`
    case cs = "CS"
    
    /// `CR`
    case cr = "CR"
    
    /// `KR`
    case kr = "KR"
    
    /// `EN`
    case en = "EN"
    
    /// `FM`
    case fm = "FM"
    
    /// `FE`
    case fe = "FE"
    
    /// `FI`
    case fi = "FI"
    
    /// `FG`
    case fg = "FG"
    
    /// `FC`
    case fc = "FC"
    
    /// `FR`
    case fr = "FR"
    
    /// `GE`
    case ge = "GE"
    
    /// `GR`
    case gr = "GR"
    
    /// `IM`
    case im = "IM"
    
    /// `IS`
    case `is` = "IS"
    
    /// `AQ`
    case aq = "AQ"
    
    /// `LT`
    case lt = "LT"
    
    /// `LE`
    case le = "LE"
    
    /// `LC`
    case lc = "LC"
    
    /// `LI`
    case li = "LI"
    
    /// `LO`
    case lo = "LO"
    
    /// `LU`
    case lu = "LU"
    
    /// `MC`
    case mc = "MC"
    
    /// `MN`
    case mn = "MN"
    
    /// `VS`
    case vs = "VS"
    
    /// `ME`
    case me = "ME"
    
    /// `MI`
    case mi = "MI"
    
    /// `MO`
    case mo = "MO"
    
    /// `NA`
    case na = "NA"
    
    /// `NO`
    case no = "NO"
    
    /// `OG`
    case og = "OG"
    
    /// `OT`
    case ot = "OT"
    
    /// `OR`
    case or = "OR"
    
    /// `PD`
    case pd = "PD"
    
    /// `PV`
    case pv = "PV"
    
    /// `PG`
    case pg = "PG"
    
    /// `PU`
    case pu = "PU"
    
    /// `PC`
    case pc = "PC"
    
    /// `PT`
    case pt = "PT"
    
    /// `PN`
    case pn = "PN"
    
    /// `PZ`
    case pz = "PZ"
    
    /// `PO`
    case po = "PO"
    
    /// `RG`
    case rg = "RG"
    
    /// `RA`
    case ra = "RA"
    
    /// `RC`
    case rc = "RC"
    
    /// `RE`
    case re = "RE"
    
    /// `RI`
    case ri = "RI"
    
    /// `RM`
    case rm = "RM"
    
    /// `SA`
    case sa = "SA"
    
    /// `SS`
    case ss = "SS"
    
    /// `SV`
    case sv = "SV"
    
    /// `SI`
    case si = "SI"
    
    /// `SR`
    case sr = "SR"
    
    /// `SO`
    case so = "SO"
    
    /// `TA`
    case ta = "TA"
    
    /// `TE`
    case te = "TE"
    
    /// `TR`
    case tr = "TR"
    
    /// `TP`
    case tp = "TP"
    
    /// `TN`
    case tn = "TN"
    
    /// `TV`
    case tv = "TV"
    
    /// `TS`
    case ts = "TS"
    
    /// `UD`
    case ud = "UD"
    
    /// `VA`
    case va = "VA"
    
    /// `VE`
    case ve = "VE"
    
    /// `VB`
    case vb = "VB"
    
    /// `VC`
    case vc = "VC"
    
    /// `VR`
    case vr = "VR"
    
    /// `VV`
    case vv = "VV"
    
    /// `VI`
    case vi = "VI"
    
    /// `VT`
    case vt = "VT"
    
    /// `AICHI-KEN`
    case aichiKen = "AICHI-KEN"
    
    /// `AKITA-KEN`
    case akitaKen = "AKITA-KEN"
    
    /// `AOMORI-KEN`
    case aomoriKen = "AOMORI-KEN"
    
    /// `CHIBA-KEN`
    case chibaKen = "CHIBA-KEN"
    
    /// `EHIME-KEN`
    case ehimeKen = "EHIME-KEN"
    
    /// `FUKUI-KEN`
    case fukuiKen = "FUKUI-KEN"
    
    /// `FUKUOKA-KEN`
    case fukuokaKen = "FUKUOKA-KEN"
    
    /// `FUKUSHIMA-KEN`
    case fukushimaKen = "FUKUSHIMA-KEN"
    
    /// `GIFU-KEN`
    case gifuKen = "GIFU-KEN"
    
    /// `GUNMA-KEN`
    case gunmaKen = "GUNMA-KEN"
    
    /// `HIROSHIMA-KEN`
    case hiroshimaKen = "HIROSHIMA-KEN"
    
    /// `HOKKAIDO`
    case hokkaido = "HOKKAIDO"
    
    /// `HYOGO-KEN`
    case hyogoKen = "HYOGO-KEN"
    
    /// `IBARAKI-KEN`
    case ibarakiKen = "IBARAKI-KEN"
    
    /// `ISHIKAWA-KEN`
    case ishikawaKen = "ISHIKAWA-KEN"
    
    /// `IWATE-KEN`
    case iwateKen = "IWATE-KEN"
    
    /// `KAGAWA-KEN`
    case kagawaKen = "KAGAWA-KEN"
    
    /// `KAGOSHIMA-KEN`
    case kagoshimaKen = "KAGOSHIMA-KEN"
    
    /// `KANAGAWA-KEN`
    case kanagawaKen = "KANAGAWA-KEN"
    
    /// `KOCHI-KEN`
    case kochiKen = "KOCHI-KEN"
    
    /// `KUMAMOTO-KEN`
    case kumamotoKen = "KUMAMOTO-KEN"
    
    /// `KYOTO-FU`
    case kyotoFu = "KYOTO-FU"
    
    /// `MIE-KEN`
    case mieKen = "MIE-KEN"
    
    /// `MIYAGI-KEN`
    case miyagiKen = "MIYAGI-KEN"
    
    /// `MIYAZAKI-KEN`
    case miyazakiKen = "MIYAZAKI-KEN"
    
    /// `NAGANO-KEN`
    case naganoKen = "NAGANO-KEN"
    
    /// `NAGASAKI-KEN`
    case nagasakiKen = "NAGASAKI-KEN"
    
    /// `NARA-KEN`
    case naraKen = "NARA-KEN"
    
    /// `NIIGATA-KEN`
    case niigataKen = "NIIGATA-KEN"
    
    /// `OITA-KEN`
    case oitaKen = "OITA-KEN"
    
    /// `OKAYAMA-KEN`
    case okayamaKen = "OKAYAMA-KEN"
    
    /// `OKINAWA-KEN`
    case okinawaKen = "OKINAWA-KEN"
    
    /// `OSAKA-FU`
    case osakaFu = "OSAKA-FU"
    
    /// `SAGA-KEN`
    case sagaKen = "SAGA-KEN"
    
    /// `SAITAMA-KEN`
    case saitamaKen = "SAITAMA-KEN"
    
    /// `SHIGA-KEN`
    case shigaKen = "SHIGA-KEN"
    
    /// `SHIMANE-KEN`
    case shimaneKen = "SHIMANE-KEN"
    
    /// `SHIZUOKA-KEN`
    case shizuokaKen = "SHIZUOKA-KEN"
    
    /// `TOCHIGI-KEN`
    case tochigiKen = "TOCHIGI-KEN"
    
    /// `TOKUSHIMA-KEN`
    case tokushimaKen = "TOKUSHIMA-KEN"
    
    /// `TOKYO-TO`
    case tokyoTo = "TOKYO-TO"
    
    /// `TOTTORI-KEN`
    case tottoriKen = "TOTTORI-KEN"
    
    /// `TOYAMA-KEN`
    case toyamaKen = "TOYAMA-KEN"
    
    /// `WAKAYAMA-KEN`
    case wakayamaKen = "WAKAYAMA-KEN"
    
    /// `YAMAGATA-KEN`
    case yamagataKen = "YAMAGATA-KEN"
    
    /// `YAMAGUCHI-KEN`
    case yamaguchiKen = "YAMAGUCHI-KEN"
    
    /// `YAMANASHI-KEN`
    case yamanashiKen = "YAMANASHI-KEN"
    
    /// `AGS`
    case ags = "AGS"
    
    /// `BCS`
    case bcs = "BCS"
    
    /// `CAMP`
    case camp = "CAMP"
    
    /// `CHIS`
    case chis = "CHIS"
    
    /// `CHIH`
    case chih = "CHIH"
    
    /// `CDMX`
    case cdmx = "CDMX"
    
    /// `COAH`
    case coah = "COAH"
    
    /// `COL`
    case col = "COL"
    
    /// `DGO`
    case dgo = "DGO"
    
    /// `MEX`
    case mex = "MEX"
    
    /// `GTO`
    case gto = "GTO"
    
    /// `GRO`
    case gro = "GRO"
    
    /// `HGO`
    case hgo = "HGO"
    
    /// `JAL`
    case jal = "JAL"
    
    /// `MICH`
    case mich = "MICH"
    
    /// `MOR`
    case mor = "MOR"
    
    /// `NAY`
    case nay = "NAY"
    
    /// `OAX`
    case oax = "OAX"
    
    /// `PUE`
    case pue = "PUE"
    
    /// `QRO`
    case qro = "QRO"
    
    /// `Q ROO`
    case qROO = "Q ROO"
    
    /// `SLP`
    case slp = "SLP"
    
    /// `SIN`
    case sin = "SIN"
    
    /// `SON`
    case son = "SON"
    
    /// `TAB`
    case tab = "TAB"
    
    /// `TAMPS`
    case tamps = "TAMPS"
    
    /// `TLAX`
    case tlax = "TLAX"
    
    /// `VER`
    case ver = "VER"
    
    /// `YUC`
    case yuc = "YUC"
    
    /// `ZAC`
    case zac = "ZAC"
    
    /// `Amnat Charoen`
    case amnatCharoen = "Amnat Charoen"
    
    /// `Ang Thong`
    case angThong = "Ang Thong"
    
    /// `Bangkok`
    case bangkok = "Bangkok"
    
    /// `Bueng Kan`
    case buengKan = "Bueng Kan"
    
    /// `Buri Ram`
    case buriRam = "Buri Ram"
    
    /// `Chachoengsao`
    case chachoengsao = "Chachoengsao"
    
    /// `Chai Nat`
    case chaiNat = "Chai Nat"
    
    /// `Chaiyaphum`
    case chaiyaphum = "Chaiyaphum"
    
    /// `Chanthaburi`
    case chanthaburi = "Chanthaburi"
    
    /// `Chiang Mai`
    case chiangMai = "Chiang Mai"
    
    /// `Chiang Rai`
    case chiangRai = "Chiang Rai"
    
    /// `Chon Buri`
    case chonBuri = "Chon Buri"
    
    /// `Chumphon`
    case chumphon = "Chumphon"
    
    /// `Kalasin`
    case kalasin = "Kalasin"
    
    /// `Kamphaeng Phet`
    case kamphaengPhet = "Kamphaeng Phet"
    
    /// `Kanchanaburi`
    case kanchanaburi = "Kanchanaburi"
    
    /// `Khon Kaen`
    case khonKaen = "Khon Kaen"
    
    /// `Krabi`
    case krabi = "Krabi"
    
    /// `Lampang`
    case lampang = "Lampang"
    
    /// `Lamphun`
    case lamphun = "Lamphun"
    
    /// `Loei`
    case loei = "Loei"
    
    /// `Lop Buri`
    case lopBuri = "Lop Buri"
    
    /// `Mae Hong Son`
    case maeHongSon = "Mae Hong Son"
    
    /// `Maha Sarakham`
    case mahaSarakham = "Maha Sarakham"
    
    /// `Mukdahan`
    case mukdahan = "Mukdahan"
    
    /// `Nakhon Nayok`
    case nakhonNayok = "Nakhon Nayok"
    
    /// `Nakhon Pathom`
    case nakhonPathom = "Nakhon Pathom"
    
    /// `Nakhon Phanom`
    case nakhonPhanom = "Nakhon Phanom"
    
    /// `Nakhon Ratchasima`
    case nakhonRatchasima = "Nakhon Ratchasima"
    
    /// `Nakhon Sawan`
    case nakhonSawan = "Nakhon Sawan"
    
    /// `Nakhon Si Thammarat`
    case nakhonSiThammarat = "Nakhon Si Thammarat"
    
    /// `Nan`
    case nan = "Nan"
    
    /// `Narathiwat`
    case narathiwat = "Narathiwat"
    
    /// `Nong Bua Lamphu`
    case nongBuaLamphu = "Nong Bua Lamphu"
    
    /// `Nong Khai`
    case nongKhai = "Nong Khai"
    
    /// `Nonthaburi`
    case nonthaburi = "Nonthaburi"
    
    /// `Pathum Thani`
    case pathumThani = "Pathum Thani"
    
    /// `Pattani`
    case pattani = "Pattani"
    
    /// `Phang Nga`
    case phangNga = "Phang Nga"
    
    /// `Phatthalung`
    case phatthalung = "Phatthalung"
    
    /// `Phatthaya`
    case phatthaya = "Phatthaya"
    
    /// `Phayao`
    case phayao = "Phayao"
    
    /// `Phetchabun`
    case phetchabun = "Phetchabun"
    
    /// `Phetchaburi`
    case phetchaburi = "Phetchaburi"
    
    /// `Phichit`
    case phichit = "Phichit"
    
    /// `Phitsanulok`
    case phitsanulok = "Phitsanulok"
    
    /// `Phra Nakhon Si Ayutthaya`
    case phraNakhonSiAyutthaya = "Phra Nakhon Si Ayutthaya"
    
    /// `Phrae`
    case phrae = "Phrae"
    
    /// `Phuket`
    case phuket = "Phuket"
    
    /// `Prachin Buri`
    case prachinBuri = "Prachin Buri"
    
    /// `Prachuap Khiri Khan`
    case prachuapKhiriKhan = "Prachuap Khiri Khan"
    
    /// `Ranong`
    case ranong = "Ranong"
    
    /// `Ratchaburi`
    case ratchaburi = "Ratchaburi"
    
    /// `Rayong`
    case rayong = "Rayong"
    
    /// `Roi Et`
    case roiEt = "Roi Et"
    
    /// `Sa Kaeo`
    case saKaeo = "Sa Kaeo"
    
    /// `Sakon Nakhon`
    case sakonNakhon = "Sakon Nakhon"
    
    /// `Samut Prakan`
    case samutPrakan = "Samut Prakan"
    
    /// `Samut Sakhon`
    case samutSakhon = "Samut Sakhon"
    
    /// `Samut Songkhram`
    case samutSongkhram = "Samut Songkhram"
    
    /// `Saraburi`
    case saraburi = "Saraburi"
    
    /// `Satun`
    case satun = "Satun"
    
    /// `Si Sa Ket`
    case siSaKet = "Si Sa Ket"
    
    /// `Sing Buri`
    case singBuri = "Sing Buri"
    
    /// `Songkhla`
    case songkhla = "Songkhla"
    
    /// `Sukhothai`
    case sukhothai = "Sukhothai"
    
    /// `Suphan Buri`
    case suphanBuri = "Suphan Buri"
    
    /// `Surat Thani`
    case suratThani = "Surat Thani"
    
    /// `Surin`
    case surin = "Surin"
    
    /// `Tak`
    case tak = "Tak"
    
    /// `Trang`
    case trang = "Trang"
    
    /// `Trat`
    case trat = "Trat"
    
    /// `Ubon Ratchathani`
    case ubonRatchathani = "Ubon Ratchathani"
    
    /// `Udon Thani`
    case udonThani = "Udon Thani"
    
    /// `Uthai Thani`
    case uthaiThani = "Uthai Thani"
    
    /// `Uttaradit`
    case uttaradit = "Uttaradit"
    
    /// `Yala`
    case yala = "Yala"
    
    /// `Yasothon`
    case yasothon = "Yasothon"
    
    /// `AK`
    case ak = "AK"
    
    /// `AZ`
    case az = "AZ"
    
    /// `DE`
    case de = "DE"
    
    /// `DC`
    case dc = "DC"
    
    /// `FL`
    case fl = "FL"
    
    /// `GA`
    case ga = "GA"
    
    /// `HI`
    case hi = "HI"
    
    /// `IL`
    case il = "IL"
    
    /// `IN`
    case `in` = "IN"
    
    /// `IA`
    case ia = "IA"
    
    /// `KS`
    case ks = "KS"
    
    /// `KY`
    case ky = "KY"
    
    /// `LA`
    case la = "LA"
    
    /// `MD`
    case md = "MD"
    
    /// `NE`
    case ne = "NE"
    
    /// `NV`
    case nv = "NV"
    
    /// `NH`
    case nh = "NH"
    
    /// `NJ`
    case nj = "NJ"
    
    /// `NM`
    case nm = "NM"
    
    /// `NY`
    case ny = "NY"
    
    /// `NC`
    case nc = "NC"
    
    /// `ND`
    case nd = "ND"
    
    /// `OH`
    case oh = "OH"
    
    /// `OK`
    case ok = "OK"
    
    /// `SD`
    case sd = "SD"
    
    /// `TX`
    case tx = "TX"
    
    /// `UT`
    case ut = "UT"
    
    /// `WA`
    case wa = "WA"
    
    /// `WV`
    case wv = "WV"
    
    /// `WI`
    case wi = "WI"
    
    /// `WY`
    case wy = "WY"
    
    /// `AA`
    case aa = "AA"
    
    /// `AE`
    case ae = "AE"
    
    /// `AS`
    case `as` = "AS"
    
    /// `GU`
    case gu = "GU"
    
    /// `MH`
    case mh = "MH"
    
    /// `MP`
    case mp = "MP"
    
    /// `PW`
    case pw = "PW"
}
