//
//  APIError.swift
//  DevSearchDiplo
//
//  Created by alumno on 20/02/26.
//

import Foundation

public enum APIError: Error, LocalizedError {
    case invalidURL
    case decodingError(Error)
    case serverError(statusCode: Int, data: Data?)
    case noData
    case unknow(Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL es invalida"
        case .decodingError(let error):
            return "Error al decodificar \(error.localizedDescription)"
        case .serverError(let statusCode, let data):
            return "Error del servidor. Codigo: \(statusCode)"
        case .noData:
            return "No se recibió información del servidor"
        case .unknow(let error):
            return "Error desconocido \(error.localizedDescription)"
        }
    }
}
