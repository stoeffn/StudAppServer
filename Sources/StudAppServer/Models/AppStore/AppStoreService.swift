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

    enum Errors: String, Error {
        case emptyReceipt

        case unknown
    }

    static let shared = AppStoreService()

    lazy var configuration = AppStoreConfig()

    private lazy var session = URLSession.shared

    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        return encoder
    }()

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    func verify(receipt: Data, in environment: Environments, handler: @escaping ResultHandler<ReceiptResponse>) throws {
        guard !receipt.isEmpty else {
            return handler(.failure(Errors.emptyReceipt))
        }

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
            else {
                let result = Result<ReceiptResponse>.failure(error ?? Errors.unknown)
                return handler(result)
            }

            do {
                let responseBody = try self.decoder.decode(ReceiptResponse.self, from: encodedResponseBody)
                handler(.success(responseBody))
            } catch {
                let result = Result<ReceiptResponse>.failure(error)
                handler(result)
            }
        }
        task.resume()
    }
}
