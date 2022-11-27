//
//  EnvironmentValues+ButtonSettings.swift
//  WaffleAccountUI
//
//  Created by parksubeen on 2022/11/26.
//  Copyright © 2022 com.wafflestudio. All rights reserved.
//

import SwiftUI

private struct ButtonSettingsEnvironmentKey: EnvironmentKey {
    static var defaultValue: ButtonSettings = .init()
}

private struct DefaultButtonLayoutEnvironmentKey: EnvironmentKey {
    static var defaultValue: DefaultButtonLayout = .init()
}

private struct CompactButtonLayoutEnvironmentKey: EnvironmentKey {
    static var defaultValue: CompactButtonLayout = .init()
}

extension EnvironmentValues {
    var buttonSettings: ButtonSettings {
        get { self[ButtonSettingsEnvironmentKey.self] }
        set { self[ButtonSettingsEnvironmentKey.self] = newValue }
    }
    
    var defaultButtonLayout: DefaultButtonLayout {
        get { self[DefaultButtonLayoutEnvironmentKey.self] }
        set { self[DefaultButtonLayoutEnvironmentKey.self] = newValue }
    }
    
    var compactButtonLayout: CompactButtonLayout {
        get { self[CompactButtonLayoutEnvironmentKey.self] }
        set { self[CompactButtonLayoutEnvironmentKey.self] = newValue }
    }
}

public extension View {
    func buttonSettings(
        type: ButtonType? = nil,
        font: Font? = nil,
        backgroundColor: Color? = nil,
        foregroundColor: Color? = nil,
        borderColor: Color? = nil,
        borderWidth: CGFloat? = nil,
        image: Image? = nil,
        title: String? = nil
    ) -> some View {
        self
            .transformEnvironment(\.buttonSettings) { buttonSettings in
                if let type {
                    buttonSettings.type = type
                }
                
                if let font {
                    buttonSettings.font = font
                }
                
                if let backgroundColor {
                    buttonSettings.backgroundColor = backgroundColor
                }
                
                if let foregroundColor {
                    buttonSettings.foregroundColor = foregroundColor
                }
                
                if let borderColor {
                    buttonSettings.borderColor = borderColor
                }
                
                if let borderWidth {
                    buttonSettings.borderWidth = borderWidth
                }
                
                if let image {
                    buttonSettings.image = image
                }
                
                if let title {
                    buttonSettings.title = title
                }
            }
    }
    
    func buttonSettings<V>(_ keyPath: WritableKeyPath<ButtonSettings, V>, _ value: V) -> some View {
        transformEnvironment(\.buttonSettings) { rowSettings in
            rowSettings[keyPath: keyPath] = value
        }
    }
    
    func defaultButtonLayout(horizontalPadding: CGFloat? = nil,
                             verticalPadding: CGFloat? = nil,
                             cornerRadius: CGFloat? = nil,
                             alignment: HorizontalAlignment? = nil) -> some View {
        self.transformEnvironment(\.defaultButtonLayout) { defaultButtonLayout in
            if let horizontalPadding {
                defaultButtonLayout.horizontalPadding = horizontalPadding
            }
            
            if let verticalPadding {
                defaultButtonLayout.verticalPadding = verticalPadding
            }
            
            if let cornerRadius {
                defaultButtonLayout.cornerRadius = cornerRadius
            }
            
            if let alignment {
                defaultButtonLayout.alignment = alignment
            }
        }
    }
    
    func defaultButtonLayout<V>(_ keyPath: WritableKeyPath<DefaultButtonLayout, V>, _ value: V) -> some View {
        transformEnvironment(\.defaultButtonLayout) { defaultButtonSettings in
            defaultButtonSettings[keyPath: keyPath] = value
        }
    }
    
    func compactButtonLayout(size: CGFloat? = nil) -> some View {
        self
            .transformEnvironment(\.compactButtonLayout) { compactButtonLayout in
                if let size {
                    compactButtonLayout.size = size
                }
            }
    }
    
    func compactButtonLayout<V>(_ keyPath: WritableKeyPath<CompactButtonLayout, V>, _ value: V) -> some View {
        transformEnvironment(\.compactButtonLayout) { compactButtonLayout in
            compactButtonLayout[keyPath: keyPath] = value
        }
    }
    
}
