import Vapor

public struct Currency: Content, Equatable {
    public let code: String
    public let number: Int
    public let e: Int?
    public let name: String
    
    init(code: String, number: Int, e: Int?, name: String) {
        self.code = code
        self.number = number
        self.e = e
        self.name = name
    }
    
    init?(code: String) {
        guard let currency = Currency.allKeyedCases[code.lowercased()] else {
            return nil
        }
        self = currency
    }
    
    public static let aed = Currency(code: "AED", number: 784, e: 2, name: "United Arab Emirates dirham")
    public static let afn = Currency(code: "AFN", number: 971, e: 2, name: "Afghan afghani")
    public static let all = Currency(code: "ALL", number: 8, e: 2, name: "Albanian lek")
    public static let amd = Currency(code: "AMD", number: 51, e: 2, name: "Armenian dram")
    public static let ang = Currency(code: "ANG", number: 532, e: 2, name: "Netherlands Antillean guilder")
    public static let aoa = Currency(code: "AOA", number: 973, e: 2, name: "Angolan kwanza")
    public static let ars = Currency(code: "ARS", number: 32, e: 2, name: "Argentine peso")
    public static let aud = Currency(code: "AUD", number: 36, e: 2, name: "Australian dollar")
    public static let awg = Currency(code: "AWG", number: 533, e: 2, name: "Aruban florin")
    public static let azn = Currency(code: "AZN", number: 944, e: 2, name: "Azerbaijani manat")
    public static let bam = Currency(code: "BAM", number: 977, e: 2, name: "Bosnia and Herzegovina convertible mark")
    public static let bbd = Currency(code: "BBD", number: 52, e: 2, name: "Barbados dollar")
    public static let bdt = Currency(code: "BDT", number: 50, e: 2, name: "Bangladeshi taka")
    public static let bgn = Currency(code: "BGN", number: 975, e: 2, name: "Bulgarian lev")
    public static let bhd = Currency(code: "BHD", number: 48, e: 3, name: "Bahraini dinar")
    public static let bif = Currency(code: "BIF", number: 108, e: 0, name: "Burundian franc")
    public static let bmd = Currency(code: "BMD", number: 60, e: 2, name: "Bermudian dollar")
    public static let bnd = Currency(code: "BND", number: 96, e: 2, name: "Brunei dollar")
    public static let bob = Currency(code: "BOB", number: 68, e: 2, name: "Boliviano")
    public static let bov = Currency(code: "BOV", number: 984, e: 2, name: "Bolivian Mvdol (funds code)")
    public static let brl = Currency(code: "BRL", number: 986, e: 2, name: "Brazilian real")
    public static let bsd = Currency(code: "BSD", number: 44, e: 2, name: "Bahamian dollar")
    public static let btn = Currency(code: "BTN", number: 64, e: 2, name: "Bhutanese ngultrum")
    public static let bwp = Currency(code: "BWP", number: 72, e: 2, name: "Botswana pula")
    public static let byn = Currency(code: "BYN", number: 933, e: 2, name: "Belarusian ruble")
    public static let bzd = Currency(code: "BZD", number: 84, e: 2, name: "Belize dollar")
    public static let cad = Currency(code: "CAD", number: 124, e: 2, name: "Canadian dollar")
    public static let cdf = Currency(code: "CDF", number: 976, e: 2, name: "Congolese franc")
    public static let che = Currency(code: "CHE", number: 947, e: 2, name: "WIR Euro (complementary currency)")
    public static let chf = Currency(code: "CHF", number: 756, e: 2, name: "Swiss franc")
    public static let chw = Currency(code: "CHW", number: 948, e: 2, name: "WIR Franc (complementary currency)")
    public static let clf = Currency(code: "CLF", number: 990, e: 4, name: "Unidad de Fomento (funds code)")
    public static let clp = Currency(code: "CLP", number: 152, e: 0, name: "Chilean peso")
    public static let cny = Currency(code: "CNY", number: 156, e: 2, name: "Renminbi (Chinese) yuan")
    public static let cop = Currency(code: "COP", number: 170, e: 2, name: "Colombian peso")
    public static let cou = Currency(code: "COU", number: 970, e: 2, name: "Unidad de Valor Real (UVR) (funds code)")
    public static let crc = Currency(code: "CRC", number: 188, e: 2, name: "Costa Rican colon")
    public static let cuc = Currency(code: "CUC", number: 931, e: 2, name: "Cuban convertible peso")
    public static let cup = Currency(code: "CUP", number: 192, e: 2, name: "Cuban peso")
    public static let cve = Currency(code: "CVE", number: 132, e: 0, name: "Cape Verde escudo")
    public static let czk = Currency(code: "CZK", number: 203, e: 2, name: "Czech koruna")
    public static let djf = Currency(code: "DJF", number: 262, e: 0, name: "Djiboutian franc")
    public static let dkk = Currency(code: "DKK", number: 208, e: 2, name: "Danish krone")
    public static let dop = Currency(code: "DOP", number: 214, e: 2, name: "Dominican peso")
    public static let dzd = Currency(code: "DZD", number: 12, e: 2, name: "Algerian dinar")
    public static let egp = Currency(code: "EGP", number: 818, e: 2, name: "Egyptian pound")
    public static let ern = Currency(code: "ERN", number: 232, e: 2, name: "Eritrean nakfa")
    public static let etb = Currency(code: "ETB", number: 230, e: 2, name: "Ethiopian birr")
    public static let eur = Currency(code: "EUR", number: 978, e: 2, name: "Euro")
    public static let fjd = Currency(code: "FJD", number: 242, e: 2, name: "Fiji dollar")
    public static let fkp = Currency(code: "FKP", number: 238, e: 2, name: "Falkland Islands pound")
    public static let gbp = Currency(code: "GBP", number: 826, e: 2, name: "Pound sterling")
    public static let gel = Currency(code: "GEL", number: 981, e: 2, name: "Georgian lari")
    public static let ghs = Currency(code: "GHS", number: 936, e: 2, name: "Ghanaian cedi")
    public static let gip = Currency(code: "GIP", number: 292, e: 2, name: "Gibraltar pound")
    public static let gmd = Currency(code: "GMD", number: 270, e: 2, name: "Gambian dalasi")
    public static let gnf = Currency(code: "GNF", number: 324, e: 0, name: "Guinean franc")
    public static let gtq = Currency(code: "GTQ", number: 320, e: 2, name: "Guatemalan quetzal")
    public static let gyd = Currency(code: "GYD", number: 328, e: 2, name: "Guyanese dollar")
    public static let hkd = Currency(code: "HKD", number: 344, e: 2, name: "Hong Kong dollar")
    public static let hnl = Currency(code: "HNL", number: 340, e: 2, name: "Honduran lempira")
    public static let hrk = Currency(code: "HRK", number: 191, e: 2, name: "Croatian kuna")
    public static let htg = Currency(code: "HTG", number: 332, e: 2, name: "Haitian gourde")
    public static let huf = Currency(code: "HUF", number: 348, e: 2, name: "Hungarian forint")
    public static let idr = Currency(code: "IDR", number: 360, e: 2, name: "Indonesian rupiah")
    public static let ils = Currency(code: "ILS", number: 376, e: 2, name: "Israeli new shekel")
    public static let inr = Currency(code: "INR", number: 356, e: 2, name: "Indian rupee")
    public static let iqd = Currency(code: "IQD", number: 368, e: 3, name: "Iraqi dinar")
    public static let irr = Currency(code: "IRR", number: 364, e: 2, name: "Iranian rial")
    public static let isk = Currency(code: "ISK", number: 352, e: 0, name: "Icelandic króna")
    public static let jmd = Currency(code: "JMD", number: 388, e: 2, name: "Jamaican dollar")
    public static let jod = Currency(code: "JOD", number: 400, e: 3, name: "Jordanian dinar")
    public static let jpy = Currency(code: "JPY", number: 392, e: 0, name: "Japanese yen")
    public static let kes = Currency(code: "KES", number: 404, e: 2, name: "Kenyan shilling")
    public static let kgs = Currency(code: "KGS", number: 417, e: 2, name: "Kyrgyzstani som")
    public static let khr = Currency(code: "KHR", number: 116, e: 2, name: "Cambodian riel")
    public static let kmf = Currency(code: "KMF", number: 174, e: 0, name: "Comoro franc")
    public static let kpw = Currency(code: "KPW", number: 408, e: 2, name: "North Korean won")
    public static let krw = Currency(code: "KRW", number: 410, e: 0, name: "South Korean won")
    public static let kwd = Currency(code: "KWD", number: 414, e: 3, name: "Kuwaiti dinar")
    public static let kyd = Currency(code: "KYD", number: 136, e: 2, name: "Cayman Islands dollar")
    public static let kzt = Currency(code: "KZT", number: 398, e: 2, name: "Kazakhstani tenge")
    public static let lak = Currency(code: "LAK", number: 418, e: 2, name: "Lao kip")
    public static let lbp = Currency(code: "LBP", number: 422, e: 2, name: "Lebanese pound")
    public static let lkr = Currency(code: "LKR", number: 144, e: 2, name: "Sri Lankan rupee")
    public static let lrd = Currency(code: "LRD", number: 430, e: 2, name: "Liberian dollar")
    public static let lsl = Currency(code: "LSL", number: 426, e: 2, name: "Lesotho loti")
    public static let lyd = Currency(code: "LYD", number: 434, e: 3, name: "Libyan dinar")
    public static let mad = Currency(code: "MAD", number: 504, e: 2, name: "Moroccan dirham")
    public static let mdl = Currency(code: "MDL", number: 498, e: 2, name: "Moldovan leu")
    public static let mga = Currency(code: "MGA", number: 969, e: 1, name: "Malagasy ariary")
    public static let mkd = Currency(code: "MKD", number: 807, e: 2, name: "Macedonian denar")
    public static let mmk = Currency(code: "MMK", number: 104, e: 2, name: "Myanmar kyat")
    public static let mnt = Currency(code: "MNT", number: 496, e: 2, name: "Mongolian tögrög")
    public static let mop = Currency(code: "MOP", number: 446, e: 2, name: "Macanese pataca")
    public static let mru = Currency(code: "MRU", number: 929, e: 1, name: "Mauritanian ouguiya")
    public static let mur = Currency(code: "MUR", number: 480, e: 2, name: "Mauritian rupee")
    public static let mvr = Currency(code: "MVR", number: 462, e: 2, name: "Maldivian rufiyaa")
    public static let mwk = Currency(code: "MWK", number: 454, e: 2, name: "Malawian kwacha")
    public static let mxn = Currency(code: "MXN", number: 484, e: 2, name: "Mexican peso")
    public static let mxv = Currency(code: "MXV", number: 979, e: 2, name: "Mexican Unidad de Inversion (UDI) (funds code)")
    public static let myr = Currency(code: "MYR", number: 458, e: 2, name: "Malaysian ringgit")
    public static let mzn = Currency(code: "MZN", number: 943, e: 2, name: "Mozambican metical")
    public static let nad = Currency(code: "NAD", number: 516, e: 2, name: "Namibian dollar")
    public static let ngn = Currency(code: "NGN", number: 566, e: 2, name: "Nigerian naira")
    public static let nio = Currency(code: "NIO", number: 558, e: 2, name: "Nicaraguan córdoba")
    public static let nok = Currency(code: "NOK", number: 578, e: 2, name: "Norwegian krone")
    public static let npr = Currency(code: "NPR", number: 524, e: 2, name: "Nepalese rupee")
    public static let nzd = Currency(code: "NZD", number: 554, e: 2, name: "New Zealand dollar")
    public static let omr = Currency(code: "OMR", number: 512, e: 3, name: "Omani rial")
    public static let pab = Currency(code: "PAB", number: 590, e: 2, name: "Panamanian balboa")
    public static let pen = Currency(code: "PEN", number: 604, e: 2, name: "Peruvian sol")
    public static let pgk = Currency(code: "PGK", number: 598, e: 2, name: "Papua New Guinean kina")
    public static let php = Currency(code: "PHP", number: 608, e: 2, name: "Philippine piso")
    public static let pkr = Currency(code: "PKR", number: 586, e: 2, name: "Pakistani rupee")
    public static let pln = Currency(code: "PLN", number: 985, e: 2, name: "Polish złoty")
    public static let pyg = Currency(code: "PYG", number: 600, e: 0, name: "Paraguayan guaraní")
    public static let qar = Currency(code: "QAR", number: 634, e: 2, name: "Qatari riyal")
    public static let ron = Currency(code: "RON", number: 946, e: 2, name: "Romanian leu")
    public static let rsd = Currency(code: "RSD", number: 941, e: 2, name: "Serbian dinar")
    public static let rub = Currency(code: "RUB", number: 643, e: 2, name: "Russian ruble")
    public static let rwf = Currency(code: "RWF", number: 646, e: 0, name: "Rwandan franc")
    public static let sar = Currency(code: "SAR", number: 682, e: 2, name: "Saudi riyal")
    public static let sbd = Currency(code: "SBD", number: 90, e: 2, name: "Solomon Islands dollar")
    public static let scr = Currency(code: "SCR", number: 690, e: 2, name: "Seychelles rupee")
    public static let sdg = Currency(code: "SDG", number: 938, e: 2, name: "Sudanese pound")
    public static let sek = Currency(code: "SEK", number: 752, e: 2, name: "Swedish krona/kronor")
    public static let sgd = Currency(code: "SGD", number: 702, e: 2, name: "Singapore dollar")
    public static let shp = Currency(code: "SHP", number: 654, e: 2, name: "Saint Helena pound")
    public static let sll = Currency(code: "SLL", number: 694, e: 2, name: "Sierra Leonean leone")
    public static let sos = Currency(code: "SOS", number: 706, e: 2, name: "Somali shilling")
    public static let srd = Currency(code: "SRD", number: 968, e: 2, name: "Surinamese dollar")
    public static let ssp = Currency(code: "SSP", number: 728, e: 2, name: "South Sudanese pound")
    public static let stn = Currency(code: "STN", number: 930, e: 2, name: "São Tomé and Príncipe dobra")
    public static let svc = Currency(code: "SVC", number: 222, e: 2, name: "Salvadoran colón")
    public static let syp = Currency(code: "SYP", number: 760, e: 2, name: "Syrian pound")
    public static let szl = Currency(code: "SZL", number: 748, e: 2, name: "Swazi lilangeni")
    public static let thb = Currency(code: "THB", number: 764, e: 2, name: "Thai baht")
    public static let tjs = Currency(code: "TJS", number: 972, e: 2, name: "Tajikistani somoni")
    public static let tmt = Currency(code: "TMT", number: 934, e: 2, name: "Turkmenistan manat")
    public static let tnd = Currency(code: "TND", number: 788, e: 3, name: "Tunisian dinar")
    public static let top = Currency(code: "TOP", number: 776, e: 2, name: "Tongan paʻanga")
    public static let `try` = Currency(code: "TRY", number: 949, e: 2, name: "Turkish lira")
    public static let ttd = Currency(code: "TTD", number: 780, e: 2, name: "Trinidad and Tobago dollar")
    public static let twd = Currency(code: "TWD", number: 901, e: 2, name: "New Taiwan dollar")
    public static let tzs = Currency(code: "TZS", number: 834, e: 2, name: "Tanzanian shilling")
    public static let uah = Currency(code: "UAH", number: 980, e: 2, name: "Ukrainian hryvnia")
    public static let ugx = Currency(code: "UGX", number: 800, e: 0, name: "Ugandan shilling")
    public static let usd = Currency(code: "USD", number: 840, e: 2, name: "United States dollar")
    public static let usn = Currency(code: "USN", number: 997, e: 2, name: "United States dollar (next day) (funds code)")
    public static let uyi = Currency(code: "UYI", number: 940, e: 0, name: "Uruguay Peso en Unidades Indexadas (URUIURUI) (funds code)")
    public static let uyu = Currency(code: "UYU", number: 858, e: 2, name: "Uruguayan peso")
    public static let uzs = Currency(code: "UZS", number: 860, e: 2, name: "Uzbekistan som")
    public static let vef = Currency(code: "VEF", number: 937, e: 2, name: "Venezuelan bolívar")
    public static let vnd = Currency(code: "VND", number: 704, e: 0, name: "Vietnamese đồng")
    public static let vuv = Currency(code: "VUV", number: 548, e: 0, name: "Vanuatu vatu")
    public static let wst = Currency(code: "WST", number: 882, e: 2, name: "Samoan tala")
    public static let xaf = Currency(code: "XAF", number: 950, e: 0, name: "CFA franc BEAC")
    public static let xag = Currency(code: "XAG", number: 961, e: nil, name: "Silver (one troy ounce)")
    public static let xau = Currency(code: "XAU", number: 959, e: nil, name: "Gold (one troy ounce)")
    public static let xba = Currency(code: "XBA", number: 955, e: nil, name: "European Composite Unit (EURCO) (bond market unit)")
    public static let xbb = Currency(code: "XBB", number: 956, e: nil, name: "European Monetary Unit (E.M.U.-6) (bond market unit)")
    public static let xbc = Currency(code: "XBC", number: 957, e: nil, name: "European Unit of Account 9 (E.U.A.-9) (bond market unit)")
    public static let xbd = Currency(code: "XBD", number: 958, e: nil, name: "European Unit of Account 17 (E.U.A.-17) (bond market unit)")
    public static let xcd = Currency(code: "XCD", number: 951, e: 2, name: "East Caribbean dollar")
    public static let xdr = Currency(code: "XDR", number: 960, e: nil, name: "Special drawing rights")
    public static let xof = Currency(code: "XOF", number: 952, e: 0, name: "CFA franc BCEAO")
    public static let xpd = Currency(code: "XPD", number: 964, e: nil, name: "Palladium (one troy ounce)")
    public static let xpf = Currency(code: "XPF", number: 953, e: 0, name: "CFP franc (franc Pacifique)")
    public static let xpt = Currency(code: "XPT", number: 962, e: nil, name: "Platinum (one troy ounce)")
    public static let xsu = Currency(code: "XSU", number: 994, e: nil, name: "SUCRE")
    public static let xts = Currency(code: "XTS", number: 963, e: nil, name: "Code reserved for testing purposes")
    public static let xua = Currency(code: "XUA", number: 965, e: nil, name: "ADB Unit of Account")
    public static let xxx = Currency(code: "XXX", number: 999, e: nil, name: "No currency")
    public static let yer = Currency(code: "YER", number: 886, e: 2, name: "Yemeni rial")
    public static let zar = Currency(code: "ZAR", number: 710, e: 2, name: "South African rand")
    public static let zmw = Currency(code: "ZMW", number: 967, e: 2, name: "Zambian kwacha")
    public static let zwl = Currency(code: "ZWL", number: 932, e: 2, name: "Zimbabwean dollar A/10")
    
