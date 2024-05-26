//
//  TabBarView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

// MARK: - TabBarView
struct TabBarView: View {
    
    // MARK: Properties
    
    // Icon names for tab bar buttons
    let icons = [
        "mappin.circle",
        "star.circle",
        "book.circle"
    ]
    
    // Titles for tab bar buttons
    let titles = [
        "Mapa",
        "Favoritos",
        "Lecciones"
    ]
    
    @Binding var indexSelected: Int
    // Array to track selection state
    @State private var isSelected: [Bool] = [false, false, false]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                ForEach(0..<icons.count, id: \.self) { index in
                    Spacer()
                    ButtonView(
                        icon: icons[index],
                        title: titles[index],
                        action: { self.selectButton(at: index) },
                        isSelected: self.isSelected[index]
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
    
    // MARK: Private Methods
    
    // Selects the button at the given index
    private func selectButton(at index: Int) {
        isSelected = Array(repeating: false, count: isSelected.count)
        isSelected[index] = true
        self.indexSelected = index
    }
}

#Preview {
    TabBarView(indexSelected: .constant(0))
}
