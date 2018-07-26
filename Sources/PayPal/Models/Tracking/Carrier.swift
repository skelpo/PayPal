import Vapor

/// The name of the carrier for the shipment of merchandise.
public enum Carrier: String, Hashable, CaseIterable, Content {
    
    /// `UPS`
    case ups = "UPS"
    
    /// `USPS`
    case usps = "USPS"
    
    /// `FEDEX`
    case fedex = "FEDEX"
    
    /// `AIRBORNE_EXPRESS`
    case airborneExpress = "AIRBORNE_EXPRESS"
    
    /// `DHL`
    case dhl = "DHL"
    
    /// `AIRSURE`
    case airsure = "AIRSURE"
    
    /// `ROYAL_MAIL`
    case royalMail = "ROYAL_MAIL"
    
    /// `PARCELFORCE`
    case parcelforce = "PARCELFORCE"
    
    /// `SWIFTAIR`
    case swiftair = "SWIFTAIR"
    
    /// `OTHER`
    case other = "OTHER"
    
    /// `UK_PARCELFORCE`
    case ukParcelforce = "UK_PARCELFORCE"
    
    /// `UK_ROYALMAIL_SPECIAL`
    case ukRoyalmailSpecial = "UK_ROYALMAIL_SPECIAL"
    
    /// `UK_ROYALMAIL_RECORDED`
    case ukRoyalmailRecorded = "UK_ROYALMAIL_RECORDED"
    
    /// `UK_ROYALMAIL_INT_SIGNED`
    case ukRoyalmailIntSigned = "UK_ROYALMAIL_INT_SIGNED"
    
    /// `UK_ROYALMAIL_AIRSURE`
    case ukRoyalmailAirsure = "UK_ROYALMAIL_AIRSURE"
    
    /// `UK_UPS`
    case ukUps = "UK_UPS"
    
    /// `UK_FEDEX`
    case ukFedex = "UK_FEDEX"
    
    /// `UK_AIRBORNE_EXPRESS`
    case ukAirborneExpress = "UK_AIRBORNE_EXPRESS"
    
    /// `UK_DHL`
    case ukDhl = "UK_DHL"
    
    /// `UK_OTHER`
    case ukOther = "UK_OTHER"
    
    /// `UK_CANNOT_PROV_TRACK`
    case ukCannotProvTrack = "UK_CANNOT_PROV_TRACK"
    
    /// `CA_CANADA_POST`
    case caCanadaPost = "CA_CANADA_POST"
    
    /// `CA_PUROLATOR`
    case caPurolator = "CA_PUROLATOR"
    
    /// `CA_CANPAR`
    case caCanpar = "CA_CANPAR"
    
    /// `CA_LOOMIS`
    case caLoomis = "CA_LOOMIS"
    
    /// `CA_TNT`
    case caTnt = "CA_TNT"
    
    /// `CA_OTHER`
    case caOther = "CA_OTHER"
    
    /// `CA_CANNOT_PROV_TRACK`
    case caCannotProvTrack = "CA_CANNOT_PROV_TRACK"
    
    /// `DE_DP_DHL_WITHIN_EUROPE`
    case deDpDhlWithinEurope = "DE_DP_DHL_WITHIN_EUROPE"
    
    /// `DE_DP_DHL_T_AND_T_EXPRESS`
    case deDpDhlTAndTExpress = "DE_DP_DHL_T_AND_T_EXPRESS"
    
    /// `DE_DHL_DP_INTL_SHIPMENTS`
    case deDhlDpIntlShipments = "DE_DHL_DP_INTL_SHIPMENTS"
    
    /// `DE_GLS`
    case deGls = "DE_GLS"
    
    /// `DE_DPD_DELISTACK`
    case deDpdDelistack = "DE_DPD_DELISTACK"
    
    /// `DE_HERMES`
    case deHermes = "DE_HERMES"
    
    /// `DE_UPS`
    case deUps = "DE_UPS"
    
    /// `DE_FEDEX`
    case deFedex = "DE_FEDEX"
    
    /// `DE_TNT`
    case deTnt = "DE_TNT"
    
    /// `DE_OTHER`
    case deOther = "DE_OTHER"
    
