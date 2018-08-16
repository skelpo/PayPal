import Vapor

/// The existing time zones that a tangible object can be located in.
public enum Timezone: String, Hashable, CaseIterable, Content {
    
    /// `Pacific/Honolulu`
    case honolulu = "Pacific/Honolulu"
    
    /// `America/Anchorage`
    case anchorage = "America/Anchorage"
    
    /// `America/Los_Angeles`
    case losAngeles = "America/Los_Angeles"
    
    /// `America/Phoenix`
    case phoenix = "America/Phoenix"
    
    /// `America/Denver`
    case denver = "America/Denver"
    
    /// `America/Chicago`
    case chicago = "America/Chicago"
    
    /// `America/Indianapolis`
    case indianapolis = "America/Indianapolis"
    
    /// `America/New_York`
    case newYork = "America/New_York"
    
    /// `America/Puerto_Rico`
    case puertoRic = "America/Puerto_Rico"
    
    /// `America/Vancouver`
    case vancouver = "America/Vancouver"
    
    /// `America/Dawson_Creek`
    case dawsonCreek = "America/Dawson_Creek"
    
    /// `America/Edmonton`
    case edmonton = "America/Edmonton"
    
    /// `America/Regina`
    case regina = "America/Regina"
    
    /// `America/Winnipeg`
    case winnipeg = "America/Winnipeg"
    
    /// `America/Atikokan`
    case atikokan = "America/Atikokan"
    
    /// `America/Toronto`
    case toronto = "America/Toronto"
    
    /// `America/Halifax`
    case halifax = "America/Halifax"
    
    /// `America/Goose_Bay`
    case gooseBay = "America/Goose_Bay"
    
    /// `America/Blanc-Sablon`
    case blancSablon = "America/Blanc-Sablon"
    
    /// `America/St_Johns`
    case stJohns = "America/St_Johns"
    
    /// `America/Tijuana`
    case tijuana = "America/Tijuana"
    
    /// `America/Hermosillo`
    case hermosillo = "America/Hermosillo"
    
    /// `America/Chihuahua`
    case chihuahua = "America/Chihuahua"
    
    /// `America/Mexico_City`
    case mexicoCity = "America/Mexico_City"
    
    /// `America/Rio_Branco`
    case rioBranco = "America/Rio_Branco"
    
    /// `America/Manaus`
    case manaus = "America/Manaus"
    
    /// `America/Campo_Grande`
    case campoGrande = "America/Campo_Grande"
    
    /// `America/Argentina/Buenos_Aires`
    case buenosAires = "America/Argentina/Buenos_Aires"
    
    /// `America/Sao_Paulo`
    case saoPaulo = "America/Sao_Paulo"
    
    /// `America/Fortaleza`
    case fortaleza = "America/Fortaleza"
    
    /// `America/Noronha`
    case noronha = "America/Noronha"
    
    /// `America/Thule`
    case thule = "America/Thule"
    
    /// `America/Godthab`
    case godthab = "America/Godthab"
    
    /// `America/Scoresbysund`
    case scoresbysund = "America/Scoresbysund"
    
    /// `America/Danmarkshavn`
    case danmarkshavan = "America/Danmarkshavn"
    
    /// `Atlantic/Azores`
    case azores = "Atlantic/Azores"
    
    /// `Europe/Lisbon`
    case lisbon = "Europe/Lisbon"
    
    /// `Europe/Dublin`
    case dublin = "Europe/Dublin"
    
    /// `Europe/London`
    case london = "Europe/London"
    
    /// `Europe/Luxembourg`
    case luxembourg = "Europe/Luxembourg"
    
    /// `Europe/Berlin`
    case berlin = "Europe/Berlin"
    
    /// `Atlantic/Faroe`
    case faroe = "Atlantic/Faroe"
    
    /// `Europe/Oslo`
    case oslo = "Europe/Oslo"
    
    /// `Europe/Copenhagen`
    case copenhagen = "Europe/Copenhagen"
    
    /// `Europe/Stockholm`
    case stockholm = "Europe/Stockholm"
    
    /// `Europe/Helsinki`
    case helsinki = "Europe/Helsinki"
    
    /// `Europe/Prague`
    case prague = "Europe/Prague"
    