    public static let allKeyedCases: [String: Currency] = [
        "aed": aed, "afn": afn, "all": all, "amd": amd, "ang": ang, "aoa": aoa, "ars": ars, "aud": aud, "awg": awg, "azn": azn,
        "bam": bam, "bbd": bbd, "bdt": bdt, "bgn": bgn, "bhd": bhd, "bif": bif, "bmd": bmd, "bnd": bnd, "bob": bob, "bov": bov,
        "brl": brl, "bsd": bsd, "btn": btn, "bwp": bwp, "byn": byn, "bzd": bzd, "cad": cad, "cdf": cdf, "che": che, "chf": chf,
        "chw": chw, "clf": clf, "clp": clp, "cny": cny, "cop": cop, "cou": cou, "crc": crc, "cuc": cuc, "cup": cup, "cve": cve,
        "czk": czk, "djf": djf, "dkk": dkk, "dop": dop, "dzd": dzd, "egp": egp, "ern": ern, "etb": etb, "eur": eur, "fjd": fjd,
        "fkp": fkp, "gbp": gbp, "gel": gel, "ghs": ghs, "gip": gip, "gmd": gmd, "gnf": gnf, "gtq": gtq, "gyd": gyd, "hkd": hkd,
        "hnl": hnl, "hrk": hrk, "htg": htg, "huf": huf, "idr": idr, "ils": ils, "inr": inr, "iqd": iqd, "irr": irr, "isk": isk,
        "jmd": jmd, "jod": jod, "jpy": jpy, "kes": kes, "kgs": kgs, "khr": khr, "kmf": kmf, "kpw": kpw, "krw": krw, "kwd": kwd,
        "kyd": kyd, "kzt": kzt, "lak": lak, "lbp": lbp, "lkr": lkr, "lrd": lrd, "lsl": lsl, "lyd": lyd, "mad": mad, "mdl": mdl,
        "mga": mga, "mkd": mkd, "mmk": mmk, "mnt": mnt, "mop": mop, "mru": mru, "mur": mur, "mvr": mvr, "mwk": mwk, "mxn": mxn,
        "mxv": mxv, "myr": myr, "mzn": mzn, "nad": nad, "ngn": ngn, "nio": nio, "nok": nok, "npr": npr, "nzd": nzd, "omr": omr,
        "pab": pab, "pen": pen, "pgk": pgk, "php": php, "pkr": pkr, "pln": pln, "pyg": pyg, "qar": qar, "ron": ron, "rsd": rsd,
        "rub": rub, "rwf": rwf, "sar": sar, "sbd": sbd, "scr": scr, "sdg": sdg, "sek": sek, "sgd": sgd, "shp": shp, "sll": sll,
        "sos": sos, "srd": srd, "ssp": ssp, "stn": stn, "svc": svc, "syp": syp, "szl": szl, "thb": thb, "tjs": tjs, "tmt": tmt,
        "tnd": tnd, "top": top, "try": `try`, "ttd": ttd, "twd": twd, "tzs": tzs, "uah": uah, "ugx": ugx, "usd": usd, "usn": usn,
        "uyi": uyi, "uyu": uyu, "uzs": uzs, "vef": vef, "vnd": vnd, "vuv": vuv, "wst": wst, "xaf": xaf, "xag": xag, "xau": xau,
        "xba": xba, "xbb": xbb, "xbc": xbc, "xbd": xbd, "xcd": xcd, "xdr": xdr, "xof": xof, "xpd": xpd, "xpf": xpf, "xpt": xpt,
        "xsu": xsu, "xts": xts, "xua": xua, "xxx": xxx, "yer": yer, "zar": zar, "zmw": zmw, "zwl": zwl,
    ]
}

extension Currency: CaseIterable {
    public static var allCases: [Currency]  {
        return Array(self.allKeyedCases.values)
    }
}
