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
        let userDefaults = UserDefaults(suiteName: "group.com.MarvelApp")
        let characters = Helper.getDatas()
        HStack(alignment: .top, spacing: 20) {
            ForEach(characters, id: \.self) { character in
                VStack() {
                    Button(character.name) {
                        
                    }
                    Image(uiImage: character.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipped()
                    Text(character.name)
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

struct Helper {
    static func getTitles() -> [String] {
        var titles: [String] = []
        
        let userDefaults = UserDefaults(suiteName: "group.com.MarvelApp")
        
        for iten in 0..<3 {
            let newString = userDefaults?.string(forKey: "name\(iten)") ?? "Não achei valor"
            titles.append(newString)
        }
        
        return titles
    }
    
    static func getDatas() -> [CharacterWidget] {
        let userDefaults = UserDefaults(suiteName: "group.com.MarvelApp")
        var result: [CharacterWidget] = []
        
        for iten in 0..<3 {
            let name = userDefaults?.string(forKey: "name\(iten)") ?? "Não achei valor"
            let imageData = userDefaults?.data(forKey: "image\(iten)") ?? Data()
            let image = UIImage(data: imageData) ?? UIImage()
            let character = CharacterWidget(name: name, image: image)
            result.append(character)
        }
        
        
        
        return result
    }
}

struct CharacterWidget: Hashable {
    let name: String
    let image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
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
  
        
//        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.MarvelApp")?.appendingPathComponent("hello")
//                let data = try! Data(contentsOf: url!)
//                let txt = String(data: data, encoding: .utf8) ?? "Não achei valor"
        
       // print(userDefaults?.string(forKey: "456"))
        
        MarvelWidgetEntryView(entry: SimpleEntry(date: Date(), title: "lol"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

