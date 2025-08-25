//
//  BookTableViewController.swift
//  FavouriteBook
//
//  Created by GS Agrawal on 25/08/25.
//

import UIKit

class BookTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookTableViewCell
        
        var book = books[indexPath.row]
        cell.update(book: book)
        cell.showsReorderControl = true
        
        
//        var content = cell.defaultContentConfiguration()
//        content.text = "\(books[indexPath.row].title)-\(books[indexPath.row].author)"
//        content.secondaryText = "\(books[indexPath.row].genre)"
//        cell.contentConfiguration = content
//         Configure the cell...

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
            // Delete the row from the data source
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let removed = books.remove(at: fromIndexPath.row)
        books.insert(removed, at: to.row)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToAddBook", sender: indexPath)
    }
    
    @IBSegueAction func goToAddBook(_ coder: NSCoder, sender: Any?) -> BookFormTableViewController? {
        guard let indexPath = sender as? IndexPath else{
            return BookFormTableViewController(coder: coder, book : nil)
        }
        return BookFormTableViewController(coder: coder, book: books[indexPath.row])
    }
    
    @IBAction func unWindToBooks(_ segue : UIStoryboardSegue) {
        
        guard segue.identifier == "saveSegue", let source = segue.source as? BookFormTableViewController, let book = source.book else{
            return
        }
        
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            books.append(book)
            let indexPath = IndexPath(row: books.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .fade)
            return
        }
        
        books[selectedIndexPath.row] = book
        tableView.reloadRows(at: [selectedIndexPath], with: .fade)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
