//
//  SingleFolderViewController.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 10/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//

import UIKit

class SingleFolderViewController: UITableViewController {

    var currentFolder : Folder?
    var selectedNote : Note?
    
    
    @IBAction func AddButtonPushed(_ sender: Any) {
        selectedNote = Note.NewNote(noteName: "newName", inFolder: currentFolder)
        performSegue(withIdentifier: "GoToNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToNote"{
            (segue.destination as! SingleNoteVIewController).currentNote = selectedNote
        }
    }
    var currentNotes : [Note] {
        if let currentFolder = currentFolder{
            return currentFolder.notesSorted
        }
        return CoreDataManager.sharedInstance.notes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentFolder = currentFolder{
            navigationItem.title = currentFolder.name
        }
        else{
            navigationItem.title = "All notes"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let currentNote = currentNotes[indexPath.row]
        cell.textLabel?.text = currentNote.name
        cell.detailTextLabel?.text = currentNote.dateModifiedString
        cell.imageView?.image = currentNote.actualSmallImage
        return cell
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentNote = currentNotes[indexPath.row]
            CoreDataManager.sharedInstance.managedObjectContext.delete(currentNote)
            CoreDataManager.sharedInstance.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteInCell = currentNotes[indexPath.row]
        selectedNote = noteInCell
        performSegue(withIdentifier: "GoToNote", sender: self)
    }
    

}
