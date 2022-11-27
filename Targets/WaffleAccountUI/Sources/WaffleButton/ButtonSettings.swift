//
//  ButtonSettings.swift
//  WaffleAccountUI
//
//  Created by parksubeen on 2022/11/26.
//  Copyright © 2022 com.wafflestudio. All rights reserved.
//

import SwiftUI

public enum ButtonType {
    case `default`
    case compact
}

public struct ButtonSettings {
    
    public var type: ButtonType = .default
        
    public var font: Font = .system(size: 16, weight: .semibold)
    
    public var backgroundColor: Color = .clear
    
    public var foregroundColor: Color = .wafflePink
    
    public var borderColor: Color = .wafflePink
    
    public var borderWidth: CGFloat = 0.5
    
    public var image: Image? = Image(uiImage: WaffleAccountUIAsset.waffleLight.image)
    
    public var title: String = "와플로 로그인하기"
    
}

public struct DefaultButtonLayout {
    
    public var horizontalPadding: CGFloat = 16
    
    public var verticalPadding: CGFloat = 8
    
    public var cornerRadius: CGFloat = 8
    
    public var alignment: HorizontalAlignment = .center
    
}

public struct CompactButtonLayout {
    
    public var size: CGFloat = 52
    
}
