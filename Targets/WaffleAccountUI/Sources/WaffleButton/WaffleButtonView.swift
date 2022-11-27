//
//  WaffleButtonView.swift
//  WaffleAccountKit
//
//  Created by parksubeen on 2022/11/26.
//  Copyright © 2022 com.wafflestudio. All rights reserved.
//

import SwiftUI

struct WaffleButtonView: View {
    
    @Environment(\.buttonSettings) var buttonSettings
    @Environment(\.defaultButtonLayout) var defaultButtonLayout
    @Environment(\.compactButtonLayout) var compactButtonLayout
    
    public var body: some View {
        makeButtonBody()
    }
    
}

private extension WaffleButtonView {
    
    @ViewBuilder
    func makeButtonBody() -> some View {
        switch buttonSettings.type {
        case .default:
            makeDefaultButtonBody()
        case .compact:
            makeCompactButtonBody()
        }
    }
    
    @ViewBuilder
    func makeDefaultButtonBody() -> some View {
        HStack {
            if defaultButtonLayout.alignment != .leading {
                Spacer()
            }
            
            if let image = buttonSettings.image {
                image
                    .resizable()
                    .frame(width: 28, height: 28)
                    .aspectRatio(contentMode: .fit)
            }
            
            Text(buttonSettings.title)
                .font(buttonSettings.font)
                .foregroundColor(buttonSettings.foregroundColor)
            
            if defaultButtonLayout.alignment != .trailing {
                Spacer()
            }
        }
        .padding(.horizontal, defaultButtonLayout.horizontalPadding)
        .padding(.vertical, defaultButtonLayout.verticalPadding)
        .background(buttonSettings.backgroundColor.cornerRadius(defaultButtonLayout.cornerRadius))
        .overlay {
            RoundedRectangle(cornerRadius: defaultButtonLayout.cornerRadius)
                .strokeBorder(buttonSettings.borderColor, lineWidth: buttonSettings.borderWidth)
        }
        .frame(maxWidth: buttonSettings.type == .default ? .infinity : nil)
    }
    
    @ViewBuilder
    func makeCompactButtonBody() -> some View {
        ZStack {
            Circle()
                .strokeBorder(buttonSettings.borderColor, lineWidth: buttonSettings.borderWidth)
                .background(Circle().foregroundColor(buttonSettings.backgroundColor))
                .frame(width: compactButtonLayout.size, height: compactButtonLayout.size)
            getImageOrTitle()
        }
    }
    
    @ViewBuilder
    func getImageOrTitle() -> some View {
        if let image = buttonSettings.image {
            image
                .resizable()
                .frame(width: 28, height: 28)
                .aspectRatio(contentMode: .fit)
        } else {
            Text(buttonSettings.title)
                .font(buttonSettings.font)
                .foregroundColor(buttonSettings.foregroundColor)
        }
    }
    
}


struct WaffleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
            WaffleButtonView()
                .buttonSettings(\.type, .default)
                .buttonSettings(\.borderColor, .clear)
                .buttonSettings(\.backgroundColor, .wafflePink)
                .buttonSettings(\.foregroundColor, .white)
            
            WaffleButtonView()
                .buttonSettings(\.type, .default)
                .buttonSettings(\.borderColor, .wafflePink)
                .buttonSettings(\.backgroundColor, .clear)
                .buttonSettings(\.foregroundColor, .wafflePink)
                .buttonSettings(\.borderWidth, 1.5)
                .defaultButtonLayout(\.verticalPadding, 12)
            
            WaffleButtonView()
                .buttonSettings(\.image, Image(uiImage: WaffleAccountUIAsset.waffleDark.image))
                .buttonSettings(\.type, .default)
                .buttonSettings(\.borderColor, .waffleOrange)
                .buttonSettings(\.backgroundColor, .clear)
                .buttonSettings(\.foregroundColor, .waffleOrange)
                .buttonSettings(\.borderWidth, 1.5)
                .defaultButtonLayout(\.cornerRadius, 24)
                .defaultButtonLayout(\.verticalPadding, 12)
                        
            WaffleButtonView()
                .buttonSettings(\.type, .compact)
                .buttonSettings(\.borderColor, .clear)
                .buttonSettings(\.backgroundColor, .wafflePink)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
    }
}
