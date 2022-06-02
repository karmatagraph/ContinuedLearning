//
//  MaskBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/2/22.
//

import SwiftUI

struct MaskBootcamp: View {
    @State var rating: Int = 0
    
    var body: some View {
        ZStack {
            starView
                .overlay(overlayView.mask(starView))
        }
    }
    
    private var overlayView: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(
                        width:CGFloat(rating) / 5 * proxy.size.width )
//                        .mask(starView)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starView: some View {
        HStack {
            ForEach(1..<6){ index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                rating = index
                            }

                        }
            }
            
        }
    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
