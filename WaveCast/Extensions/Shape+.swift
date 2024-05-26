//
//  Shape+.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import Foundation
import SwiftUI

// MARK: - RoundedCorner
struct RoundedCorner: Shape {
    
    // MARK: Properties
    // Radius of the corner
    var cornerRadius: CGFloat
    // Specific corners to round
    var corners: UIRectCorner
    
    // MARK: Path
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Shape Extension
extension Shape {
    
    // Creates a shape with rounded corners
    func roundedCorner(cornerRadius: CGFloat, corners: UIRectCorner) -> some Shape {
        RoundedCorner(cornerRadius: cornerRadius, corners: corners)
    }
}
