//
//  AppStoreService.swift
//  Application
//
//  Created by Steffen Ryll on 17.12.17.
//

import Foundation

final class AppStoreService {
    enum Environments {
        case sandbox
        case production

        var url: URL {
            switch self {
            case .sandbox:
                return URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
            case .production:
                return URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
            }
        }
    }

    enum Errors: String, LocalizedError {
        case emptyReceipt

        case unknown

        var localizedDescription: String {
            switch self {
            case .emptyReceipt:
                return "No receipt was found."
            case .unknown:
                return "An unknown error occured"
            }
        }
    }

    static let shared = AppStoreService()

    lazy var configuration = AppStoreConfig()

    private lazy var session = URLSession(configuration: URLSessionConfiguration.default)

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'Etc/'ZZZZ"
        return formatter
    }()

    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()

    func fetchVerified(receipt: Data, in environment: Environments, completion: @escaping ResultHandler<ReceiptResponse>) {
        guard !receipt.isEmpty else { return completion(.failure(Errors.emptyReceipt)) }

        do {
            let requestBody = ReceiptRequest(receipt: receipt, sharedSecret: configuration.sharedSecret)
            let encodedRequestBody = try encoder.encode(requestBody)

            var request = URLRequest(url: environment.url)
            request.httpMethod = "POST"
            request.httpBody = encodedRequestBody

            let task = session.dataTask(with: request) { data, response, error in
                guard
                    error == nil,
                    let encodedResponseBody = data,
                    let response = response as? HTTPURLResponse,
                    200 ... 299 ~= response.statusCode
                else { return completion(Result<ReceiptResponse>.failure(error ?? Errors.unknown)) }

                do {
                    let responseBody = try self.decoder.decode(ReceiptResponse.self, from: encodedResponseBody)
                    completion(.success(responseBody))
                } catch {
                    completion(Result<ReceiptResponse>.failure(error))
                }
            }
            task.resume()
        } catch {
            return completion(Result<ReceiptResponse>.failure(error))
        }
    }

    func fetchVerified(receipt: Data, completion: @escaping ResultHandler<ReceiptResponse>) {
        fetchVerified(receipt: receipt, in: .production) { result in
            guard result.value?.statusCode == 21007 else { return completion(result) }
            self.fetchVerified(receipt: receipt, in: .sandbox, completion: completion)
        }
    }
}
