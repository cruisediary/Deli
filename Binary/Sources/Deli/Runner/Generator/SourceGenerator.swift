//
//  SourceGenerator.swift
//  Deli
//

import Foundation

final class SourceGenerator: Generator {

    // MARK: - Public

    func generate() throws -> String {
        let sourceList: [String]
        #if swift(>=4.1)
        sourceList = results.compactMap { $0.makeSource() }
        #else
        sourceList = results.flatMap { $0.makeSource() }
        #endif
        
        let output = sourceList
            .joined(separator: "\n")
            .replacingOccurrences(of: "\n", with: "\n        ")

        return """
        //
        //  Deli Factory
        //  Auto generated code.
        //

        import Deli

        final class DeliFactory: ModuleFactory {
            func load(context: AppContextType) {
                \(output)
            }

            required init() {}
        }
        """
    }

    // MARK: - Private

    private let results: [Results]

    // MARK: - Lifecycle

    init(results: [Results]) {
        self.results = results
    }
}
