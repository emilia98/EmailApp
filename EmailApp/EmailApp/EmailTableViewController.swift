//
//  EmailTableViewController.swift
//  EmailApp
//
//  Created by Emilia Nedyalkova on 15.04.21.
//

import UIKit

class EmailTableViewController : UITableViewController {
    var emailStore: EmailStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailStore.getEmailsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmailCell", for: indexPath) as! EmailCell
        let email = emailStore.getEmail(indexPath.row)
        
        cell.dateLabel.text = email.date
        cell.senderLabel.text = email.senderName
        cell.answerLabel.text = email.content
        cell.answerLabel.numberOfLines = 0
        cell.answerLabel.lineBreakMode = .byWordWrapping
        cell.titleLabel.text = email.title
        
        cell.readLabel.backgroundColor = email.isRead ? UIColor.clear : UIColor.blue
        cell.readLabel.layer.borderColor = UIColor.systemBackground.cgColor
        return cell
        
    }
}
