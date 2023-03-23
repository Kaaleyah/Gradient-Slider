//
//  ContentView.swift
//  gradientSlider Watch App
//
//  Created by Furkan Can Baytemur on 30.01.2023.
//

import SwiftUI

let colors = stride(from: 0, to: 1, by: 0.1).map {
    Color(hue: $0, saturation: 1, brightness: 1)
}

let gradient = LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)




struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(1).edgesIgnoringSafeArea(.all)
            CircleSlider()
                .offset(x: -0.5, y: -11)
                .rotationEffect(.degrees(180))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CircleSlider: View {
    @State var progress: CGFloat = 0
    @State var angle: Double = 0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 140, height: 140)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(gradient, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 140, height: 140)
                    .rotationEffect(.init(degrees: -90))
                
                Image("handle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .rotationEffect(.init(degrees: 180))
                    .offset(x: 140 / 2)
                    .rotationEffect(.init(degrees: angle))
                
                    .gesture(DragGesture().onChanged(onDrag(value: )))
                    .rotationEffect(.init(degrees: -90))
                
                VStack {
                    HStack {
                        Text("%")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                            .fontWeight(.regular)
                        
                        Text(String(format: "%.0f", progress * 100))
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .fontWeight(.regular)
                            .rotationEffect(.init(degrees: -180))
                    }
                }
            }
        }
    }
    
    
    func onDrag(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radian = atan2(vector.dy - 27.5, vector.dx - 27.5)
        
        var angle = radian * 180 / .pi
        
        if angle < 0 {
            angle = 360 + angle
        }
        
        withAnimation(Animation.linear(duration: 0.15)) {
            let progress = angle / 360
            
            self.progress = progress
            self.angle = Double(angle)
        }
    }
}
