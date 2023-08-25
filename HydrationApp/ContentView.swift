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
    var images: [String] = ["cups1-3", "cups4-6", "cups7-8"]
    @State var waterLevel: String = "cups1-3"
    var plus: Image = Image("plus")
    var minus: Image = Image("minus")
    @State var name: String = ""
    @State var reportDate: String = ""
    var body: some View {
        VStack {
            List {
                ForEach(waterDrank) { water in
                    Text(String(water.waterGlasses))
                    Text(water.name ?? "Unknown")
                }
                .onDelete(perform: removeData)
            }
            Button ("ADDDAWATERYAY:)") {
                let waterConsumed = WaterDrank(context: moc) // Instance of Core Data Entity
                
                waterConsumed.waterGlasses = Int16(cupsOfWater) // Adds data
                waterConsumed.reportDate = reportDate
                try? moc.save() // Tries to save data
                
            }
            Text("Date")
            TextField("Weight", text: $weight)
                .multilineTextAlignment(.center)
            TextField("Name", text: $name)
                .multilineTextAlignment(.center)
            HStack {
                TextField("mmddyyyy", text: $reportDate)
            }
            .multilineTextAlignment(.center)
            Button ("Set Goal") {
                goal = Double(weight)! / 16
            }
            Text("Goal : " + String(goal))
            HStack {
                Button {
                    if cupsOfWater > 0 {
                        cupsOfWater -= 1
                        water = String(cupsOfWater)
                    }
                    if cupsOfWater >= goal / 2 && cupsOfWater <= goal * (2 / 3) {
                        waterLevel = images[1]
                    }
                    else if cupsOfWater < goal / 2 {
                        waterLevel = images[0]
                    }
                } label: {
                    Image("plus")
                        .resizable()
                        .frame(width: 75, height: 75)
                }
                Image(waterLevel)
                    .resizable()
                    .frame(width: 200, height: 200)
                Button {
                    if cupsOfWater < goal {
                        cupsOfWater += 1
                        water = String(cupsOfWater)
                    }
                    if cupsOfWater >= goal / 2 && cupsOfWater <= goal * (2 / 3) {
                        waterLevel = images[1]
                    }
                    else if cupsOfWater >= goal * (7 / 8) {
                        waterLevel = images[2]
                    }
                } label: {
                    Image("minus")
                        .resizable()
                        .frame(width: 75, height: 75)
                }
            }
            Chart {
                ForEach (waterDrank) { water in
                    BarMark(x: .value("Date", water.reportDate ?? "00/00/0000"), y: .value("WaterDrank", water.waterGlasses))
                }
            }
        }
        Text("Water so far : \(cupsOfWater)")
        .padding()
    }
    
    func removeData(at offsets: IndexSet) {
        for index in offsets {
            let data = waterDrank[index]
            moc.delete(data)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
