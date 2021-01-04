//
//  Weather_Widget.swift
//  Weather Widget
//
//  Created by Makzan on 28/12/2020.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), weather: Weather())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), weather: Weather())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        WeatherService().fetchCurrentWeather { (weather) in
            print(weather)
            let entry = SimpleEntry(date: Date(), weather: weather)
            
            
            let currentDate = Date()
            let expiryDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
            let timeline = Timeline(entries: [entry], policy: .after(expiryDate))
            completion(timeline)
        }
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let weather: Weather
}

struct Weather_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: StatusCode.symbolFor(statusCode: entry.weather.statusCode))
                .font(.largeTitle)
            Text("\(entry.weather.temperature)℃")
                .font(.title)
            Text(entry.weather.date)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
}

@main
struct Weather_Widget: Widget {
    let kind: String = "Weather_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Weather_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Weather_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Weather_WidgetEntryView(entry: SimpleEntry(date: Date(), weather: Weather(date:"2020-12-29 12:00", temperature: "12", statusCode:"a2")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

