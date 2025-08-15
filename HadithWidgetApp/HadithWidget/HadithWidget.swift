import WidgetKit
import SwiftUI

// Data model for each timeline entry
struct HadithEntry: TimelineEntry {
    let date: Date
    let hadithText: String
    let reference: String
}

// JSON structure from the API
struct HadithResponse: Codable {
    let data: HadithData
}

struct HadithData: Codable {
    let hadith_english: String
    let refno: String
}

// Timeline Provider
struct Provider: TimelineProvider {
    let books = ["bukhari", "muslim", "abudawud", "ibnmajah", "tirmidhi"]
    
    func placeholder(in context: Context) -> HadithEntry {
        HadithEntry(date: Date(), hadithText: "Loading Hadith...", reference: "")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (HadithEntry) -> ()) {
        let entry = HadithEntry(date: Date(), hadithText: "A Hadith will appear here.", reference: "")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<HadithEntry>) -> ()) {
        Task {
            do {
                let randomBook = books.randomElement() ?? "bukhari"
                let url = URL(string: "https://random-hadith-generator.vercel.app/\(randomBook)/")!
                
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(HadithResponse.self, from: data)
                
                // Truncate text based on widget family
                let maxLength: Int
                switch context.family {
                case .accessoryInline: maxLength = 30
                case .accessoryRectangular: maxLength = 70
                case .systemSmall: maxLength = 120
                case .systemMedium: maxLength = 250
                case .systemLarge: maxLength = 1000 // Increased for max text
                default: maxLength = 120
                }
                let truncatedText = String(response.data.hadith_english.prefix(maxLength)) + (response.data.hadith_english.count > maxLength ? "..." : "")
                
                let entry = HadithEntry(
                    date: Date(),
                    hadithText: truncatedText,
                    reference: response.data.refno
                )
                
                // Refresh every 5 minutes (system may throttle)
                let nextRefresh = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
                let timeline = Timeline(entries: [entry], policy: .after(nextRefresh))
                completion(timeline)
            } catch {
                print("API Error: \(error)")
                let entry = HadithEntry(date: Date(), hadithText: "Failed to load Hadith. Check internet.", reference: "")
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            }
        }
    }
}

// Widget Configuration
struct HadithWidget: Widget {
    let kind: String = "HadithWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HadithView(entry: entry)
        }
        .configurationDisplayName("Daily Hadith")
        .description("Displays a new Hadith on refresh.")
        .supportedFamilies([.accessoryInline, .accessoryRectangular, .systemSmall, .systemMedium, .systemLarge])
    }
}

// Widget View
struct HadithView: View {
    var entry: HadithEntry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        switch widgetFamily {
        case .accessoryInline:
            Text("\(entry.hadithText) (\(entry.reference))")
                .font(.caption2)
                .foregroundColor(.white)
                .lineLimit(1)
        case .accessoryRectangular:
            ZStack {
                Color.black.opacity(0.8)
                VStack(alignment: .leading, spacing: 1) {
                    Text(entry.hadithText)
                        .font(.caption2)
                        .foregroundColor(.white)
                        .lineLimit(5)
                    Text(entry.reference)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                .padding(4)
            }
        case .systemSmall:
            ZStack {
                Color.black.opacity(0.8)
                VStack(alignment: .leading, spacing: 3) {
                    Text("Hadith of the Day")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text(entry.hadithText)
                        .font(.caption)
                        .foregroundColor(.white)
                        .lineLimit(8)
                    Spacer()
                    Text(entry.reference)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                .padding(8)
            }
        case .systemMedium:
            ZStack {
                Color.black.opacity(0.8)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hadith of the Day")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(entry.hadithText)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .lineLimit(12)
                    Spacer()
                    Text(entry.reference)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                .padding(10)
            }
        case .systemLarge:
            ZStack {
                Color.black.opacity(0.8)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Hadith of the Day")
                        .font(.title3)
                        .foregroundColor(.white)
                    Text(entry.hadithText)
                        .font(.body) // Larger readable font
                        .foregroundColor(.white)
                        .lineLimit(25) // Max lines for full Hadith
                    Spacer()
                    Text(entry.reference)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                .padding(12)
            }
        default:
            Text("Unsupported")
        }
    }
}

// Preview Provider
struct HadithWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HadithView(entry: HadithEntry(date: Date(), hadithText: "Sample Hadith text.", reference: "Bukhari 1"))
                .previewContext(WidgetPreviewContext(family: .accessoryInline))
            HadithView(entry: HadithEntry(date: Date(), hadithText: "Sample Hadith text to test rectangular.", reference: "Bukhari 1"))
                .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            HadithView(entry: HadithEntry(date: Date(), hadithText: "Sample Hadith text for small widget.", reference: "Bukhari 1"))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            HadithView(entry: HadithEntry(date: Date(), hadithText: "Sample Hadith text for medium widget with more space.", reference: "Bukhari 1"))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            HadithView(entry: HadithEntry(date: Date(), hadithText: "Sample Hadith text for large widget with enough space to display a long Hadith text fully without truncation in most cases.", reference: "Bukhari 1"))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
