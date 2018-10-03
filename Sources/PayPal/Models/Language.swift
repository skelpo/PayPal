import Vapor

/// A language code for PayPal to translate messages.
public enum Language: String, Hashable, CaseIterable, Content {
    case da_DK, de_DE, en_AU, en_GB, en_US, es_ES, es_XC, fr_CA, fr_FR, fr_XC, he_IL, id_ID, it_IT, ja_JP
    case nl_NL, no_NO, pl_PL, pt_BR, pt_PT, ru_RU, sv_SE, th_TH, tr_TR, zh_CN, zh_HK, zh_TW, zh_XC
}
