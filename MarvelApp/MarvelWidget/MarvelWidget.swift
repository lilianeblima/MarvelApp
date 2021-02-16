//
//  MarvelWidget.swift
//  MarvelWidget
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import WidgetKit
import SwiftUI

//
//struct CharacterEntry: TimelineEntry {
//    var date: Date
//    let character: Character
//
//}
//
//struct Provider: TimelineProvider {
//    typealias Entry = CharacterEntry
//
//    func placeholder(in context: Context) -> CharacterEntry {
//        <#code#>
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (CharacterEntry) -> Void) {
//        <#code#>
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<CharacterEntry>) -> Void) {
//        <#code#>
//    }
//
//}

//@AppStorage("marvelApp", store: UserDefaults(suiteName: "group.com.MarvelApp"))
struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "Lili")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: "Lili")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
}

struct MarvelWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        let strings = [entry.title]
//        ZStack {
//            Text("Hello World")
//            Text("This is inside a stack")
//        }
        HStack(alignment: .top, spacing: 20) {
            ForEach(strings, id: \.self) { value in
                VStack() {
                    Image(uiImage: UIImage(named: "tabbarFavoriteSelected")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipped()
                    Text(value)
                }
                
                //Spacer()
            }
        }
        
//        VStack(alignment: .leading) {
//            let strings = ["Lili", "Linda", "Bela"]
//            ForEach(strings, id: \.self) { value in
//                VStack {
//                    HStack {
//                        RoundedRectangle(cornerRadius: 1)
//                            .fill(Color.red)
//                            .frame(width: 2, height: 34, alignment: .leading)
//                        Text(value)
//
//                        VStack(alignment: .leading) {
//                            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
//                        }
//                    }
//                }
//            }
//        }
    }
}

@main
struct MarvelWidget: Widget {
    let kind: String = "MarvelWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MarvelWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MarvelWidget_Previews: PreviewProvider {
    static var previews: some View {
        let userDefaults = UserDefaults()
        let txt = userDefaults.string(forKey: "123") ?? "Não achei valor"
        MarvelWidgetEntryView(entry: SimpleEntry(date: Date(), title: txt))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

