//
//  HomeViewModel.swift
//  donBigotes
//
//  Created by Yibriam on 23/01/26.
//

import Foundation

class HomeViewModel {
    private var store: Store?
    
    var name: String { store?.name ?? "" }
    var slogan: String { store?.slogan ?? "" }
    var description: String { store?.description ?? "" }
    
    init() {
        loadData()
    }
    
    private func loadData() {
        guard let url = Bundle.main.url(forResource: "don_bigotes2", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(DonBigotesResponse.self, from: data) else {
            return }
        self.store = response.store
    }
    
//    private func loadData() {
//        guard let url = Bundle.main.url(forResource: "don_bigotes2", withExtension: "json"),
//              let data = try? Data(contentsOf: url),
//              let response = try? JSONDecoder().decode(DonBigotesResponse.self, from: data) else { return }
//        self.store = response.store
//    }
    
    func getBranches() -> [Branch] {
        return store?.branches ?? []
    }
}
