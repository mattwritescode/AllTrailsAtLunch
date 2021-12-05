//
//  BoxStyle.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/4/21.
//

import Foundation
import SwiftUI

struct BoxStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .border(Color(white: 230.0/255.0), width: 1.0)
      .shadow(color: Color(white: 0.0, opacity: 0.1), radius: 2.0, x: 0.0, y: 1.0)
      .cornerRadius(6)
  }
}

extension View {
  func boxStyle() -> some View {
    return modifier(BoxStyle())
  }
}
