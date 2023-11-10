//
//  MarvelApiService.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

class MarvelApiService: NSObject, MarvelApiServiceProtocol, URLSessionDelegate {
    
    // API Keys & Base Endpoint
    // TODO: Move this private key to a secure location (PList or server side solution). Obfuscate for additional level of security with an encoding or something similar. Not worth the effort for this sample as the privateKey is not sensitive.
    private let privateKey = "2609dfdf4b7a8d73153d2cfbd01120ad2ff7f34d"
    private let publicKey = "bd2e4092d2a7972954e4919aea276a1e"
    private let baseEndpoint = "https://gateway.marvel.com/v1/public/"

    // Conforming to MarvelApiServiceProtocol
    func getMarvelCharacters(offset: Int, completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        guard let url = createURLWithParameters(offset: offset) else {
            completion(.failure(NSError(domain: "MarvelApiService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                if let data = data {
                    let result = try JSONDecoder().decode(MarvelResult.self, from: data)
                    completion(.success(result.data.results))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Helper function to create the URL with query parameters
    private func createURLWithParameters(offset: Int) -> URL? {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5 // Make sure you have an md5 function
        let offsetString = "\(offset)"

        return URL(string: baseEndpoint + "characters?ts=" + timestamp + "&limit=20&offset=" + offsetString + "&apikey=" + publicKey + "&hash=" + hash)
    }

    // URLSessionDelegate methods
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        #if DEBUG
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        #else
        completionHandler(.performDefaultHandling, nil)
        #endif
    }
}
