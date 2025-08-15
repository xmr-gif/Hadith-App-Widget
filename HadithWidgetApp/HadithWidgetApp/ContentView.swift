import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hadith Widget App")
                .font(.title)
            Button("Refresh Widget") {
                WidgetCenter.shared.reloadAllTimelines()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
