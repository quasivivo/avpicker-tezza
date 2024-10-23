//
//  PhotosPickerError.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

enum PhotosPickerError: Error {
    case unableToLoadItem
    case invalidURL
    case unknownError

    var localizedDescription: String {
        switch self {
        case .unableToLoadItem:
            return "Unable to load the selected item."
        case .invalidURL:
            return "The URL provided is invalid."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
