//
//  EventListingView.swift
//  iDaysSince
//
//  Created by Alex Mak on 7/4/24.
//
import SwiftData
import SwiftUI

struct EventListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Event.date, order: .reverse), SortDescriptor(\Event.event)]) var events: [Event]
  
    
    var body: some View {
       
        List {
          
            ForEach(events) { event in
                NavigationLink(value: event) {
                    VStack(alignment: .leading) {
                        Text(event.event).font(.headline)
                        Text(getDaysSince(Date: event.date))
                    }
                }
                
            }
            .onDelete(perform: deleteEvents)
        }
    }
    
    init(sort:SortDescriptor<Event>, searchString: String) {
        _events = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            }
            else
            {
                return $0.event.localizedStandardContains(searchString)
            }
        }, sort:[sort])
    }
    func deleteEvents(_ indexSet: IndexSet){
        for index in indexSet {
            let event = events[index]
            modelContext.delete(event)
        }
    }
    
    // horrific complexity to do a simplistic count of how many days between two dates
    func numerOfDaysBetween(firstDate : Date, secondDate: Date)->Int {
        let calendar = Calendar.current
        guard let days = calendar.dateComponents([.day],from: calendar.startOfDay(for: firstDate),
                                                     to: calendar.startOfDay(for: secondDate)).day 
        else {
              return 0
        }
        
        return days
    }
    
    // a Date always have a date and time part
    // to just get the date, need a date formatter
    func getDaysSince(Date: Date) ->String {
        let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.none;
            dateFormatter.dateStyle = DateFormatter.Style.medium
        
        let days = numerOfDaysBetween(firstDate: .now, secondDate: Date)
        var description = "days"
       
        switch (days)
        {
        case 0:
            description = "is today"
        case _ where days < 0:
            description = "was " + String(abs(days)) + " days ago"
        case _ where days > 0:
            description = "is " + String(days) + " days in future"
        default:
            description = ""
        }
                    
        
        let date_only = dateFormatter.string(from: Date)
        let msg = date_only + " " + description
        
        return msg
    }
    
}

#Preview {
    EventListingView(sort: SortDescriptor(\Event.event), searchString:"")
}
