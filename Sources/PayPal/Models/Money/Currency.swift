import Vapor

/// A monetary currency for a geographical loaction, such as United States Dollar and Euro.
public struct Currency: Content, Equatable {
    
    // MARK: - Model Structure
    
    /// The 3 character code that represents the currency, i.e. `USD`, `EUR`, `XXX`.
    public let code: String
    
    /// The 3 digit numaric code for the currency. For example, `USD` has `840`.
    ///
    /// - note: If a code is less than 3 digits, it is the same as having 0s appended
    ///   to it beginning, making 8 into 008.
    public let number: Int
    
    /// The currency's ['exponent'](https://en.wikipedia.org/wiki/ISO_4217#Treatment_of_minor_currency_units_(the_%22exponent%22)).
    /// This is the rough expression of the relationship between the major and minor units of the currency.
    public let e: Int?
    
    /// The full name of the currency, i.e. 'United states dollar', 'Egyptian pound'.
    public let name: String
    
    init(code: String, number: Int, e: Int?, name: String) {
        self.code = code
        self.number = number
        self.e = e
        self.name = name
    }
    
    /// Gets a known currency based on its code:
    ///
    ///     Currency(code: "USD") // Optional(Currency(code: "USD", number: 840, e: 2, name: "United States dollar"))
    ///
    /// This initializer is case-insensative.
    ///
    /// - Parameter code: The 3 character code of the currency to get.
    public init?(code: String) {
        guard let currency = Currency.allKeyedCases[code.lowercased()] else {
            return nil
        }
        self = currency
    }
    
    
    // MARK: - Coding
    
