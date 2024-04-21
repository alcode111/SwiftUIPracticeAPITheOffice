//
//  ViewModel.swift
//  SwiftUIPracticeAPITheOffice
//
//  Created by Ismaïl LP on 21/04/2024.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success(data: Quote)
        case failed(error: Error)
    }
    
    @Published private(set) var status: Status = .notStarted
    
    private let controller: FetchController
    
    init(controller: FetchController) {
        self.controller = controller
    }
    
    func getData() async {
        status = .fetching
        
        do {
            let quote = try await controller.fetchQuote()
            status = .success(data: quote)
        } catch {
            status = .failed(error: error)
        }
    }
}
