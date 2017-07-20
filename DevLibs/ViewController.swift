//
//  ViewController.swift
//  DevLibs
//
//  Created by Edward Yu US1070055 on 7/20/17.
//  Copyright © 2017 vmware-yedward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static var localTemplate = SentenceTemplate(title: "Local Template 1", sentence: "Because I write all my code in {{lang}} and {{framework}}, my code is always {{adjective}} and makes me feel {{adjective}}.")
    
    static var localTemplates = [
        SentenceTemplate(title: "Local Sentence 1", sentence: "Because I write all my code in {{lang}} and {{framework}}, my code is always {{adjective}} and makes me feel {{adjective}}."),
        SentenceTemplate(title: "Local Sentence 2", sentence: "{{methodology}} programming is the reason my code has {{number}} bugs and is so {{adjective}}.")
    ]
    
    var randomTemplate = ViewController.localTemplate
    var templatesToShow = ViewController.localTemplates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playDevLibsButtonTapped(_ sender: UIButton) {
        
        NetworkServices.fetchRandomSentence { (template, success) in
            if let template = template {
                // use remote template
                self.randomTemplate = template
                
            } else {
                // use local template
                self.randomTemplate = ViewController.localTemplate
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showRandomSentenceForm", sender: self)
            }
            
        }
        
        
    }
    
    @IBAction func showAllSentencesButtonTapped(_ sender: UIButton) {
        
        NetworkServices.fetchAllSentences { (templates, success) in
            if let templates = templates {
                // use remote templates
                self.templatesToShow = templates
            } else {
                // use local templates
                self.templatesToShow = ViewController.localTemplates

            }
        }
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showAllSentences", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRandomSentenceForm",
            let destVC = segue.destination as? SentenceFormViewController {
            

            destVC.sentenceTemplate = randomTemplate

        } else if segue.identifier == "showAllSentences",
            let destVC = segue.destination as? SentenceTableViewController {
            
            destVC.sentenceTemplates = templatesToShow
        }
    }

}

