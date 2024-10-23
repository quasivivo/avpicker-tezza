//
//  Movie.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import CoreTransferable

struct Movie: Transferable, Codable {
    let url: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { receivedData in
            let fileName = receivedData.file.lastPathComponent

            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let copy = documents.appendingPathComponent(fileName)

            if FileManager.default.fileExists(atPath: copy.path) {
                try FileManager.default.removeItem(at: copy)
            }

            try FileManager.default.copyItem(at: receivedData.file, to: copy)
            return .init(url: copy)
        }
    }
}
