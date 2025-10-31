//
//  Service.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//

import Foundation
import Alamofire
import UIKit

enum ApiError: Error, LocalizedError {
    case noInternet
    case serverError(String)
    case decodingError(String)
    case invalidResponse
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No Internet connection. Please check your network."
        case .serverError(let msg):
            return msg
        case .decodingError(let msg):
            return "Data parsing failed: \(msg)"
        case .invalidResponse:
            return "Received an invalid response from server."
        case .unknown(let msg):
            return msg
        }
    }
}

// MARK: - Service Layer
final class Service {
    
    // MARK: Singleton
    static let shared = Service()
    private init() {}
    
    // MARK: Alamofire Session
    private let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 120
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        return Session(configuration: config)
    }()
    
    // MARK: - Helper: Check Connectivity
    private func checkConnection() throws {
        guard Utility.checkNetworkConnectivityWithDisplayAlert(isShowAlert: false) else {
            throw ApiError.noInternet
        }
    }
    
    // MARK: - Raw Data Request
    func requestData (
        url: String,
        method: HTTPMethod = .post,
        params: [String: Any]? = nil
    ) async throws -> Data {
        
        try checkConnection()
        
        do {
            let response = try await session.request(url, method: method, parameters: params)
                .validate()
                .serializingData()
                .value
            
            print("✅ API Success: \(url)")
            print("📤 Params: \(params ?? [:])")
            return response
            
        } catch let afError as AFError {
            print("❌ AFError: \(afError.localizedDescription)")
            throw ApiError.serverError(afError.localizedDescription)
        } catch {
            print("❌ Unknown Network Error: \(error.localizedDescription)")
            throw ApiError.unknown(error.localizedDescription)
        }
    }
    
    // MARK: - Decodable Response
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .post,
        params: [String: Any]? = nil,
        responseType: T.Type
    ) async throws -> T {
        do {
            let data = try await requestData(url: url, method: method, params: params)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch let decodingError as DecodingError {
            throw ApiError.decodingError(decodingError.localizedDescription)
        } catch {
            throw error
        }
    }
    
    // MARK: - Upload Single Media
    func uploadSingleMedia(
        url: String,
        params: [String: String]? = nil,
        images: [String: UIImage]? = nil,
        videos: [String: Data]? = nil
    ) async throws -> Data {
        try checkConnection()
        
        return try await withCheckedThrowingContinuation { continuation in
            session.upload(multipartFormData: { multipart in
                self.appendParameters(params, to: multipart)
                self.appendImages(images, to: multipart)
                self.appendVideos(videos, to: multipart)
            }, to: url)
            .validate()
            .responseData { response in
                self.handleUploadResponse(response, continuation: continuation)
            }
        }
    }
    
    // MARK: - Upload Multiple Media
    func uploadMultipleMedia(
        url: String,
        params: [String: String]? = nil,
        imageArrays: [String: [UIImage]]? = nil,
        videoURLs: [String: [URL]]? = nil
    ) async throws -> Data {
        try checkConnection()
        
        return try await withCheckedThrowingContinuation { continuation in
            session.upload(multipartFormData: { multipart in
                self.appendParameters(params, to: multipart)
                
                // Multiple Images
                imageArrays?.forEach { key, images in
                    for image in images {
                        if let data = image.jpegData(compressionQuality: 0.7) {
                            multipart.append(data,
                                             withName: key,
                                             fileName: "\(UUID().uuidString).jpg",
                                             mimeType: "image/jpeg")
                        }
                    }
                }
                
                // Multiple Videos
                videoURLs?.forEach { key, urls in
                    for url in urls {
                        multipart.append(url,
                                         withName: key,
                                         fileName: "\(UUID().uuidString).mp4",
                                         mimeType: "video/mp4")
                    }
                }
            }, to: url)
            .validate()
            .responseData { response in
                self.handleUploadResponse(response, continuation: continuation)
            }
        }
    }
    
    // MARK: - Upload Files (PDF / etc.)
    func uploadWithFiles(
        url: String,
        params: [String: String]? = nil,
        pdfData: [String: Data]? = nil,
        videos: [String: Data]? = nil
    ) async throws -> Data {
        try checkConnection()
        
        return try await withCheckedThrowingContinuation { continuation in
            session.upload(multipartFormData: { multipart in
                self.appendParameters(params, to: multipart)
                
                // PDFs
                pdfData?.forEach { key, data in
                    multipart.append(data, withName: key, fileName: "\(key).pdf", mimeType: "application/pdf")
                }
                
                // Videos
                self.appendVideos(videos, to: multipart)
            }, to: url)
            .validate()
            .responseData { response in
                self.handleUploadResponse(response, continuation: continuation)
            }
        }
    }
}

// MARK: - Multipart Helpers
private extension Service {
    
    func appendParameters(_ params: [String: String]?, to multipart: MultipartFormData) {
        params?.forEach { key, value in
            if let data = value.data(using: .utf8) {
                multipart.append(data, withName: key)
            }
        }
    }
    
    func appendImages(_ images: [String: UIImage]?, to multipart: MultipartFormData) {
        images?.forEach { key, image in
            if let data = image.jpegData(compressionQuality: 0.7) {
                multipart.append(data, withName: key, fileName: "\(key).jpg", mimeType: "image/jpeg")
            }
        }
    }
    
    func appendVideos(_ videos: [String: Data]?, to multipart: MultipartFormData) {
        videos?.forEach { key, data in
            multipart.append(data, withName: key, fileName: "\(key).mp4", mimeType: "video/mp4")
        }
    }
    
    func handleUploadResponse(
        _ response: AFDataResponse<Data>,
        continuation: CheckedContinuation<Data, Error>
    ) {
        switch response.result {
        case .success(let data):
            print("✅ Upload Success")
            continuation.resume(returning: data)
        case .failure(let error):
            print("❌ Upload Failed: \(error.localizedDescription)")
            continuation.resume(throwing: ApiError.serverError(error.localizedDescription))
        }
    }
}
