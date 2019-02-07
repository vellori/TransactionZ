//
//  CurrencyFinder.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation

struct CurrencyFinder {
    static var localeCache = [String: Locale]()
    static func locale(for currencyIso: String) -> Locale? {
        if let locale = localeCache[currencyIso] {
            return locale
        }
        for localeString in Locale.availableIdentifiers {
            let locale = Locale(identifier: localeString)
            if locale.currencyCode == currencyIso {
                localeCache[currencyIso] = locale
                return locale
            }
        }
        return nil
    }
}
