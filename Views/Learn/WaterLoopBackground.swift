//
//  OceanLoopBackground.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/28/26.
//

import SwiftUI

struct WaterLoopBackground: View {
    let imageWidth: CGFloat = 5000
    @State private var ionsFade = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Wave(
                    imageName: "moving_water_2",
                    imageWidth: imageWidth,
                    size: geo.size,
                    duration: 30,
                    reverse: true
                )
                .offset(y: -20)

                Wave(
                    imageName: "moving_water_1",
                    imageWidth: imageWidth,
                    size: geo.size,
                    duration: 60,
                    reverse: false
                )

                ions(size: geo.size)
    
            }
        }
        .clipped()
    }
    
    private func ions(size: CGSize) -> some View {
        
        return Image("water_ions")
            .resizable()
            .frame(width: size.width, height: size.height)
            .opacity(ionsFade ? 0.05 : 0.6)
            .animation(
                .easeInOut(duration: 3).repeatForever(autoreverses: true),
                value: ionsFade
            )
            .onAppear { ionsFade = true }
    }
}

private struct Wave: View {
    let imageName: String
    let imageWidth: CGFloat
    let size: CGSize
    let duration: Double
    let reverse: Bool
    
    @State private var scroll = false

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<3, id: \.self) { _ in
                Image(imageName)
                    .resizable()
                    .frame(width: imageWidth, height: size.height)
            }
        }
        .offset(x: scroll ? -imageWidth : 0)
        .frame(width: size.width, height: size.height, alignment: .leading)
        .clipped()
        .animation(
            .linear(duration: duration).repeatForever(autoreverses: reverse),
            value: scroll
        )
        .onAppear { scroll = true }
    }
}

