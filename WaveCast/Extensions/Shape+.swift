//
//  Shape+.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import Foundation
import SwiftUI

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

extension Shape {
    func roundedCorner(cornerRadius: CGFloat, corners: UIRectCorner) -> some Shape {
        RoundedCorner(cornerRadius: cornerRadius, corners: corners)
    }
}
