//
//  MyVStack.swift
//  SyncHubMeeting3SwiftUIDemoApp
//
//  Created by Carson_Nov_2025 on 2/12/26.
//

import SwiftUI

struct MyVStack: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let idealSizes = subviews.map { subview in
            subview.sizeThatFits(.unspecified)
        }
        
        // figure out the total width for us
        let width: CGFloat = idealSizes.reduce(.zero) { partialResult, size in
            max(partialResult, size.width)
        }
        
        // figure out the total height for us
        let height: CGFloat = idealSizes.reduce(.zero) { partialResult, size in
            partialResult + size.height
        }
        
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var offsetY: CGFloat = .zero
        
        for subview in subviews {
            subview.place(at: .init(x: bounds.minX, y: bounds.minY + offsetY), anchor: .topLeading, proposal: .unspecified)
            offsetY += subview.sizeThatFits(.unspecified).height
        }
    }
    
    
}
