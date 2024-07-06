//
//  EditEventView.swift
//  iDaysSince
//
//  Created by Alex Mak on 7/4/24.
//
import SwiftData
import SwiftUI

struct EditEventView: View {
    @Bindable var event: Event
    
    
    var body: some View {
        Form {
            TextField("Event", text:$event.event)
            VStack {
                DatePicker("Date", selection: $event.date, displayedComponents: .date)
            }
        }
        .navigationTitle("Edit Event")
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Event.self, configurations: config)
        let example = Event(event: "Event")
        return EditEventView(event: example).modelContainer(container)
    }
    catch  {
        fatalError("Failed to create model container")
    }
    
}
