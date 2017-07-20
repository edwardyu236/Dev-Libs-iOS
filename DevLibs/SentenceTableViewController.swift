//
//  SentenceTableViewController.swift
//  DevLibs
//
//  Created by Edward Yu US1070055 on 7/20/17.
//  Copyright © 2017 vmware-yedward. All rights reserved.
//

import UIKit



class SentenceTableViewController: UITableViewController {
    
    var sentenceTemplates: [SentenceTemplate] = [
        SentenceTemplate(title: "Sentence 1", sentence: "Because I write all my code in {{lang}} and {{framework}}, my code is always {{adjective}} and makes me feel {{adjective}}."),
        SentenceTemplate(title: "Sentence 2", sentence: "{{methodology}} programming is the reason my code has {{number}} bugs and is so {{adjective}}.")
    ]
    var sentencesShown = false;
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        return sentenceTemplates.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let template = sentenceTemplates[indexPath.row]
        cell.textLabel!.text = template.title
        cell.detailTextLabel!.text = template.sentence
        
        cell.detailTextLabel?.isHidden = !sentencesShown
        
        return cell
    }
    
    @IBAction func editBarButtonTapped(_ sender: UIBarButtonItem) {
        let alertC = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        if sentencesShown {
            let action = UIAlertAction(title: "Hide Sentences", style: .default, handler: { (alertAction) in
                self.sentencesShown = false
                self.tableView.reloadData()
            })
            alertC.addAction(action)
            
        } else {
            let action = UIAlertAction(title: "Show Sentences", style: .default, handler: { (alertAction) in
                self.sentencesShown = true
                self.tableView.reloadData()
            })
            alertC.addAction(action)
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertC.addAction(cancelAction)
        
        present(alertC, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