    /// Creates a new Currency instance based on the decoder's contents.
    ///
    /// If a keyed container can be created from the decoder, the currency will be created
    /// with data from the `code`, `number`, `e`, and `name` keys; otherwise, a single value
    /// container will be created from the decoder and get an existing currency with the
    /// decoded string as its code.
    public init(from decoder: Decoder)throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            self.code = try container.decode(String.self, forKey: .code)
            self.number = try container.decode(Int.self, forKey: .number)
            self.e = try container.decodeIfPresent(Int.self, forKey: .e)
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            let container = try decoder.singleValueContainer()
            let code = try container.decode(String.self)
            if let currency = Currency(code: code) {
                self = currency
            } else {
                throw Abort(.badRequest, reason: "Unknown currency code \(code), please supply a 'name', 'number', and 'e' value to create the currency")
            }
        }
        
    }
    
    /// Encodes the instance's code to the encoders single value container.
    public func encode(to encoder: Encoder)throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.code)
    }
    
    /// Converts a decimal number to a string with the expected number of decimal places.
    ///
    ///     let decimal = Decimal(string: "85.80")! // 85.8
    ///     Currency.usd.string(for: decimal) // "85.80"
    ///
    /// - Parameter decimal: The decimal to convert to a string
    ///
    /// - Returns: The string representation of the decimal.
    func string(for decimal: Decimal) -> String {
        var rounded = decimal
        
        if let exponent = self.e {
            var value = decimal
            NSDecimalRound(&rounded, &value, exponent, .bankers)
        } else {
            return rounded.description
        }
        
        if -rounded.exponent != self.e {
            var string = rounded.description
            let oCount: Int
            
            if let i = string.firstIndex(of: ".") {
                oCount = string[string.index(after: i)...].count
            } else {
                oCount = self.e ?? 0
                string.append(".")
            }
            
            string.append(String(repeating: "0", count: oCount))
            return string
        } else {
            return rounded.description
        }
    }
    
    
    // MARK: - Known Currencies
    
    /// A `Currency` instance for the United Arab Emirates dirham.
    public static let aed = Currency(code: "AED", number: 784, e: 2, name: "United Arab Emirates dirham")
    
    /// A `Currency` instance for the Afghan afghani.
    public static let afn = Currency(code: "AFN", number: 971, e: 2, name: "Afghan afghani")
    
    /// A `Currency` instance for the Albanian lek.
    public static let all = Currency(code: "ALL", number: 008, e: 2, name: "Albanian lek")
    
    /// A `Currency` instance for the Armenian dram.
    public static let amd = Currency(code: "AMD", number: 051, e: 2, name: "Armenian dram")
    
    /// A `Currency` instance for the Netherlands Antillean guilder.
    public static let ang = Currency(code: "ANG", number: 532, e: 2, name: "Netherlands Antillean guilder")
    
    /// A `Currency` instance for the Angolan kwanza.
    public static let aoa = Currency(code: "AOA", number: 973, e: 2, name: "Angolan kwanza")
    
    /// A `Currency` instance for the Argentine peso.
    public static let ars = Currency(code: "ARS", number: 032, e: 2, name: "Argentine peso")
    
    /// A `Currency` instance for the Australian dollar.
    public static let aud = Currency(code: "AUD", number: 036, e: 2, name: "Australian dollar")
    
    /// A `Currency` instance for the Aruban florin.
    public static let awg = Currency(code: "AWG", number: 533, e: 2, name: "Aruban florin")
    
    /// A `Currency` instance for the Azerbaijani manat.
    public static let azn = Currency(code: "AZN", number: 944, e: 2, name: "Azerbaijani manat")
    
    /// A `Currency` instance for the Bosnia and Herzegovina convertible mark.
    public static let bam = Currency(code: "BAM", number: 977, e: 2, name: "Bosnia and Herzegovina convertible mark")
    
    /// A `Currency` instance for the Barbados dollar.
    public static let bbd = Currency(code: "BBD", number: 052, e: 2, name: "Barbados dollar")
    
    /// A `Currency` instance for the Bangladeshi taka.
    public static let bdt = Currency(code: "BDT", number: 050, e: 2, name: "Bangladeshi taka")
    
    /// A `Currency` instance for the Bulgarian lev.
    public static let bgn = Currency(code: "BGN", number: 975, e: 2, name: "Bulgarian lev")
    
    /// A `Currency` instance for the Bahraini dinar.
    public static let bhd = Currency(code: "BHD", number: 048, e: 3, name: "Bahraini dinar")
    
    /// A `Currency` instance for the Burundian franc.
    public static let bif = Currency(code: "BIF", number: 108, e: 0, name: "Burundian franc")
    
    /// A `Currency` instance for the Bermudian dollar.
    public static let bmd = Currency(code: "BMD", number: 060, e: 2, name: "Bermudian dollar")
    
    /// A `Currency` instance for the Brunei dollar.
    public static let bnd = Currency(code: "BND", number: 096, e: 2, name: "Brunei dollar")
    
    /// A `Currency` instance for the Boliviano.
    public static let bob = Currency(code: "BOB", number: 068, e: 2, name: "Boliviano")
    
    /// A `Currency` instance for the Bolivian Mvdol (funds code).
    public static let bov = Currency(code: "BOV", number: 984, e: 2, name: "Bolivian Mvdol (funds code)")
    
    /// A `Currency` instance for the Brazilian real.
    public static let brl = Currency(code: "BRL", number: 986, e: 2, name: "Brazilian real")
    
    /// A `Currency` instance for the Bahamian dollar.
    public static let bsd = Currency(code: "BSD", number: 044, e: 2, name: "Bahamian dollar")
    
    /// A `Currency` instance for the Bhutanese ngultrum.
    public static let btn = Currency(code: "BTN", number: 064, e: 2, name: "Bhutanese ngultrum")
    
    /// A `Currency` instance for the Botswana pula.
    public static let bwp = Currency(code: "BWP", number: 072, e: 2, name: "Botswana pula")
    
    /// A `Currency` instance for the Belarusian ruble.
    public static let byn = Currency(code: "BYN", number: 933, e: 2, name: "Belarusian ruble")
    
    /// A `Currency` instance for the Belize dollar.
    public static let bzd = Currency(code: "BZD", number: 084, e: 2, name: "Belize dollar")
    
    /// A `Currency` instance for the Canadian dollar.
    public static let cad = Currency(code: "CAD", number: 124, e: 2, name: "Canadian dollar")
    
    /// A `Currency` instance for the Congolese franc.
    public static let cdf = Currency(code: "CDF", number: 976, e: 2, name: "Congolese franc")
    
    /// A `Currency` instance for the WIR Euro (complementary currency).
    public static let che = Currency(code: "CHE", number: 947, e: 2, name: "WIR Euro (complementary currency)")
    
    /// A `Currency` instance for the Swiss franc.
    public static let chf = Currency(code: "CHF", number: 756, e: 2, name: "Swiss franc")
    
    /// A `Currency` instance for the WIR Franc (complementary currency).
    public static let chw = Currency(code: "CHW", number: 948, e: 2, name: "WIR Franc (complementary currency)")
    
    /// A `Currency` instance for the Unidad de Fomento (funds code).
    public static let clf = Currency(code: "CLF", number: 990, e: 4, name: "Unidad de Fomento (funds code)")
    
    /// A `Currency` instance for the Chilean peso.
    public static let clp = Currency(code: "CLP", number: 152, e: 0, name: "Chilean peso")
    
    /// A `Currency` instance for the Renminbi (Chinese) yuan.
    public static let cny = Currency(code: "CNY", number: 156, e: 2, name: "Renminbi (Chinese) yuan")
    
    /// A `Currency` instance for the Colombian peso.
    public static let cop = Currency(code: "COP", number: 170, e: 2, name: "Colombian peso")
    
    /// A `Currency` instance for the Unidad de Valor Real (UVR) (funds code).
    public static let cou = Currency(code: "COU", number: 970, e: 2, name: "Unidad de Valor Real (UVR) (funds code)")
    
    /// A `Currency` instance for the Costa Rican colon.
    public static let crc = Currency(code: "CRC", number: 188, e: 2, name: "Costa Rican colon")
    
    /// A `Currency` instance for the Cuban convertible peso.
    public static let cuc = Currency(code: "CUC", number: 931, e: 2, name: "Cuban convertible peso")
    
    /// A `Currency` instance for the Cuban peso.
    public static let cup = Currency(code: "CUP", number: 192, e: 2, name: "Cuban peso")
    
    /// A `Currency` instance for the Cape Verde escudo.
    public static let cve = Currency(code: "CVE", number: 132, e: 0, name: "Cape Verde escudo")
    
    /// A `Currency` instance for the Czech koruna.
    public static let czk = Currency(code: "CZK", number: 203, e: 2, name: "Czech koruna")
    
    /// A `Currency` instance for the Djiboutian franc.
    public static let djf = Currency(code: "DJF", number: 262, e: 0, name: "Djiboutian franc")
    
    /// A `Currency` instance for the Danish krone.
    public static let dkk = Currency(code: "DKK", number: 208, e: 2, name: "Danish krone")
    
    /// A `Currency` instance for the Dominican peso.
    public static let dop = Currency(code: "DOP", number: 214, e: 2, name: "Dominican peso")
    
    /// A `Currency` instance for the Algerian dinar.
    public static let dzd = Currency(code: "DZD", number: 012, e: 2, name: "Algerian dinar")
    
    /// A `Currency` instance for the Egyptian pound.
    public static let egp = Currency(code: "EGP", number: 818, e: 2, name: "Egyptian pound")
    
    /// A `Currency` instance for the Eritrean nakfa.
    public static let ern = Currency(code: "ERN", number: 232, e: 2, name: "Eritrean nakfa")
    
    /// A `Currency` instance for the Ethiopian birr.
    public static let etb = Currency(code: "ETB", number: 230, e: 2, name: "Ethiopian birr")
    
    /// A `Currency` instance for the Euro.
    public static let eur = Currency(code: "EUR", number: 978, e: 2, name: "Euro")
    
    /// A `Currency` instance for the Fiji dollar.
    public static let fjd = Currency(code: "FJD", number: 242, e: 2, name: "Fiji dollar")
    
    /// A `Currency` instance for the Falkland Islands pound.
    public static let fkp = Currency(code: "FKP", number: 238, e: 2, name: "Falkland Islands pound")
    
    /// A `Currency` instance for the Pound sterling.
    public static let gbp = Currency(code: "GBP", number: 826, e: 2, name: "Pound sterling")
    
    /// A `Currency` instance for the Georgian lari.
    public static let gel = Currency(code: "GEL", number: 981, e: 2, name: "Georgian lari")
    
    /// A `Currency` instance for the Ghanaian cedi.
    public static let ghs = Currency(code: "GHS", number: 936, e: 2, name: "Ghanaian cedi")
    
    /// A `Currency` instance for the Gibraltar pound.
    public static let gip = Currency(code: "GIP", number: 292, e: 2, name: "Gibraltar pound")
    
    /// A `Currency` instance for the Gambian dalasi.
    public static let gmd = Currency(code: "GMD", number: 270, e: 2, name: "Gambian dalasi")
    
    /// A `Currency` instance for the Guinean franc.
    public static let gnf = Currency(code: "GNF", number: 324, e: 0, name: "Guinean franc")
    
    /// A `Currency` instance for the Guatemalan quetzal.
    public static let gtq = Currency(code: "GTQ", number: 320, e: 2, name: "Guatemalan quetzal")
    
    /// A `Currency` instance for the Guyanese dollar.
    public static let gyd = Currency(code: "GYD", number: 328, e: 2, name: "Guyanese dollar")
    
    /// A `Currency` instance for the Hong Kong dollar.
    public static let hkd = Currency(code: "HKD", number: 344, e: 2, name: "Hong Kong dollar")
    
    /// A `Currency` instance for the Honduran lempira.
    public static let hnl = Currency(code: "HNL", number: 340, e: 2, name: "Honduran lempira")
    
    /// A `Currency` instance for the Croatian kuna.
    public static let hrk = Currency(code: "HRK", number: 191, e: 2, name: "Croatian kuna")
    
    /// A `Currency` instance for the Haitian gourde.
    public static let htg = Currency(code: "HTG", number: 332, e: 2, name: "Haitian gourde")
    
    /// A `Currency` instance for the Hungarian forint.
    public static let huf = Currency(code: "HUF", number: 348, e: 2, name: "Hungarian forint")
    
    /// A `Currency` instance for the Indonesian rupiah.
    public static let idr = Currency(code: "IDR", number: 360, e: 2, name: "Indonesian rupiah")
    
    /// A `Currency` instance for the Israeli new shekel.
    public static let ils = Currency(code: "ILS", number: 376, e: 2, name: "Israeli new shekel")
    
    /// A `Currency` instance for the Indian rupee.
    public static let inr = Currency(code: "INR", number: 356, e: 2, name: "Indian rupee")
    
    /// A `Currency` instance for the Iraqi dinar.
    public static let iqd = Currency(code: "IQD", number: 368, e: 3, name: "Iraqi dinar")
    
    /// A `Currency` instance for the Iranian rial.
    public static let irr = Currency(code: "IRR", number: 364, e: 2, name: "Iranian rial")
    /// A `Currency` instance for the Icelandic króna.
    public static let isk = Currency(code: "ISK", number: 352, e: 0, name: "Icelandic króna")
    
    /// A `Currency` instance for the Jamaican dollar.
    public static let jmd = Currency(code: "JMD", number: 388, e: 2, name: "Jamaican dollar")
    
    /// A `Currency` instance for the Jordanian dinar.
    public static let jod = Currency(code: "JOD", number: 400, e: 3, name: "Jordanian dinar")
    
    /// A `Currency` instance for the Japanese yen.
    public static let jpy = Currency(code: "JPY", number: 392, e: 0, name: "Japanese yen")
    
    /// A `Currency` instance for the Kenyan shilling.
    public static let kes = Currency(code: "KES", number: 404, e: 2, name: "Kenyan shilling")
    
    /// A `Currency` instance for the Kyrgyzstani som.
    public static let kgs = Currency(code: "KGS", number: 417, e: 2, name: "Kyrgyzstani som")
    
    /// A `Currency` instance for the Cambodian riel.
    public static let khr = Currency(code: "KHR", number: 116, e: 2, name: "Cambodian riel")
    
    /// A `Currency` instance for the Comoro franc.
    public static let kmf = Currency(code: "KMF", number: 174, e: 0, name: "Comoro franc")
    
    /// A `Currency` instance for the North Korean won.
    public static let kpw = Currency(code: "KPW", number: 408, e: 2, name: "North Korean won")
    
    /// A `Currency` instance for the South Korean won.
    public static let krw = Currency(code: "KRW", number: 410, e: 0, name: "South Korean won")
    
    /// A `Currency` instance for the Kuwaiti dinar.
    public static let kwd = Currency(code: "KWD", number: 414, e: 3, name: "Kuwaiti dinar")
    
    /// A `Currency` instance for the Cayman Islands dollar.
    public static let kyd = Currency(code: "KYD", number: 136, e: 2, name: "Cayman Islands dollar")
    
    /// A `Currency` instance for the Kazakhstani tenge.
    public static let kzt = Currency(code: "KZT", number: 398, e: 2, name: "Kazakhstani tenge")
    
    /// A `Currency` instance for the Lao kip.
    public static let lak = Currency(code: "LAK", number: 418, e: 2, name: "Lao kip")
    
    /// A `Currency` instance for the Lebanese pound.
    public static let lbp = Currency(code: "LBP", number: 422, e: 2, name: "Lebanese pound")
    
    /// A `Currency` instance for the Sri Lankan rupee.
    public static let lkr = Currency(code: "LKR", number: 144, e: 2, name: "Sri Lankan rupee")
    
    /// A `Currency` instance for the Liberian dollar.
    public static let lrd = Currency(code: "LRD", number: 430, e: 2, name: "Liberian dollar")
    
    /// A `Currency` instance for the Lesotho loti.
    public static let lsl = Currency(code: "LSL", number: 426, e: 2, name: "Lesotho loti")
    
    /// A `Currency` instance for the Libyan dinar.
    public static let lyd = Currency(code: "LYD", number: 434, e: 3, name: "Libyan dinar")
    
    /// A `Currency` instance for the Moroccan dirham.
    public static let mad = Currency(code: "MAD", number: 504, e: 2, name: "Moroccan dirham")
    
    /// A `Currency` instance for the Moldovan leu.
    public static let mdl = Currency(code: "MDL", number: 498, e: 2, name: "Moldovan leu")
    
    /// A `Currency` instance for the Malagasy ariary.
    public static let mga = Currency(code: "MGA", number: 969, e: 1, name: "Malagasy ariary")
    
    /// A `Currency` instance for the Macedonian denar.
    public static let mkd = Currency(code: "MKD", number: 807, e: 2, name: "Macedonian denar")
    
    /// A `Currency` instance for the Myanmar kyat.
    public static let mmk = Currency(code: "MMK", number: 104, e: 2, name: "Myanmar kyat")
    
    /// A `Currency` instance for the Mongolian tögrög.
    public static let mnt = Currency(code: "MNT", number: 496, e: 2, name: "Mongolian tögrög")
    
    /// A `Currency` instance for the Macanese pataca.
    public static let mop = Currency(code: "MOP", number: 446, e: 2, name: "Macanese pataca")
    
    /// A `Currency` instance for the Mauritanian ouguiya.
    public static let mru = Currency(code: "MRU", number: 929, e: 1, name: "Mauritanian ouguiya")
    
    /// A `Currency` instance for the Mauritian rupee.
    public static let mur = Currency(code: "MUR", number: 480, e: 2, name: "Mauritian rupee")
    
    /// A `Currency` instance for the Maldivian rufiyaa.
    public static let mvr = Currency(code: "MVR", number: 462, e: 2, name: "Maldivian rufiyaa")
    
    /// A `Currency` instance for the Malawian kwacha.
    public static let mwk = Currency(code: "MWK", number: 454, e: 2, name: "Malawian kwacha")
    
    /// A `Currency` instance for the Mexican peso.
    public static let mxn = Currency(code: "MXN", number: 484, e: 2, name: "Mexican peso")
    
    /// A `Currency` instance for the Mexican Unidad de Inversion (UDI) (funds code).
    public static let mxv = Currency(code: "MXV", number: 979, e: 2, name: "Mexican Unidad de Inversion (UDI) (funds code)")
    
    /// A `Currency` instance for the Malaysian ringgit.
    public static let myr = Currency(code: "MYR", number: 458, e: 2, name: "Malaysian ringgit")
    
    /// A `Currency` instance for the Mozambican metical.
    public static let mzn = Currency(code: "MZN", number: 943, e: 2, name: "Mozambican metical")
    
    /// A `Currency` instance for the Namibian dollar.
    public static let nad = Currency(code: "NAD", number: 516, e: 2, name: "Namibian dollar")
    
    /// A `Currency` instance for the Nigerian naira.
    public static let ngn = Currency(code: "NGN", number: 566, e: 2, name: "Nigerian naira")
    
    /// A `Currency` instance for the Nicaraguan córdoba.
    public static let nio = Currency(code: "NIO", number: 558, e: 2, name: "Nicaraguan córdoba")
    
    /// A `Currency` instance for the Norwegian krone.
    public static let nok = Currency(code: "NOK", number: 578, e: 2, name: "Norwegian krone")
    
    /// A `Currency` instance for the Nepalese rupee.
    public static let npr = Currency(code: "NPR", number: 524, e: 2, name: "Nepalese rupee")
    
    /// A `Currency` instance for the New Zealand dollar.
    public static let nzd = Currency(code: "NZD", number: 554, e: 2, name: "New Zealand dollar")
    
    /// A `Currency` instance for the Omani rial.
    public static let omr = Currency(code: "OMR", number: 512, e: 3, name: "Omani rial")
    
    /// A `Currency` instance for the Panamanian balboa.
    public static let pab = Currency(code: "PAB", number: 590, e: 2, name: "Panamanian balboa")
    
    /// A `Currency` instance for the Peruvian sol.
    public static let pen = Currency(code: "PEN", number: 604, e: 2, name: "Peruvian sol")
    
    /// A `Currency` instance for the Papua New Guinean kina.
    public static let pgk = Currency(code: "PGK", number: 598, e: 2, name: "Papua New Guinean kina")
    
    /// A `Currency` instance for the Philippine piso.
    public static let php = Currency(code: "PHP", number: 608, e: 2, name: "Philippine piso")
    
    /// A `Currency` instance for the Pakistani rupee.
    public static let pkr = Currency(code: "PKR", number: 586, e: 2, name: "Pakistani rupee")
    
    /// A `Currency` instance for the Polish złoty.
    public static let pln = Currency(code: "PLN", number: 985, e: 2, name: "Polish złoty")
    
    /// A `Currency` instance for the Paraguayan guaraní.
    public static let pyg = Currency(code: "PYG", number: 600, e: 0, name: "Paraguayan guaraní")
    
    /// A `Currency` instance for the Qatari riyal.
    public static let qar = Currency(code: "QAR", number: 634, e: 2, name: "Qatari riyal")
    
    /// A `Currency` instance for the Romanian leu.
    public static let ron = Currency(code: "RON", number: 946, e: 2, name: "Romanian leu")
    
    /// A `Currency` instance for the Serbian dinar.
    public static let rsd = Currency(code: "RSD", number: 941, e: 2, name: "Serbian dinar")
    
    /// A `Currency` instance for the Russian ruble.
    public static let rub = Currency(code: "RUB", number: 643, e: 2, name: "Russian ruble")
    
    /// A `Currency` instance for the Rwandan franc.
    public static let rwf = Currency(code: "RWF", number: 646, e: 0, name: "Rwandan franc")
    
    /// A `Currency` instance for the Saudi riyal.
    public static let sar = Currency(code: "SAR", number: 682, e: 2, name: "Saudi riyal")
    
    /// A `Currency` instance for the Solomon Islands dollar.
    public static let sbd = Currency(code: "SBD", number: 090, e: 2, name: "Solomon Islands dollar")
    
    /// A `Currency` instance for the Seychelles rupee.
    public static let scr = Currency(code: "SCR", number: 690, e: 2, name: "Seychelles rupee")
    
    /// A `Currency` instance for the Sudanese pound.
    public static let sdg = Currency(code: "SDG", number: 938, e: 2, name: "Sudanese pound")
    
    /// A `Currency` instance for the Swedish krona/kronor.
    public static let sek = Currency(code: "SEK", number: 752, e: 2, name: "Swedish krona/kronor")
    
    /// A `Currency` instance for the Singapore dollar.
    public static let sgd = Currency(code: "SGD", number: 702, e: 2, name: "Singapore dollar")
    
    /// A `Currency` instance for the Saint Helena pound.
    public static let shp = Currency(code: "SHP", number: 654, e: 2, name: "Saint Helena pound")
    
    /// A `Currency` instance for the Sierra Leonean leone.
    public static let sll = Currency(code: "SLL", number: 694, e: 2, name: "Sierra Leonean leone")
    
    /// A `Currency` instance for the Somali shilling.
    public static let sos = Currency(code: "SOS", number: 706, e: 2, name: "Somali shilling")
    
    /// A `Currency` instance for the Surinamese dollar.
    public static let srd = Currency(code: "SRD", number: 968, e: 2, name: "Surinamese dollar")
    
    /// A `Currency` instance for the South Sudanese pound.
    public static let ssp = Currency(code: "SSP", number: 728, e: 2, name: "South Sudanese pound")
    
    /// A `Currency` instance for the São Tomé and Príncipe dobra.
    public static let stn = Currency(code: "STN", number: 930, e: 2, name: "São Tomé and Príncipe dobra")
    
    /// A `Currency` instance for the Salvadoran colón.
    public static let svc = Currency(code: "SVC", number: 222, e: 2, name: "Salvadoran colón")
    
    /// A `Currency` instance for the Syrian pound.
    public static let syp = Currency(code: "SYP", number: 760, e: 2, name: "Syrian pound")
    
    /// A `Currency` instance for the Swazi lilangeni.
    public static let szl = Currency(code: "SZL", number: 748, e: 2, name: "Swazi lilangeni")
    
    /// A `Currency` instance for the Thai baht.
    public static let thb = Currency(code: "THB", number: 764, e: 2, name: "Thai baht")
    
    /// A `Currency` instance for the Tajikistani somoni.
    public static let tjs = Currency(code: "TJS", number: 972, e: 2, name: "Tajikistani somoni")
    
    /// A `Currency` instance for the Turkmenistan manat.
    public static let tmt = Currency(code: "TMT", number: 934, e: 2, name: "Turkmenistan manat")
    
    /// A `Currency` instance for the Tunisian dinar.
    public static let tnd = Currency(code: "TND", number: 788, e: 3, name: "Tunisian dinar")
    
    /// A `Currency` instance for the Tongan paʻanga.
    public static let top = Currency(code: "TOP", number: 776, e: 2, name: "Tongan paʻanga")
    
    /// A `Currency` instance for the Turkish lira.
    public static let `try` = Currency(code: "TRY", number: 949, e: 2, name: "Turkish lira")
    
    /// A `Currency` instance for the Trinidad and Tobago dollar.
    public static let ttd = Currency(code: "TTD", number: 780, e: 2, name: "Trinidad and Tobago dollar")
    
    /// A `Currency` instance for the New Taiwan dollar.
    public static let twd = Currency(code: "TWD", number: 901, e: 2, name: "New Taiwan dollar")
    
    /// A `Currency` instance for the Tanzanian shilling.
    public static let tzs = Currency(code: "TZS", number: 834, e: 2, name: "Tanzanian shilling")
    
    /// A `Currency` instance for the Ukrainian hryvnia.
    public static let uah = Currency(code: "UAH", number: 980, e: 2, name: "Ukrainian hryvnia")
    
    /// A `Currency` instance for the Ugandan shilling.
    public static let ugx = Currency(code: "UGX", number: 800, e: 0, name: "Ugandan shilling")
    
    /// A `Currency` instance for the United States dollar.
    public static let usd = Currency(code: "USD", number: 840, e: 2, name: "United States dollar")
    
    /// A `Currency` instance for the United States dollar (next day) (funds code).
    public static let usn = Currency(code: "USN", number: 997, e: 2, name: "United States dollar (next day) (funds code)")
    
    /// A `Currency` instance for the Uruguay Peso en Unidades Indexadas (URUIURUI) (funds code).
    public static let uyi = Currency(code: "UYI", number: 940, e: 0, name: "Uruguay Peso en Unidades Indexadas (URUIURUI) (funds code)")
    
    /// A `Currency` instance for the Uruguayan peso.
    public static let uyu = Currency(code: "UYU", number: 858, e: 2, name: "Uruguayan peso")
    
    /// A `Currency` instance for the Uzbekistan som.
    public static let uzs = Currency(code: "UZS", number: 860, e: 2, name: "Uzbekistan som")
    
    /// A `Currency` instance for the Venezuelan bolívar.
    public static let vef = Currency(code: "VEF", number: 937, e: 2, name: "Venezuelan bolívar")
    
    /// A `Currency` instance for the Vietnamese đồng.
    public static let vnd = Currency(code: "VND", number: 704, e: 0, name: "Vietnamese đồng")
    
    /// A `Currency` instance for the Vanuatu vatu.
    public static let vuv = Currency(code: "VUV", number: 548, e: 0, name: "Vanuatu vatu")
    
    /// A `Currency` instance for the Samoan tala.
    public static let wst = Currency(code: "WST", number: 882, e: 2, name: "Samoan tala")
    
    /// A `Currency` instance for the CFA franc BEAC.
    public static let xaf = Currency(code: "XAF", number: 950, e: 0, name: "CFA franc BEAC")
    
    /// A `Currency` instance for the Silver (one troy ounce).
    public static let xag = Currency(code: "XAG", number: 961, e: nil, name: "Silver (one troy ounce)")
    
    /// A `Currency` instance for the Gold (one troy ounce).
    public static let xau = Currency(code: "XAU", number: 959, e: nil, name: "Gold (one troy ounce)")
    
    /// A `Currency` instance for the European Composite Unit (EURCO) (bond market unit).
    public static let xba = Currency(code: "XBA", number: 955, e: nil, name: "European Composite Unit (EURCO) (bond market unit)")
    
    /// A `Currency` instance for the European Monetary Unit (E.M.U.-6) (bond market unit).
    public static let xbb = Currency(code: "XBB", number: 956, e: nil, name: "European Monetary Unit (E.M.U.-6) (bond market unit)")
    
    /// A `Currency` instance for the European Unit of Account 9 (E.U.A.-9) (bond market unit).
    public static let xbc = Currency(code: "XBC", number: 957, e: nil, name: "European Unit of Account 9 (E.U.A.-9) (bond market unit)")
    
    /// A `Currency` instance for the European Unit of Account 17 (E.U.A.-17) (bond market unit).
    public static let xbd = Currency(code: "XBD", number: 958, e: nil, name: "European Unit of Account 17 (E.U.A.-17) (bond market unit)")
    
    /// A `Currency` instance for the East Caribbean dollar.
    public static let xcd = Currency(code: "XCD", number: 951, e: 2, name: "East Caribbean dollar")
    
    /// A `Currency` instance for the Special drawing rights.
    public static let xdr = Currency(code: "XDR", number: 960, e: nil, name: "Special drawing rights")
    
    /// A `Currency` instance for the CFA franc BCEAO.
    public static let xof = Currency(code: "XOF", number: 952, e: 0, name: "CFA franc BCEAO")
    
    /// A `Currency` instance for the Palladium (one troy ounce).
    public static let xpd = Currency(code: "XPD", number: 964, e: nil, name: "Palladium (one troy ounce)")
    
    /// A `Currency` instance for the CFP franc (franc Pacifique).
    public static let xpf = Currency(code: "XPF", number: 953, e: 0, name: "CFP franc (franc Pacifique)")
    
    /// A `Currency` instance for the Platinum (one troy ounce).
    public static let xpt = Currency(code: "XPT", number: 962, e: nil, name: "Platinum (one troy ounce)")
    
    /// A `Currency` instance for the SUCRE.
    public static let xsu = Currency(code: "XSU", number: 994, e: nil, name: "SUCRE")
    
    /// A `Currency` instance for the Code reserved for testing purposes.
    public static let xts = Currency(code: "XTS", number: 963, e: nil, name: "Code reserved for testing purposes")
    
    /// A `Currency` instance for the ADB Unit of Account.
    public static let xua = Currency(code: "XUA", number: 965, e: nil, name: "ADB Unit of Account")
    
    /// A `Currency` instance for the No currency.
    public static let xxx = Currency(code: "XXX", number: 999, e: nil, name: "No currency")
    
    /// A `Currency` instance for the Yemeni rial.
    public static let yer = Currency(code: "YER", number: 886, e: 2, name: "Yemeni rial")
    
    /// A `Currency` instance for the South African rand.
    public static let zar = Currency(code: "ZAR", number: 710, e: 2, name: "South African rand")
    
    /// A `Currency` instance for the Zambian kwacha.
    public static let zmw = Currency(code: "ZMW", number: 967, e: 2, name: "Zambian kwacha")
    
    /// A `Currency` instance for the Zimbabwean dollar A/10.
    public static let zwl = Currency(code: "ZWL", number: 932, e: 2, name: "Zimbabwean dollar A/10")
    
    
    // MARK: - Sub-Types
    
    /// The coding keys for encoding and decoding a `Currency` instance.
    enum CodingKeys: String, CodingKey {
        
        ///
        case code
        
        ///
        case number
        
        ///
        case e
        
        ///
        case name
    }
}


// MARK: - Protocol Conformances
extension Currency: CaseIterable {
    
    /// All known currencies.
    public static let allCases: [Currency] = Array(Currency.allKeyedCases.values)
    
    /// All known currencies, each keyed with its corrosponding code in lowercase.
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