    /// `FR_CHRONOPOST`
    case frChronopost = "FR_CHRONOPOST"
    
    /// `FR_COLIPOSTE`
    case frColiposte = "FR_COLIPOSTE"
    
    /// `FR_DHL`
    case frDhl = "FR_DHL"
    
    /// `FR_UPS`
    case frUps = "FR_UPS"
    
    /// `FR_FEDEX`
    case frFedex = "FR_FEDEX"
    
    /// `FR_TNT`
    case frTnt = "FR_TNT"
    
    /// `FR_GLS`
    case frGls = "FR_GLS"
    
    /// `FR_OTHER`
    case frOther = "FR_OTHER"
    
    /// `IT_POSTE_ITALIA`
    case itPosteItalia = "IT_POSTE_ITALIA"
    
    /// `IT_DHL`
    case itDhl = "IT_DHL"
    
    /// `IT_UPS`
    case itUps = "IT_UPS"
    
    /// `IT_FEDEX`
    case itFedex = "IT_FEDEX"
    
    /// `IT_TNT`
    case itTnt = "IT_TNT"
    
    /// `IT_GLS`
    case itGls = "IT_GLS"
    
    /// `IT_OTHER`
    case itOther = "IT_OTHER"
    
    /// `AU_AUSTRALIA_POST_EP_PLAT`
    case auAustraliaPostEpPlat = "AU_AUSTRALIA_POST_EP_PLAT"
    
    /// `AU_AUSTRALIA_POST_EPARCEL`
    case auAustraliaPostEparcel = "AU_AUSTRALIA_POST_EPARCEL"
    
    /// `AU_AUSTRALIA_POST_EMS`
    case auAustraliaPostEms = "AU_AUSTRALIA_POST_EMS"
    
    /// `AU_DHL`
    case auDhl = "AU_DHL"
    
    /// `AU_STAR_TRACK_EXPRESS`
    case auStarTrackExpress = "AU_STAR_TRACK_EXPRESS"
    
    /// `AU_UPS`
    case auUps = "AU_UPS"
    
    /// `AU_FEDEX`
    case auFedex = "AU_FEDEX"
    
    /// `AU_TNT`
    case auTnt = "AU_TNT"
    
    /// `AU_TOLL_IPEC`
    case auTollIpec = "AU_TOLL_IPEC"
    
    /// `AU_OTHER`
    case auOther = "AU_OTHER"
    
    /// `FR_SUIVI`
    case frSuivi = "FR_SUIVI"
    
    /// `IT_EBOOST_SDA`
    case itEboostSda = "IT_EBOOST_SDA"
    
    /// `ES_CORREOS_DE_ESPANA`
    case esCorreosDeEspana = "ES_CORREOS_DE_ESPANA"
    
    /// `ES_DHL`
    case esDhl = "ES_DHL"
    
    /// `ES_UPS`
    case esUps = "ES_UPS"
    
    /// `ES_FEDEX`
    case esFedex = "ES_FEDEX"
    
    /// `ES_TNT`
    case esTnt = "ES_TNT"
    
    /// `ES_OTHER`
    case esOther = "ES_OTHER"
    
    /// `AT_AUSTRIAN_POST_EMS`
    case atAustrianPostEms = "AT_AUSTRIAN_POST_EMS"
    
    /// `AT_AUSTRIAN_POST_PPRIME`
    case atAustrianPostPprime = "AT_AUSTRIAN_POST_PPRIME"
    
    /// `BE_CHRONOPOST`
    case beChronopost = "BE_CHRONOPOST"
    
    /// `BE_TAXIPOST`
    case beTaxipost = "BE_TAXIPOST"
    
    /// `CH_SWISS_POST_EXPRES`
    case chSwissPostExpres = "CH_SWISS_POST_EXPRES"
    
    /// `CH_SWISS_POST_PRIORITY`
    case chSwissPostPriority = "CH_SWISS_POST_PRIORITY"
    
    /// `CN_CHINA_POST`
    case cnChinaPost = "CN_CHINA_POST"
    
    /// `HK_HONGKONG_POST`
    case hkHongkongPost = "HK_HONGKONG_POST"
    
