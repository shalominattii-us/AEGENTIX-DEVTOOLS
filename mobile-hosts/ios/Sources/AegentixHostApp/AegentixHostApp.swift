import SwiftUI
import AegentixMobileHost

@main
struct AegentixHostApp: App {
    @State private var endpoint = UserDefaults.standard.string(forKey: "coreEndpoint") ?? "https://localhost:8080/"

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Form {
                    Section("AEGENTIS CORE") {
                        TextField("CORE endpoint", text: $endpoint)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                        Button("Save") { UserDefaults.standard.set(endpoint, forKey: "coreEndpoint") }
                    }
                    Section("Node") {
                        Text("AEGENTIX iOS Host")
                        Text("Native iOS security remains authoritative.")
                            .font(.caption)
                    }
                }
                .navigationTitle("AEGENTIX Host")
            }
        }
    }
}
