import XCTest
@testable import PayPal

final class CarrierTests: XCTestCase {
    struct Shippment: Codable {
        let carrier: Carrier
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Carrier.ups.rawValue, "UPS")
        XCTAssertEqual(Carrier.usps.rawValue, "USPS")
        XCTAssertEqual(Carrier.fedex.rawValue, "FEDEX")
        XCTAssertEqual(Carrier.airborneExpress.rawValue, "AIRBORNE_EXPRESS")
        XCTAssertEqual(Carrier.dhl.rawValue, "DHL")
        XCTAssertEqual(Carrier.airsure.rawValue, "AIRSURE")
        XCTAssertEqual(Carrier.royalMail.rawValue, "ROYAL_MAIL")
        XCTAssertEqual(Carrier.parcelforce.rawValue, "PARCELFORCE")
        XCTAssertEqual(Carrier.swiftair.rawValue, "SWIFTAIR")
        XCTAssertEqual(Carrier.other.rawValue, "OTHER")
        XCTAssertEqual(Carrier.ukParcelforce.rawValue, "UK_PARCELFORCE")
        XCTAssertEqual(Carrier.ukRoyalmailSpecial.rawValue, "UK_ROYALMAIL_SPECIAL")
        XCTAssertEqual(Carrier.ukRoyalmailRecorded.rawValue, "UK_ROYALMAIL_RECORDED")
        XCTAssertEqual(Carrier.ukRoyalmailIntSigned.rawValue, "UK_ROYALMAIL_INT_SIGNED")
        XCTAssertEqual(Carrier.ukRoyalmailAirsure.rawValue, "UK_ROYALMAIL_AIRSURE")
        XCTAssertEqual(Carrier.ukUps.rawValue, "UK_UPS")
        XCTAssertEqual(Carrier.ukFedex.rawValue, "UK_FEDEX")
        XCTAssertEqual(Carrier.ukAirborneExpress.rawValue, "UK_AIRBORNE_EXPRESS")
        XCTAssertEqual(Carrier.ukDhl.rawValue, "UK_DHL")
        XCTAssertEqual(Carrier.ukOther.rawValue, "UK_OTHER")
        XCTAssertEqual(Carrier.ukCannotProvTrack.rawValue, "UK_CANNOT_PROV_TRACK")
        XCTAssertEqual(Carrier.caCanadaPost.rawValue, "CA_CANADA_POST")
        XCTAssertEqual(Carrier.caPurolator.rawValue, "CA_PUROLATOR")
        XCTAssertEqual(Carrier.caCanpar.rawValue, "CA_CANPAR")
        XCTAssertEqual(Carrier.caLoomis.rawValue, "CA_LOOMIS")
        XCTAssertEqual(Carrier.caTnt.rawValue, "CA_TNT")
        XCTAssertEqual(Carrier.caOther.rawValue, "CA_OTHER")
        XCTAssertEqual(Carrier.caCannotProvTrack.rawValue, "CA_CANNOT_PROV_TRACK")
        XCTAssertEqual(Carrier.deDpDhlWithinEurope.rawValue, "DE_DP_DHL_WITHIN_EUROPE")
        XCTAssertEqual(Carrier.deDpDhlTAndTExpress.rawValue, "DE_DP_DHL_T_AND_T_EXPRESS")
        XCTAssertEqual(Carrier.deDhlDpIntlShipments.rawValue, "DE_DHL_DP_INTL_SHIPMENTS")
        XCTAssertEqual(Carrier.deGls.rawValue, "DE_GLS")
        XCTAssertEqual(Carrier.deDpdDelistack.rawValue, "DE_DPD_DELISTACK")
        XCTAssertEqual(Carrier.deHermes.rawValue, "DE_HERMES")
        XCTAssertEqual(Carrier.deUps.rawValue, "DE_UPS")
        XCTAssertEqual(Carrier.deFedex.rawValue, "DE_FEDEX")
        XCTAssertEqual(Carrier.deTnt.rawValue, "DE_TNT")
        XCTAssertEqual(Carrier.deOther.rawValue, "DE_OTHER")
        XCTAssertEqual(Carrier.frChronopost.rawValue, "FR_CHRONOPOST")
        XCTAssertEqual(Carrier.frColiposte.rawValue, "FR_COLIPOSTE")
        XCTAssertEqual(Carrier.frDhl.rawValue, "FR_DHL")
        XCTAssertEqual(Carrier.frUps.rawValue, "FR_UPS")
        XCTAssertEqual(Carrier.frFedex.rawValue, "FR_FEDEX")
        XCTAssertEqual(Carrier.frTnt.rawValue, "FR_TNT")
        XCTAssertEqual(Carrier.frGls.rawValue, "FR_GLS")
        XCTAssertEqual(Carrier.frOther.rawValue, "FR_OTHER")
        XCTAssertEqual(Carrier.itPosteItalia.rawValue, "IT_POSTE_ITALIA")
        XCTAssertEqual(Carrier.itDhl.rawValue, "IT_DHL")
        XCTAssertEqual(Carrier.itUps.rawValue, "IT_UPS")
        XCTAssertEqual(Carrier.itFedex.rawValue, "IT_FEDEX")
        XCTAssertEqual(Carrier.itTnt.rawValue, "IT_TNT")
        XCTAssertEqual(Carrier.itGls.rawValue, "IT_GLS")
        XCTAssertEqual(Carrier.itOther.rawValue, "IT_OTHER")
        XCTAssertEqual(Carrier.auAustraliaPostEpPlat.rawValue, "AU_AUSTRALIA_POST_EP_PLAT")
        XCTAssertEqual(Carrier.auAustraliaPostEparcel.rawValue, "AU_AUSTRALIA_POST_EPARCEL")
        XCTAssertEqual(Carrier.auAustraliaPostEms.rawValue, "AU_AUSTRALIA_POST_EMS")
        XCTAssertEqual(Carrier.auDhl.rawValue, "AU_DHL")
        XCTAssertEqual(Carrier.auStarTrackExpress.rawValue, "AU_STAR_TRACK_EXPRESS")
        XCTAssertEqual(Carrier.auUps.rawValue, "AU_UPS")
        XCTAssertEqual(Carrier.auFedex.rawValue, "AU_FEDEX")
        XCTAssertEqual(Carrier.auTnt.rawValue, "AU_TNT")
        XCTAssertEqual(Carrier.auTollIpec.rawValue, "AU_TOLL_IPEC")
        XCTAssertEqual(Carrier.auOther.rawValue, "AU_OTHER")
        XCTAssertEqual(Carrier.frSuivi.rawValue, "FR_SUIVI")
        XCTAssertEqual(Carrier.itEboostSda.rawValue, "IT_EBOOST_SDA")
        XCTAssertEqual(Carrier.esCorreosDeEspana.rawValue, "ES_CORREOS_DE_ESPANA")
        XCTAssertEqual(Carrier.esDhl.rawValue, "ES_DHL")
        XCTAssertEqual(Carrier.esUps.rawValue, "ES_UPS")
        XCTAssertEqual(Carrier.esFedex.rawValue, "ES_FEDEX")
        XCTAssertEqual(Carrier.esTnt.rawValue, "ES_TNT")
        XCTAssertEqual(Carrier.esOther.rawValue, "ES_OTHER")
        XCTAssertEqual(Carrier.atAustrianPostEms.rawValue, "AT_AUSTRIAN_POST_EMS")
        XCTAssertEqual(Carrier.atAustrianPostPprime.rawValue, "AT_AUSTRIAN_POST_PPRIME")
        XCTAssertEqual(Carrier.beChronopost.rawValue, "BE_CHRONOPOST")
        XCTAssertEqual(Carrier.beTaxipost.rawValue, "BE_TAXIPOST")
        XCTAssertEqual(Carrier.chSwissPostExpres.rawValue, "CH_SWISS_POST_EXPRES")
        XCTAssertEqual(Carrier.chSwissPostPriority.rawValue, "CH_SWISS_POST_PRIORITY")
        XCTAssertEqual(Carrier.cnChinaPost.rawValue, "CN_CHINA_POST")
        XCTAssertEqual(Carrier.hkHongkongPost.rawValue, "HK_HONGKONG_POST")
        XCTAssertEqual(Carrier.ieAnPostSdsEms.rawValue, "IE_AN_POST_SDS_EMS")
        XCTAssertEqual(Carrier.ieAnPostSdsPriority.rawValue, "IE_AN_POST_SDS_PRIORITY")
        XCTAssertEqual(Carrier.ieAnPostRegistered.rawValue, "IE_AN_POST_REGISTERED")
        XCTAssertEqual(Carrier.ieAnPostSwiftpost.rawValue, "IE_AN_POST_SWIFTPOST")
        XCTAssertEqual(Carrier.inIndiapost.rawValue, "IN_INDIAPOST")
        XCTAssertEqual(Carrier.jpJapanpost.rawValue, "JP_JAPANPOST")
        XCTAssertEqual(Carrier.krKoreaPost.rawValue, "KR_KOREA_POST")
        XCTAssertEqual(Carrier.nlTpg.rawValue, "NL_TPG")
        XCTAssertEqual(Carrier.sgSingpost.rawValue, "SG_SINGPOST")
        XCTAssertEqual(Carrier.twChunghwaPost.rawValue, "TW_CHUNGHWA_POST")
        XCTAssertEqual(Carrier.cnChinaPostEms.rawValue, "CN_CHINA_POST_EMS")
        XCTAssertEqual(Carrier.cnFedex.rawValue, "CN_FEDEX")
        XCTAssertEqual(Carrier.cnTnt.rawValue, "CN_TNT")
        XCTAssertEqual(Carrier.cnUps.rawValue, "CN_UPS")
        XCTAssertEqual(Carrier.cnOther.rawValue, "CN_OTHER")
        XCTAssertEqual(Carrier.nlTnt.rawValue, "NL_TNT")
        XCTAssertEqual(Carrier.nlDhl.rawValue, "NL_DHL")
        XCTAssertEqual(Carrier.nlUps.rawValue, "NL_UPS")
        XCTAssertEqual(Carrier.nlFedex.rawValue, "NL_FEDEX")
        XCTAssertEqual(Carrier.nlKiala.rawValue, "NL_KIALA")
        XCTAssertEqual(Carrier.beKiala.rawValue, "BE_KIALA")
        XCTAssertEqual(Carrier.plPocztaPolska.rawValue, "PL_POCZTA_POLSKA")
        XCTAssertEqual(Carrier.plPocztex.rawValue, "PL_POCZTEX")
        XCTAssertEqual(Carrier.plGls.rawValue, "PL_GLS")
        XCTAssertEqual(Carrier.plMasterlink.rawValue, "PL_MASTERLINK")
        XCTAssertEqual(Carrier.plTnt.rawValue, "PL_TNT")
        XCTAssertEqual(Carrier.plDhl.rawValue, "PL_DHL")
        XCTAssertEqual(Carrier.plUps.rawValue, "PL_UPS")
        XCTAssertEqual(Carrier.plFedex.rawValue, "PL_FEDEX")
        XCTAssertEqual(Carrier.jpSagawaKyuuBin.rawValue, "JP_SAGAWA_KYUU_BIN")
        XCTAssertEqual(Carrier.jpNittsuPelicanBin.rawValue, "JP_NITTSU_PELICAN_BIN")
        XCTAssertEqual(Carrier.jpKuroNekoYamatoUnyuu.rawValue, "JP_KURO_NEKO_YAMATO_UNYUU")
        XCTAssertEqual(Carrier.jpTnt.rawValue, "JP_TNT")
        XCTAssertEqual(Carrier.jpDhl.rawValue, "JP_DHL")
        XCTAssertEqual(Carrier.jpUps.rawValue, "JP_UPS")
        XCTAssertEqual(Carrier.jpFedex.rawValue, "JP_FEDEX")
        XCTAssertEqual(Carrier.nlPickup.rawValue, "NL_PICKUP")
        XCTAssertEqual(Carrier.nlIntangible.rawValue, "NL_INTANGIBLE")
        XCTAssertEqual(Carrier.nlAbcMail.rawValue, "NL_ABC_MAIL")
        XCTAssertEqual(Carrier.hkFourPxExpress.rawValue, "HK_FOUR_PX_EXPRESS")
        XCTAssertEqual(Carrier.hkFlytExpress.rawValue, "HK_FLYT_EXPRESS")
    }
    
    func testAllCase() {
        XCTAssertEqual(Carrier.allCases.count, 120)
        XCTAssertEqual(Carrier.allCases, [
            .ups, .usps, .fedex, .airborneExpress, .dhl, .airsure, .royalMail, .parcelforce, .swiftair, .other, .ukParcelforce, .ukRoyalmailSpecial,
            .ukRoyalmailRecorded, .ukRoyalmailIntSigned, .ukRoyalmailAirsure, .ukUps, .ukFedex, .ukAirborneExpress, .ukDhl, .ukOther, .ukCannotProvTrack,
            .caCanadaPost, .caPurolator, .caCanpar, .caLoomis, .caTnt, .caOther, .caCannotProvTrack, .deDpDhlWithinEurope, .deDpDhlTAndTExpress,
            .deDhlDpIntlShipments, .deGls, .deDpdDelistack, .deHermes, .deUps, .deFedex, .deTnt, .deOther, .frChronopost, .frColiposte, .frDhl, .frUps,
            .frFedex, .frTnt, .frGls, .frOther, .itPosteItalia, .itDhl, .itUps, .itFedex, .itTnt, .itGls, .itOther, .auAustraliaPostEpPlat,
            .auAustraliaPostEparcel, .auAustraliaPostEms, .auDhl, .auStarTrackExpress, .auUps, .auFedex, .auTnt, .auTollIpec, .auOther, .frSuivi,
            .itEboostSda, .esCorreosDeEspana, .esDhl, .esUps, .esFedex, .esTnt, .esOther, .atAustrianPostEms, .atAustrianPostPprime, .beChronopost,
            .beTaxipost, .chSwissPostExpres, .chSwissPostPriority, .cnChinaPost, .hkHongkongPost, .ieAnPostSdsEms, .ieAnPostSdsPriority, .ieAnPostRegistered,
            .ieAnPostSwiftpost, .inIndiapost, .jpJapanpost, .krKoreaPost, .nlTpg, .sgSingpost, .twChunghwaPost, .cnChinaPostEms, .cnFedex, .cnTnt, .cnUps,
            .cnOther, .nlTnt, .nlDhl, .nlUps, .nlFedex, .nlKiala, .beKiala, .plPocztaPolska, .plPocztex, .plGls, .plMasterlink, .plTnt, .plDhl, .plUps,
            .plFedex, .jpSagawaKyuuBin, .jpNittsuPelicanBin, .jpKuroNekoYamatoUnyuu, .jpTnt, .jpDhl, .jpUps, .jpFedex, .nlPickup, .nlIntangible, .nlAbcMail,
            .hkFourPxExpress, .hkFlytExpress
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        
        let twChunghwaPost = try String(data: encoder.encode(Shippment(carrier: .twChunghwaPost)), encoding: .utf8)
        let frChronopost = try String(data: encoder.encode(Shippment(carrier: .frChronopost)), encoding: .utf8)
        
        XCTAssertEqual(twChunghwaPost, "{\"carrier\":\"TW_CHUNGHWA_POST\"}")
        XCTAssertEqual(frChronopost, "{\"carrier\":\"FR_CHRONOPOST\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        
        let jpKuroNekoYamatoUnyuu = """
        {
            "carrier": "JP_KURO_NEKO_YAMATO_UNYUU"
        }
        """.data(using: .utf8)!
        let usps = """
        {
            "carrier": "USPS"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Shippment.self, from: jpKuroNekoYamatoUnyuu).carrier, .jpKuroNekoYamatoUnyuu)
        try XCTAssertEqual(decoder.decode(Shippment.self, from: usps).carrier, .usps)
    }
    
    static var allTests: [(String, (CarrierTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}


