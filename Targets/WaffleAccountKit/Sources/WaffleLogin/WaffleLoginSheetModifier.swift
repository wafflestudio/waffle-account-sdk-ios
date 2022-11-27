//
//  WaffleLoginSheetModifier.swift
//  WaffleAccount
//
//  Created by parksubeen on 2022/11/26.
//  Copyright © 2022 com.wafflestudio. All rights reserved.
//

import SwiftUI
import WaffleAccountKit

public struct WaffleLoginSheetModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    
    var onSuccessLogin: (WaffleLoginDto) -> Void
    
    var onFailLogin: (Error?) -> Void
    
    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                WebView(url: URL(string: "https://sso.wafflestudio.com")!,
                        onSuccessLogin: { payload in
                    onSuccessLogin(payload)
                    isPresented = false
                },
                        onFailLogin: { error in
                    onFailLogin(error)
                    isPresented = false
                })
            }
    }
    
}

public extension View {
    func waffleLogin(isPresented: Binding<Bool>,
                     onSuccessLogin: @escaping (WaffleLoginDto) -> Void,
                     onFailLogin: @escaping (Error?) -> Void) -> some View {
        modifier(
            WaffleLoginSheetModifier(isPresented: isPresented,
                                     onSuccessLogin: onSuccessLogin,
                                     onFailLogin: onFailLogin))
    }
}
