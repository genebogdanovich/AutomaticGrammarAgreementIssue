//
//  ContentView.swift
//  AutomaticGrammarAgreementIssue
//
//  Created by Gene Bogdanovich on 22.04.22.
//

import SwiftUI

struct ContentView: View {
    /// This value mimics what **StoreKit 2** returns for `Product.SubscriptionPeriod.Unit` in its `localizedDescription` on iOS 15.4.
    let unit = "Week"
    
    @State var value = 1
    
    var key: LocalizedStringKey {
        "Free trial: \(value) \(unit)"
    }
    
    var plainStringKey: String {
        "Free trial: \(value) \(unit)"
    }
    
    var body: some View {
        Form {
            Section {
                // Works fine without string interpolation.
                Text(key)
                    .foregroundColor(.green)
                
                // `NSLocalizedString` doesn't work and it shouldn't as per its docs.
                Text("\(NSLocalizedString(plainStringKey, comment: "")) free")
                    .foregroundColor(.red)
                
                // Doesn't see the string.
                Text("\(String(localized: String.LocalizationValue(stringLiteral: plainStringKey))) free")
                    .foregroundColor(.red)
                
                // This way also doesn't see the string, which is strange, because it should be just like the following way, which does see the string.
                Text("\(String(localized: String.LocalizationValue.init(plainStringKey))) free")
                    .foregroundColor(.red)
                
                // Sees the string (only if I pass literal, not the plainStringKey property), but doesn't apply automatic grammar agreement.
                Text("\(String(localized: String.LocalizationValue("Free trial: \(value) \(unit)"))) free")
                    .foregroundColor(.red)
                
                
                // MARK: Bad solution:
                /*
                 - Doesn't work with Dynamic Type properly
                 - You have to approximate horizontal spacing
                 */
                
                HStack(spacing: 3) {
                    Text("Free trial: \(value) \(unit)")
                        .textCase(.lowercase)
                    Text("free")
                }
                .foregroundColor(.orange)
            }
            
            Section {
                Stepper(value: $value, in: 1...2) {
                    Text("Value: \(value)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
