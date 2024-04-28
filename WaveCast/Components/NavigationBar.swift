//
//  NavigationBar.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct NavigationBar: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                self.index = 0
            } label: {
                Image(systemName: "map.circle")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .padding(15)
                
            }
            .background(.iconBlue)
            .cornerRadius(15)
            
            Button {
                self.index = 1
            } label: {
                Image(systemName: "star.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .padding(15)
            }
            .background(.iconBlue)
            .cornerRadius(15)
            
            Button {
                self.index = 2
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .padding(15)
            }
            .background(.iconBlue)
            .cornerRadius(15)
            
            Button {
                self.index = 3
            } label: {
                Image(systemName: "newspaper.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .padding(15)
            }
            .background(.iconBlue)
            .cornerRadius(15)
        }
        .padding(20)
        .background(.barNavy)
        .cornerRadius(25)
    }
}

#Preview {
    NavigationBar(index: .constant(1))
}

//        VStack {
//            Spacer()
//            HStack(spacing: .zero) {
//                    ButtonView(icon: "map.circle", destination: MapView())
//
//                    ButtonView(icon: "star.fill", destination: FavouriteView())
//
//                    ButtonView(icon: "info.circle.fill", destination: LessonsView())
//
//                    ButtonView(icon: "newspaper.fill", destination: NewsView())
//            }
//            .padding(20)
//            .background(.barNavy)
//            .cornerRadius(25)
//        }
