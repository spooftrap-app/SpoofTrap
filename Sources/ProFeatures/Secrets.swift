import Foundation

struct Secrets: Codable {
    let supabaseURL: String
    let supabaseAnonKey: String

    static let shared: Secrets = {
        guard let url = Bundle.module.url(forResource: "Secrets", withExtension: "plist"),
              let data = try? Data(contentsOf: url) else {
            // No fallback: if the secrets aren't provided, the app will fail to initialize.
            // This is safer than hardcoding defaults in source.
            fatalError("Secrets.plist is missing from the bundle resources.")
        }

        do {
            let decoder = PropertyListDecoder()
            return try decoder.decode(Secrets.self, from: data)
        } catch {
            fatalError("Failed to decode Secrets.plist: \(error)")
        }
    }()
}
