//
//  TopBarView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

struct TopBarView: View {
    
    @State private var searchText: String = ""
    var searchAction: (String) -> Void
    var title: String
    
    var body: some View {
        VStack(spacing: 0) {
            if hasNotchOrDynamicInset() {
                // Si hay notch o isla dinámica, coloca el título en la esquina izquierda
                HStack(spacing: 0) {
                    Text(title)
                        .padding([.leading, .top], 25)
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Spacer()
                }
            } else {
                // Si no hay notch ni isla dinámica, coloca el título en el centro superior
                Text(title)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            
            HStack(spacing: 0) {
                Image(.iconAppOriginal)
                    .resizable()
                    .frame(width: 86, height: 86)
                TextField("Buscar", text: $searchText)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .cornerRadius(25)
                Button(action: {
                    searchAction(searchText)
                }) {
                    Text("Buscar")
                        .padding(15)
                        .foregroundColor(.white)
                }
            }
        }
        .background(.barNavy)
        .clipShape(
            RoundedCorner(cornerRadius: 25, corners: [.bottomLeft, .bottomRight])
        )
        .edgesIgnoringSafeArea(.top)
        Spacer()
    }
    
    // Función para detectar si el dispositivo tiene notch o isla dinámica
    func hasNotchOrDynamicInset() -> Bool {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let topInset = windowScene.windows.first?.safeAreaInsets.top ?? 0
            return topInset > 20 
        }
        return false
    }
}

#Preview {
    TopBarView(searchAction: {_ in }, title: "Mapa")
}
