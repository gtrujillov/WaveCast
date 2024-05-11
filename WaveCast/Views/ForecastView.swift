//
//  ForecastView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 13/5/24.
//

import SwiftUI

struct ForecastView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(1..<5) { index in
                    ForecastDetailView(spotTitle: .constant("Spot \(index)"))
                        .padding(.bottom, 20)
                }
                Spacer()
            }
            .padding()
            .ignoresSafeArea()
            .background(.yellowBackground)
        }
    }
}

#Preview {
    ForecastView()
}
