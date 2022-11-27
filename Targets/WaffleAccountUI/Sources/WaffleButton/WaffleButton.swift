//
//  WaffleButton.swift
//  WaffleAccountUI
//
//  Created by parksubeen on 2022/11/26.
//  Copyright © 2022 com.wafflestudio. All rights reserved.
//

import SwiftUI

public struct WaffleButton: View {
    
    var action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        WaffleButtonView()
            .onTapGesture {
                action()
            }
    }
    
}
