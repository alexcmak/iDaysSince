//
//  ContentView.swift
//  iDaysSince
//
//  Created by Alex Mak on 7/4/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Event]()  // why path
    @State private var sortOrder = SortDescriptor(\Event.event)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            EventListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("iDaysSince")
                .navigationDestination(for:Event.self, destination: EditEventView.init)
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Event", systemImage:"plus", action: addEvent)
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Event").tag(SortDescriptor(\Event.event))
                            Text("Date").tag(SortDescriptor(\Event.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addEvent() {
        let event = Event()
        modelContext.insert(event)
        path = [event]
    }
    
}

#Preview {
    ContentView()
}
