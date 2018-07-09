//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    
    var notes=[Note](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes=CoreDataHelper.retrieveNotes()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            let noteToDelete=notes[indexPath.row]
            CoreDataHelper.delete(note: noteToDelete)
            notes=CoreDataHelper.retrieveNotes()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        let note=notes[indexPath.row]
        cell.toDoTitleLabel.text=note.title
        cell.toDoTimeCreated.text=note.modificationTime?.convertToString() ?? "unknown"
        cell.onButtonTouched = {(cell) in
            guard let indexPath=tableView.indexPath(for: cell) else {
                return }
            
            let noteToDelete=self.notes[indexPath.row]
           CoreDataHelper.delete(note: noteToDelete)
            self.notes=CoreDataHelper.retrieveNotes()
        }
        return cell
    }
    
    
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue){
        notes=CoreDataHelper.retrieveNotes()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier{
        case "displayToDo":
            guard let indexPath=tableView.indexPathForSelectedRow else {return}
            let note=notes[indexPath.row]
            let destination=segue.destination as! DisplayNoteViewController
            destination.note=note
            print("to do cell tapped")
            
        case "addToDo":
            print("create to do bar button item tapped")
        
        default:
            print("unexpected segue identifier")
        }
        
    }
    
    
    
}
