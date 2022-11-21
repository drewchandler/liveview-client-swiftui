//
//  ListRowInsetsModifier.swift
//  PhoenixLiveViewNative
//
//  Created by Shadowfacts on 9/14/22.
//

import SwiftUI

struct ListRowInsetsModifier: ViewModifier, Decodable {
    private let insets: EdgeInsets
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.insets = try container.decode(EdgeInsets.self)
    }
    
    func body(content: Content) -> some View {
        content.listRowInsets(insets)
    }
}
