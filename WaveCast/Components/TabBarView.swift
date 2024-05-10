//
//  TabBarView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

struct TabBarView: View {
    
    let iconos = [
        "map.circle",
        "star.fill",
        "info.circle.fill",
        "newspaper.fill"
    ]
    
    @Binding var indexSelected: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                ForEach(0..<iconos.count, id: \.self) { numbers in
                    Spacer()
                    ButtonView(icon: iconos[numbers]) {
                        self.indexSelected = numbers
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
            .background(.barNavy)
            .clipShape(
                RoundedCorner(cornerRadius: 25, corners: [.topLeft, .topRight])
            )
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct RoundedCorner: Shape {
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    TabBarView(indexSelected: .constant(0))
}
