//
//  ContentView.swift
//  HydrationApp
//
//  Created by Rohan on 8/20/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc // Allows access to the managed object context
    @FetchRequest(sortDescriptors: [/*No sorting*/]) var waterDrank: FetchedResults<WaterDrank> // Fetches data from the Core Data Model
    @State private var water = "0"
    @State private var cupsOfWater: Double = 0
    @State var weight = "0"
    @State var goal: Double = 8
    @State var waterLevel: String = "cup0"
    var plus: Image = Image("plus")
    var minus: Image = Image("minus")
    @State var name: String = ""
    @State var reportDate: String = ""
    @State var date = Date()
    @State var usedDates: [String] = []
    var images: [String] = ["cup0", "cup1", "cup2", "cup3", "cup4", "cup5", "cup6", "cup7", "cup8"]
    @State var totalCups: Double = 0.0
    @State var averageCups: Double = 0.0
    @State var amountDays: Int = 0
    enum graphType {
        case day
        case month
        case year
        case fullDate
    }
    @State var graph = graphType.day
    var body: some View {
//        List {
//            ForEach(waterDrank) { water in
//                Text(water.reportDate ?? "")
//            }
//        }
        ScrollView {
            VStack {
                Button ("ADDDAWATERYAY:)") {
                    let waterConsumed = WaterDrank(context: moc) // Instance ofe Core Data Entity
                    waterConsumed.waterGlasses = Int16(cupsOfWater) // Adds data
                    waterConsumed.reportDate = formatDateToString(randomDate(), graph: .fullDate)
                    waterConsumed.totalGlasses = totalCups
                    waterConsumed.totalDays = Int16(amountDays)
                    try? moc.save() // Tries to save data
                    totalCups += cupsOfWater
                    if !usedDates.contains(waterConsumed.reportDate!) {
                        usedDates.append(waterConsumed.reportDate!)
                        amountDays += 1
                    }
                    averageCups = waterConsumed.totalGlasses / Double(waterConsumed.totalDays)
                }
                Text("Goal : " + String(goal))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .padding()
                HStack {
                    Button {
                        if cupsOfWater > 0 {
                            cupsOfWater -= 1
                            water = String(cupsOfWater)
                        }
                        if cupsOfWater == 0 {
                            waterLevel = images[0]
                        }
                        else if cupsOfWater == 1 {
                            waterLevel = images[1]
                        }
                        else if cupsOfWater == 2 {
                            waterLevel = images[2]
                        }
                        else if cupsOfWater == 3 {
                            waterLevel = images[3]
                        }
                        else if cupsOfWater == 4 {
                            waterLevel = images[4]
                        }
                        else if cupsOfWater == 5 {
                            waterLevel = images[5]
                        }
                        else if cupsOfWater == 6 {
                            waterLevel = images[6]
                        }
                        else if cupsOfWater == 7 {
                            waterLevel = images[7]
                        }
                        else if cupsOfWater == 8 {
                            waterLevel = images[8]
                        }
                    } label: {
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 40, height: 40)
                    }
                    Image(waterLevel)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Button {
                        if cupsOfWater < goal {
                            cupsOfWater += 1
                            water = String(cupsOfWater)
                        }
                        if cupsOfWater == 0 {
                            waterLevel = images[0]
                        }
                        else if cupsOfWater == 1 {
                            waterLevel = images[1]
                        }
                        else if cupsOfWater == 2 {
                            waterLevel = images[2]
                        }
                        else if cupsOfWater == 3 {
                            waterLevel = images[3]
                        }
                        else if cupsOfWater == 4 {
                            waterLevel = images[4]
                        }
                        else if cupsOfWater == 5 {
                            waterLevel = images[5]
                        }
                        else if cupsOfWater == 6 {
                            waterLevel = images[6]
                        }
                        else if cupsOfWater == 7 {
                            waterLevel = images[7]
                        }
                        else if cupsOfWater == 8 {
                            waterLevel = images[8]
                        }
                    } label: {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 40, height: 40)
                    }
                }
            }
            if graph == .year {
                Chart {
                    ForEach (waterDrank) { water in
                        BarMark(x: .value("Date", formatDateToString(formatStringToDate(from: water.reportDate ?? "", graph: .year) ?? Date(), graph: .year)), y: .value("WaterDrank", water.waterGlasses))
                    }
                }
            }
            else if graph == .month {
                Chart {
                    ForEach (waterDrank) { water in
                        BarMark(x: .value("Date", formatDateToString(formatStringToDate(from: water.reportDate ?? "", graph: .month) ?? Date(), graph: .month)), y: .value("WaterDrank", water.waterGlasses))
                    }
                }
            }
            else {
                Chart {
                    ForEach (waterDrank) { water in
                        BarMark(x: .value("Date", formatDateToString(formatStringToDate(from: water.reportDate ?? "", graph: .day) ?? Date(), graph: .day)), y: .value("WaterDrank", water.waterGlasses))
                    }
                }
            }
            Text("Water so far : \(cupsOfWater)")
            HStack {
                Button("Day") {
                    graph = .day
                }
                Button("Month") {
                    graph = .month
                }
                Button("Year") {
                    graph = .year
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
    }
    
    func removeData(at offsets: IndexSet) {
        for index in offsets {
            let data = waterDrank[index]
            moc.delete(data)
        }
    }
    
    func formatDateToString(_ date: Date, graph: graphType) -> String {
        let dateFormatter = DateFormatter()
        if graph == .year {
            dateFormatter.dateFormat = "MM" // month name
        }
        else if graph == .month {
            dateFormatter.dateFormat = "dd" // day in number
        }
        else if graph == .day {
            dateFormatter.dateFormat = "EEEE" // day in name
        }
        else {
            dateFormatter.dateFormat = "yyyy-MM-dd" // full date
        }
        return dateFormatter.string(from: date)
    }
    
    func formatStringToDate(from dateString: String, graph: graphType) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // full date
        return dateFormatter.date(from: dateString)
    }
    
    func randomDate() -> Date {
        let randomTimeInterval = TimeInterval.random(in: 0...(60 * 60 * 24 * 365)) // Random time within a year
        let currentDate = Date()
        let randomDate = currentDate.addingTimeInterval(randomTimeInterval)
        return randomDate
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
