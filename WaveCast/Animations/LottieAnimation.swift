//
//  LottieBootCamp.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 21/5/24.
//

import SwiftUI
import Lottie

struct LottieAnimation: View {
    var body: some View {
        LottieView(animation: .named("mapAnimation.json"))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            .animationSpeed(2)
            .frame(width: 50,height: 50)
    }
}

#Preview {
    LottieAnimation()
}
