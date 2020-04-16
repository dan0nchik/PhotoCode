//
//  Lottie.swift
//  PhotoCode
//
//  Created by Daniel Khromov on 4/15/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI
import Lottie
struct Lottie: View {
    var body: some View {
        AnimationsView()
        .frame(width: 10, height: 10)
    }
}

struct Lottie_Previews: PreviewProvider {
    static var previews: some View {
        Lottie()
    }
}

struct AnimationsView : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<AnimationsView>) -> AnimationView{
        let aniView = AnimationView()
        let animation = Animation.named("coder")
        aniView.animation = animation
        aniView.loopMode = .loop
        aniView.play()
        return aniView
    }
    func updateUIView(_ uiView: AnimationView, context: UIViewRepresentableContext<AnimationsView>) {
        
    }
}
