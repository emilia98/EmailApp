//
//  EmailStore.swift
//  EmailApp
//
//  Created by Emilia Nedyalkova on 15.04.21.
//

import Foundation

struct Emails: Decodable {
    var emails: [Email]
}

class Email: Codable {
    var senderName: String
    var title: String
    var date: String
    var content: String
    var isRead: Bool
    
    init(_ senderName: String, _ title: String, _ date: String, _ content: String, _ isRead: Bool) {
        self.senderName = senderName
        self.title = title
        self.date = date
        self.content = content
        self.isRead = isRead
    }
}

class EmailStore {
    private var emails: [Email]
    
    init() {
        emails = [Email]()
        let jsonData = readLocalFile(forName: "emails")
        
        if let data = jsonData {
            emails = parse(jsonData: data)
        }
    }
    
    var getEmailsCount: Int {
        return emails.count
    }
    
    func getEmail(_ row: Int) -> Email {
        return emails[row]
    }
    
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json") {
                if let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    return jsonData
                }
            }
        } catch {
            print("Error occurred while reading file \(name).json")
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) -> [Email] {
        do {
            let decodedData = try JSONDecoder().decode(Emails.self, from: jsonData)
            return decodedData.emails
        } catch {
            print("Error occurred while decoding data: \(error)")
            return [Email]()
        }
    }
}