    /// `IE_AN_POST_SDS_EMS`
    case ieAnPostSdsEms = "IE_AN_POST_SDS_EMS"
    
    /// `IE_AN_POST_SDS_PRIORITY`
    case ieAnPostSdsPriority = "IE_AN_POST_SDS_PRIORITY"
    
    /// `IE_AN_POST_REGISTERED`
    case ieAnPostRegistered = "IE_AN_POST_REGISTERED"
    
    /// `IE_AN_POST_SWIFTPOST`
    case ieAnPostSwiftpost = "IE_AN_POST_SWIFTPOST"
    
    /// `IN_INDIAPOST`
    case inIndiapost = "IN_INDIAPOST"
    
    /// `JP_JAPANPOST`
    case jpJapanpost = "JP_JAPANPOST"
    
    /// `KR_KOREA_POST`
    case krKoreaPost = "KR_KOREA_POST"
    
    /// `NL_TPG`
    case nlTpg = "NL_TPG"
    
    /// `SG_SINGPOST`
    case sgSingpost = "SG_SINGPOST"
    
    /// `TW_CHUNGHWA_POST`
    case twChunghwaPost = "TW_CHUNGHWA_POST"
    
    /// `CN_CHINA_POST_EMS`
    case cnChinaPostEms = "CN_CHINA_POST_EMS"
    
    /// `CN_FEDEX`
    case cnFedex = "CN_FEDEX"
    
    /// `CN_TNT`
    case cnTnt = "CN_TNT"
    
    /// `CN_UPS`
    case cnUps = "CN_UPS"
    
    /// `CN_OTHER`
    case cnOther = "CN_OTHER"
    
    /// `NL_TNT`
    case nlTnt = "NL_TNT"
    
    /// `NL_DHL`
    case nlDhl = "NL_DHL"
    
    /// `NL_UPS`
    case nlUps = "NL_UPS"
    
    /// `NL_FEDEX`
    case nlFedex = "NL_FEDEX"
    
    /// `NL_KIALA`
    case nlKiala = "NL_KIALA"
    
    /// `BE_KIALA`
    case beKiala = "BE_KIALA"
    
    /// `PL_POCZTA_POLSKA`
    case plPocztaPolska = "PL_POCZTA_POLSKA"
    
    /// `PL_POCZTEX`
    case plPocztex = "PL_POCZTEX"
    
    /// `PL_GLS`
    case plGls = "PL_GLS"
    
    /// `PL_MASTERLINK`
    case plMasterlink = "PL_MASTERLINK"
    
    /// `PL_TNT`
    case plTnt = "PL_TNT"
    
    /// `PL_DHL`
    case plDhl = "PL_DHL"
    
    /// `PL_UPS`
    case plUps = "PL_UPS"
    
    /// `PL_FEDEX`
    case plFedex = "PL_FEDEX"
    
    /// `JP_SAGAWA_KYUU_BIN`
    case jpSagawaKyuuBin = "JP_SAGAWA_KYUU_BIN"
    
    /// `JP_NITTSU_PELICAN_BIN`
    case jpNittsuPelicanBin = "JP_NITTSU_PELICAN_BIN"
    
    /// `JP_KURO_NEKO_YAMATO_UNYUU`
    case jpKuroNekoYamatoUnyuu = "JP_KURO_NEKO_YAMATO_UNYUU"
    
    /// `JP_TNT`
    case jpTnt = "JP_TNT"
    
    /// `JP_DHL`
    case jpDhl = "JP_DHL"
    
    /// `JP_UPS`
    case jpUps = "JP_UPS"
    
    /// `JP_FEDEX`
    case jpFedex = "JP_FEDEX"
    
    /// `NL_PICKUP`
    case nlPickup = "NL_PICKUP"
    
    /// `NL_INTANGIBLE`
    case nlIntangible = "NL_INTANGIBLE"
    
    /// `NL_ABC_MAIL`
    case nlAbcMail = "NL_ABC_MAIL"
    
    /// `HK_FOUR_PX_EXPRESS`
    case hkFourPxExpress = "HK_FOUR_PX_EXPRESS"
    
    /// `HK_FLYT_EXPRESS`
    case hkFlytExpress = "HK_FLYT_EXPRESS"
}
