//
//  DemoDeckController.swift
//  mNeme
//
//  Created by Lambda_School_Loaner_204 on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class DemoDeckController {

    // MARK: - Properties

    var demoDecks = [DemoDeck]()
    let dataLoader: NetworkDataLoader
    let baseURL = URL(string: "https://flashcards-be.herokuapp.com/api/demo/I2r2gejFYwCQfqafWlVy")!

    // MARK: - Init
    init(networkDataLoader: NetworkDataLoader = URLSession.shared) {
        self.dataLoader = networkDataLoader
    }

    // MARK: - Networking
    // Getting All Demo Decks & their names
    func getDemoDecks(completion: @escaping () -> Void) {

        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue

        dataLoader.loadData(using: request) { (data, response, error) in
            if let error = error {
                print("\(error)")
                completion()
                return
            }

            guard let data = data else { completion(); return }

            do {
                if let deckInfo = try JSONSerialization.jsonObject(with: data, options: []) as? Array<[String: Any]> {
                    print("\(deckInfo)")
                    for deck in deckInfo {
                        if let deckName = deck["deckName"] as? String {
                            print(deckName)
                            self.getDemoDeckCards(deckName: deckName) {}
                        }
                    }
                }
            } catch {
                print("Error decoding demo decks")
            }
            completion()
        }
    }
    
    // Getting specific cards from Demodecks
    func getDemoDeckCards(deckName: String, completion: @escaping () -> Void) {
        let requestURL = baseURL.appendingPathComponent(deckName)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue

        dataLoader.loadData(using: request) { (data, response, error) in
            if let error = error {
                print("\(error)")
                completion()
                return
            }

            guard let data = data else { completion(); return }
            let jsonDecoder = JSONDecoder()
            do {
                let demoDeck = try jsonDecoder.decode(DemoDeck.self, from: data)
                print(demoDeck)
                self.demoDecks.append(demoDeck)
            } catch {
                print("Error Decoding deck card data")
            }
            completion()
        }
    }
}


struct DemoDeck: Codable {
    var deckName: String
    var data: [CardData]

    struct CardData: Codable {
        var id: String
        var data: CardInfo

        struct CardInfo: Codable {
            var back, front: String
        }
    }
}


