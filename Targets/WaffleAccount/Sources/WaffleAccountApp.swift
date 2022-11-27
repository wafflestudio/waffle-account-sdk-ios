import SwiftUI
import WaffleAccountUI
import WaffleAccountKit

@main
struct WaffleAccountApp: App {
    
    @State var presentWaffleLogin = false
    
    var body: some Scene {
        WindowGroup {
            VStack {
                
                WaffleButton() {
                   presentWaffleLogin = true
                }
                    .buttonSettings(\.type, .default)
                    .buttonSettings(\.borderColor, .clear)
                    .buttonSettings(\.backgroundColor, .wafflePink)
                    .buttonSettings(\.foregroundColor, .white)
                
                WaffleButton() {
                    
                }
                    .buttonSettings(\.type, .default)
                    .buttonSettings(\.borderColor, .wafflePink)
                    .buttonSettings(\.backgroundColor, .clear)
                    .buttonSettings(\.foregroundColor, .wafflePink)
                    .buttonSettings(\.borderWidth, 1.5)
                    .defaultButtonLayout(\.verticalPadding, 12)
                
                WaffleButton() {
                    
                }
                    .buttonSettings(\.image, Image(uiImage: WaffleAccountUIAsset.waffleDark.image))
                    .buttonSettings(\.type, .default)
                    .buttonSettings(\.borderColor, .waffleOrange)
                    .buttonSettings(\.backgroundColor, .clear)
                    .buttonSettings(\.foregroundColor, .waffleOrange)
                    .buttonSettings(\.borderWidth, 1.5)
                    .defaultButtonLayout(\.cornerRadius, 24)
                    .defaultButtonLayout(\.verticalPadding, 12)
                            
                WaffleButton() {
                    
                }
                    .buttonSettings(\.type, .compact)
                    .buttonSettings(\.borderColor, .clear)
                    .buttonSettings(\.backgroundColor, .wafflePink)
            }
            .waffleLogin(isPresented: $presentWaffleLogin, onSuccessLogin: { payload in
                print("PAYLOD \(payload)")
            }, onFailLogin: { _ in 
                print("FAILURE")
            })
            .frame(maxWidth: .infinity)
            .padding(20)
        }
    }
}
