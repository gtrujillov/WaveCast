//
//  TopBarView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

struct TopBarView: View {
    
    @State private var searchText: String = ""
    var searchAction: (String) -> Void?
    
    var body: some View {
        GeometryReader { geometry in
            let topPadding: CGFloat = hasNotchOrDynamicInset() ? 80 : 60
            
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
            .padding(.top, topPadding)
            .background(.barNavy)
        }
    }
    
    func hasNotchOrDynamicInset() -> Bool {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let topInset = windowScene.windows.first?.safeAreaInsets.top ?? 0
            return topInset > 20
        }
        return false
    }
}

#Preview {
    TopBarView(searchAction: {_ in })
}
