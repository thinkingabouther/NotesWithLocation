//
//  FoldersViewController.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 10/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//

import UIKit

class FoldersViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CoreDataManager.sharedInstance.folders.count
    }

    @IBAction func AddButtonPushed(_ sender: Any) {
        let alertController = UIAlertController(title: "Creating a folder", message: "Choose a name for a new folder", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField(configurationHandler: {(textField) in textField.placeholder = "Folder name"})
        
        let alertActionCreate = UIAlertAction(title: "Create", style: UIAlertAction.Style.default) { (alert) in
            let newFolderName = alertController.textFields![0].text
            if let newFolderName = newFolderName{
                _ = Folder.NewFolder(name: newFolderName.uppercased())
                CoreDataManager.sharedInstance.saveContext()
                self.tableView.reloadData()
            }
        }
        
        alertController.addAction(alertActionCreate)
        
        let alercActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(alercActionCancel)
        
        present(alertController, animated: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath)

        let folderForCurrentCell = CoreDataManager.sharedInstance.folders[indexPath.row]
        cell.textLabel?.text = folderForCurrentCell.name
        cell.detailTextLabel?.text =  "\(folderForCurrentCell.notes!.count) item(-s)"
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currFolder = CoreDataManager.sharedInstance.folders[indexPath.row]
            CoreDataManager.sharedInstance.managedObjectContext.delete(currFolder)
            CoreDataManager.sharedInstance.saveContext()
            tableView.deleteRows(at: [indexPath], with: .left)
        } else if editingStyle == .insert {
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToCurrentFolder", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToCurrentFolder"{
            let selectedFolder = CoreDataManager.sharedInstance.folders[tableView.indexPathForSelectedRow!.row]
            (segue.destination as! SingleFolderViewController).currentFolder = selectedFolder
        }
    }

}
