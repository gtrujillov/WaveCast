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
        "star.circle",
        "book.circle"
    ]
    
    let titulos = [
        "Mapa",
        "Favoritos",
        "Lecciones"
    ]
    
    @Binding var indexSelected: Int
    @State private var isSelected: [Bool] = [false, false, false]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                ForEach(0..<iconos.count, id: \.self) { numbers in
                    Spacer()
                    ButtonView(
                        icon: iconos[numbers],
                        title: titulos[numbers],
                        action: { self.selectButton(at: numbers) },
                        isSelected: self.isSelected[numbers]
                    )
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
    
    private func selectButton(at index: Int) {
        isSelected = Array(repeating: false, count: isSelected.count)
        isSelected[index] = true
        self.indexSelected = index
    }
}


#Preview {
    TabBarView(indexSelected: .constant(0))
}
