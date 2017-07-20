//
//  SentenceFormViewController.swift
//  DevLibs
//
//  Created by Edward Yu US1070055 on 7/20/17.
//  Copyright © 2017 vmware-yedward. All rights reserved.
//

import UIKit

class SentenceFormViewController: UITableViewController {
    
    var sentenceTemplate: SentenceTemplate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sentenceTemplate = sentenceTemplate else {
            return 0
        }
        return sentenceTemplate.blanks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)

        guard let wordCell = cell as? SentenceFormViewCell, let sentenceTemplate = sentenceTemplate else {
            return cell
        }
        
        let placeholderWithBraces = sentenceTemplate.blanks[indexPath.row]
        
        wordCell.textField.placeholder = stripBraces(blank: placeholderWithBraces)
        
        return wordCell
    }
 

    @IBAction func generateSentenceButtonTapped(_ sender: UIBarButtonItem) {
        guard let sentenceTemplate = sentenceTemplate else {
            return
        }
        
        var blanksAndReplacements = [(String, String)]()
        
        for (index, blank) in sentenceTemplate.blanks.enumerated() {
            
            guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)),
                let wordCell = cell as? SentenceFormViewCell,
                let replacement = wordCell.textField.text else {
                return
            }
            
            blanksAndReplacements.append((blank, replacement))
        }
        
        
        let sentence = sentenceTemplate.generateSentence(using: blanksAndReplacements)
        
        let alertC = UIAlertController(title: "Your sentence", message: sentence, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertC.addAction(action)
        present(alertC, animated: true, completion: nil)
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
