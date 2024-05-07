//
//  ForecastDetailView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct ForecastDetailView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                CustomNavigationBar()
                    .padding(10)
            }
        }
    }
}

#Preview {
    ForecastDetailView()
}
