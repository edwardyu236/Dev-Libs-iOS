//
//  SentenceTableViewController.swift
//  DevLibs
//
//  Created by Edward Yu US1070055 on 7/20/17.
//  Copyright © 2017 vmware-yedward. All rights reserved.
//

import UIKit



class SentenceTableViewController: UITableViewController {
    
    
    var sentenceTemplates = ViewController.localTemplates
    
    var sentencesShown = false
    var rowForSegue: Int? = nil
    

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        rowForSegue = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "showSpecificSentenceForm", sender: self)
        
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showSpecificSentenceForm",
            let destVC = segue.destination as? SentenceFormViewController,
            let rowForSegue = rowForSegue {
            destVC.sentenceTemplate = sentenceTemplates[rowForSegue]
            self.rowForSegue = nil
        }
    }
 

}
