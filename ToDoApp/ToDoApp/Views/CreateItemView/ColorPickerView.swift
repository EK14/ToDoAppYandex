//
//  ColorPicker.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 28.06.2024.
//

import SwiftUI

struct ColorPickerView: View {
    
    let radius: CGFloat = 150
    var diameter: CGFloat {
        radius * 2
    }
    
    @State private var startLocation: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    @State private var location: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    @Binding var color: Color
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    AngularGradient.init(gradient: Gradient(colors: [
                        Color(hue: 1.0, saturation: 1, brightness: 0.9),
                        Color(hue: 0.9, saturation: 1, brightness: 0.9),
                        Color(hue: 0.8, saturation: 1, brightness: 0.9),
                        Color(hue: 0.7, saturation: 1, brightness: 0.9),
                        Color(hue: 0.6, saturation: 1, brightness: 0.9),
                        Color(hue: 0.5, saturation: 1, brightness: 0.9),
                        Color(hue: 0.4, saturation: 1, brightness: 0.9),
                        Color(hue: 0.3, saturation: 1, brightness: 0.9),
                        Color(hue: 0.2, saturation: 1, brightness: 0.9),
                        Color(hue: 0.1, saturation: 1, brightness: 0.9),
                        Color(hue: 0.0, saturation: 1, brightness: 0.9)
                    ]), center: .center)
                )
                .frame(width: diameter, height: diameter)
                .overlay(
                    Circle()
                        .fill(
                            RadialGradient(gradient: Gradient(colors: [
                                Color.white,
                                Color.white.opacity(0.000001)
                            ]), center: .center, startRadius: 0, endRadius: radius)
                        )
                )
                .position(startLocation)
                .shadow(color: Color.black.opacity(0.1), radius: 6, y: 8)
            
            Circle()
                .frame(width: 50, height: 50)
                .position(location)
                .foregroundColor(.black)
            
            VStack {
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Выбрать цвет")
                        .padding(.all, 20)
                        .frame(maxWidth: .infinity)
                        .background(AngularGradient.init(gradient: Gradient(colors: [
                            Color(hue: 1.0, saturation: 1, brightness: 0.9),
                            Color(hue: 0.9, saturation: 1, brightness: 0.9),
                            Color(hue: 0.8, saturation: 1, brightness: 0.9),
                            Color(hue: 0.7, saturation: 1, brightness: 0.9),
                            Color(hue: 0.6, saturation: 1, brightness: 0.9),
                            Color(hue: 0.5, saturation: 1, brightness: 0.9),
                            Color(hue: 0.4, saturation: 1, brightness: 0.9),
                            Color(hue: 0.3, saturation: 1, brightness: 0.9),
                            Color(hue: 0.2, saturation: 1, brightness: 0.9),
                            Color(hue: 0.1, saturation: 1, brightness: 0.9),
                            Color(hue: 0.0, saturation: 1, brightness: 0.9)
                        ]), center: .center))
                        .cornerRadius(16)
                        .padding(.all, 20)
                        .foregroundStyle(.white)
                        .font(.headline)
                }

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(color)
        .gesture(dragGesture)
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { val in
                let distanceX = val.location.x - startLocation.x
                let distanceY = val.location.y - startLocation.y
                
                let dir = CGPoint(x: distanceX, y: distanceY)
                var distance = sqrt(distanceX * distanceX + distanceY * distanceY)
                
                if distance < radius {
                    location = val.location
                } else {
                    let clampedX = dir.x / distance * radius
                    let clampedY = dir.y / distance * radius
                    location = CGPoint(x: startLocation.x + clampedX,
                                       y: startLocation.y + clampedY)
                    distance = radius
                }
                
                if distance == 0 { return }
                
                var angle = Angle(radians: -Double(atan(dir.y / dir.x)))
                
                if dir.x < 0 {
                    angle.degrees += 180
                } else if dir.x > 0 && dir.y > 0 {
                    angle.degrees += 360
                }
                
                let hue = angle.degrees / 360
                let saturation = Double(distance / radius)
                color = Color(hue: hue, saturation: saturation, brightness: 0.7)
                
            }
    }
}

#Preview {
    @State var color = Color.pink
    return ColorPickerView(color: $color)
}
