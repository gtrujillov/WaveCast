//
//  TabBarView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

struct TabBarView: View {
    
    let iconos = [
        "mappin.circle",
        "magnifyingglass.circle",
        "star.circle",
        "book.circle",
        "info.circle"
    ]
    
    @Binding var indexSelected: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                ForEach(0..<iconos.count, id: \.self) { numbers in
                    Spacer()
                    ButtonView(icon: iconos[numbers]) {
                        self.indexSelected = numbers
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 20)
            .background(.barNavy)
            .clipShape(
                RoundedCorner(cornerRadius: 25, corners: .allCorners)
            )
        }
        .padding(5)
    }
}

#Preview {
    TabBarView(indexSelected: .constant(0))
}
