//
//  NetworkManager.swift
//  RadiusAgent
//
//  Created by Raj  Dhakate on 30/06/23.
//

import Foundation

actor NetworkManagerActor {
    func getData() async throws -> FacilitiesData {
        let url = URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        let request = URLRequest(url: url!)
        let (data, _) = try await URLSession.shared.data(for: request)
        let fetchedData = try JSONDecoder().decode(FacilitiesData.self, from: data)
        return fetchedData
    }
}
