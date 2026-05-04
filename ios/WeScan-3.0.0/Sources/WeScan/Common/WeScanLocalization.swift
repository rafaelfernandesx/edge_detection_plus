import Foundation

enum WeScanLocalization {
    private static let resourceDirectories = ["Resources/Localisation", nil]
    private static let fallbackLocalizations = ["pt-BR", "pt-PT", "en"]

    static func string(_ key: String, value: String, comment: String) -> String {
        guard let bundle = localizationBundle else {
            return value
        }

        return bundle.localizedString(forKey: key, value: value, table: nil)
    }

    private static var localizationBundle: Bundle? = {
        let baseBundle = Bundle(for: ScannerViewController.self)
        let preferred = Locale.preferredLanguages.flatMap(localizationCandidates)
        let candidates = unique(preferred + fallbackLocalizations)

        for localization in candidates {
            for directory in resourceDirectories {
                if let path = baseBundle.path(forResource: localization, ofType: "lproj", inDirectory: directory),
                   let bundle = Bundle(path: path) {
                    return bundle
                }
            }
        }

        return nil
    }()

    private static func localizationCandidates(for identifier: String) -> [String] {
        let normalized = identifier.replacingOccurrences(of: "_", with: "-")
        let parts = normalized.split(separator: "-")
        guard let languageCode = parts.first, !languageCode.isEmpty else {
            return [normalized]
        }

        var candidates = [normalized]
        if parts.count > 1 {
            candidates.append(String(languageCode))
        }

        if languageCode.lowercased() == "pt" {
            candidates.append(contentsOf: ["pt-BR", "pt-PT"])
        }

        return candidates
    }

    private static func unique(_ values: [String]) -> [String] {
        var seen = Set<String>()

        return values.filter { value in
            seen.insert(value).inserted
        }
    }
}