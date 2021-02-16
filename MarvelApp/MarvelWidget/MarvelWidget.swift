//
//  MarvelWidget.swift
//  MarvelWidget
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), characters: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), characters: [])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let characters: [CharacterWidget]
}

struct MarvelWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            ForEach(Helper.getDatas(), id: \.self) { character in
                VStack() {
                    Image(uiImage: character.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipped()
                    Text(character.name)
                }
            }
        }
    }
}

@main
struct MarvelWidget: Widget {
    let kind: String = "Marvel Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MarvelWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(kind)
        .description("")
    }
}

struct MarvelWidget_Previews: PreviewProvider {
    static var previews: some View {
        MarvelWidgetEntryView(entry: SimpleEntry(date: Date(), characters: Helper.getDatas()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