    /// `Europe/Bratislava`
    case bratislava = "Europe/Bratislava"
    
    /// `Europe/Athens`
    case athens = "Europe/Athens"
    
    /// `Europe/Istanbul`
    case istanbul = "Europe/Istanbul"
    
    /// `Africa/Johannesburg`
    case johannesburg = "Africa/Johannesburg"
    
    /// `Asia/Jerusalem`
    case jerusalem = "Asia/Jerusalem"
    
    /// `Asia/Dubai`
    case dubai = "Asia/Dubai"
    
    /// `Europe/Kaliningrad`
    case kaliningrad = "Europe/Kaliningrad"
    
    /// `Europe/Kiev`
    case kiev = "Europe/Kiev"
    
    /// `Europe/Moscow`
    case moscow = "Europe/Moscow"
    
    /// `Europe/Samara`
    case samara = "Europe/Samara"
    
    /// `Asia/Yekaterinburg`
    case yekaterinburg = "Asia/Yekaterinburg"
    
    /// `Asia/Omsk`
    case omsk = "Asia/Omsk"
    
    /// `Asia/Krasnoyarsk`
    case krasnoyarsk = "Asia/Krasnoyarsk"
    
    /// `Asia/Irkutsk`
    case irkutsk = "Asia/Irkutsk"
    
    /// `Asia/Yakutsk`
    case yakutsk = "Asia/Yakutsk"
    
    /// `Asia/Vladivostok`
    case vladivostok = "Asia/Vladivostok"
    
    /// `Asia/Magadan`
    case magadan = "Asia/Magadan"
    
    /// `Asia/Kamchatka`
    case kamchatka = "Asia/Kamchatka"
    
    /// `Asia/Calcutta`
    case calcutta = "Asia/Calcutta"
    
    /// `Asia/Bangkok`
    case bangkok = "Asia/Bangkok"
    
    /// `Asia/Jakarta`
    case jakarta = "Asia/Jakarta"
    
    /// `Asia/Saigon`
    case saigon = "Asia/Saigon"
    
    /// `Asia/Kuala_Lumpur`
    case kualaLumpur = "Asia/Kuala_Lumpur"
    
    /// `Asia/Singapore`
    case singapore = "Asia/Singapore"
    
    /// `Asia/Hong_Kong`
    case hongKong = "Asia/Hong_Kong"
    
    /// `Asia/Makassar`
    case makassar = "Asia/Makassar"
    
    /// `Asia/Manila`
    case manila = "Asia/Manila"
    
    /// `Asia/Taipei`
    case taipei = "Asia/Taipei"
    
    /// `Asia/Shanghai`
    case shanghai = "Asia/Shanghai"
    
    /// `Asia/Seoul`
    case seoul = "Asia/Seoul"
    
    /// `Asia/Tokyo`
    case tokyo = "Asia/Tokyo"
    
    /// `Asia/Jayapura`
    case jayapura = "Asia/Jayapura"
    
    /// `Australia/Perth`
    case perth = "Australia/Perth"
    
    /// `Australia/Darwin`
    case darwin = "Australia/Darwin"
    
    /// `Australia/Adelaide`
    case adelaide = "Australia/Adelaide"
    
    /// `Australia/Hobart`
    case hobart = "Australia/Hobart"
    
    /// `Australia/Sydney`
    case sydney = "Australia/Sydney"
    
    /// `Australia/Brisbane`
    case brisbane = "Australia/Brisbane"
    
    /// `Australia/Lord_Howe`
    case lordHowe = "Australia/Lord_Howe"
    
    /// `Pacific/Auckland`
    case auckland = "Pacific/Auckland"
    
    /// `Pacific/Chatham`
    case chatham = "Pacific/Chatham"
    
    /// `Pacific/Niue`
    case niue = "Pacific/Niue"
    
    /// `Pacific/Fakaofo`
    case fakaofo = "Pacific/Fakaofo"
    
    /// `Pacific/Rarotonga`
    case rarotonga = "Pacific/Rarotonga"
    
    /// `Europe/Bucharest`
    case bucharest = "Europe/Bucharest"
    
    /// `GMT`
    case gmt = "GMT"
}
