//
//  AnalogClockView.swift
//  AnalogClock
//
//  Created by Paresh Patel on 05/01/25.
//

import SwiftUI

struct AnalogClockView: View {
    var body: some View {
        TimelineView(.animation) { context in
            let date = context.date
            let calendar = Calendar.current
            
            let seconds = Double(calendar.component(.second, from: date)) + Double(calendar.component(.nanosecond, from: date)) / 1_000_000_000
            let minutes = Double(calendar.component(.minute, from: date))
            let hours = Double(calendar.component(.hour, from: date) % 12)
            
            GeometryReader { geo in
                let size = min(geo.size.width, geo.size.height)
                let radius = size / 2
                let hourLength = radius * 0.5
                let minuteLength = radius * 0.7
                let secondLength = radius * 0.8
                
                ZStack {
                    Circle().stroke(lineWidth: 4)
                    
                    // Numerals
                    ForEach(1...12, id: \.self) { number in
                        let angle = Double(number) * 30
                        Text("\(number)")
                            .font(.headline)
                            .rotationEffect(.degrees(-angle))
                            .offset(y: -(radius - 28))
                            .rotationEffect(.degrees(angle))
                    }
                    
                    // Hour ticks
                    ForEach(0..<12) { tick in
                        Rectangle()
                            .frame(width: 3, height: 10)
                            .offset(y: -(radius - 12))
                            .rotationEffect(.degrees(Double(tick) * 30))
                    }
                    
                    // Minute ticks
                    ForEach(0..<60) { tick in
                        Rectangle()
                            .frame(width: 1, height: 6)
                            .offset(y: -(radius - 6))
                            .rotationEffect(.degrees(Double(tick) * 6))
                    }
                    
                    // Hour hand
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 5, height: hourLength)
                        .offset(y: -hourLength / 2)
                        .rotationEffect(.degrees(hours * 30 + minutes * 0.5))
                    
                    // Minute hand
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 3, height: minuteLength)
                        .offset(y: -minuteLength / 2)
                        .rotationEffect(.degrees(minutes * 6 + seconds * 0.1))
                    
                    // Second hand
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 2, height: secondLength)
                        .offset(y: -secondLength / 2)
                        .rotationEffect(.degrees(seconds * 6))
                    
                    // Center pivot
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 10, height: 10)
                }
            }
            .frame(width: 200, height: 200)
        }
    }
}


#Preview {
    AnalogClockView()
}

