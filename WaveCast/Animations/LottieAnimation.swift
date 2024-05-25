//
//  LottieBootCamp.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 21/5/24.
//

import SwiftUI
import Lottie

struct LottieAnimation: View {
    
    @State var lottieAnimationName: String
    
    var body: some View {
        LottieView(animation: .named(lottieAnimationName))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            .animationSpeed(2)
            .frame(width: 60,height: 60)
    }
}

#Preview {
    LottieAnimation(lottieAnimationName: "mapAnimation.json")
}
