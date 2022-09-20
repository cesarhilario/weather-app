//
//  Toast.swift
//  WeatherIOS
//
//  Created by Cesar Hilario on 05/08/22.
//

import Foundation
import SwiftUI

struct Toast: ViewModifier {
    static let short: TimeInterval = 2;
    static let long: TimeInterval = 3.5;
    
    let message: String;
    let config: Config;
    @Binding var isShowing: Bool;
    
    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
    
    private var toastView: some View {
        VStack {
            Spacer();
            
            if isShowing {
                Group {
                    Text(message)
                        .multilineTextAlignment(.center)
                        .foregroundColor(config.textColor)
                        .font(config.font)
                        .padding(8)
                }
                .background(config.backgroundColor)
                .cornerRadius(8)
                .onTapGesture {
                    isShowing = false
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        isShowing = false
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 40)
        .animation(config.animation, value: isShowing)
        .transition(config.transition)
    }
    
    struct Config {
        let textColor: Color;
        let font: Font;
        let backgroundColor: Color;
        let duration: TimeInterval;
        let transition: AnyTransition;
        let animation: Animation;
        
        init(
            textColor: Color = .white,
            font: Font = .system(size: 14),
            backgroundColor: Color = .black.opacity(0.588),
            duration: TimeInterval = Toast.short,
            transition: AnyTransition = .opacity,
            animation: Animation = .linear
        ) {
            self.textColor = textColor;
            self.font = font;
            self.backgroundColor = backgroundColor;
            self.duration = duration;
            self.transition = transition;
            self.animation = animation;
        }
    }
}

extension View {
    func toast(message: String,
               isShowing: Binding<Bool>,
               config: Toast.Config) -> some View {
        self.modifier(Toast(message: message, config: config, isShowing: isShowing))
    }
    
    func toast(message: String, isShowing: Binding<Bool>, duration: TimeInterval) -> some View {
        self.modifier(Toast(message: message, config: .init(duration: duration), isShowing: isShowing))
    }
}


