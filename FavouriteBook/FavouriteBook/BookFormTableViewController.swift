//
//  BookFormTableViewController.swift
//  FavouriteBook
//
//  Created by GS Agrawal on 25/08/25.
//

import UIKit

class BookFormTableViewController: UITableViewController {
    
    var book : Books?
    init?(coder : NSCoder, book: Books?){
        self.book = book
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var lengthField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        if let book {
            updateUi(book: book)
        }
        checkForEmptyField()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func updateUi(book: Books){
        titleField.text = book.title
        authorField.text = book.author
        genreField.text = book.genre
        lengthField.text = book.length
    }
    
    @IBAction func textFieldUpdated(_ sender: Any) {
        checkForEmptyField()
    }
    func checkForEmptyField(){
        guard titleField.text != "" && authorField.text != "" && genreField.text != "" && lengthField.text != "" else{
            saveButton.isEnabled = false
            return
        }
        saveButton.isEnabled = true
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        var newBook = Books(title: titleField.text ?? "", author: authorField.text ?? "", genre: genreField.text ?? "", length: lengthField.text ?? "")
        self.book = newBook
        performSegue(withIdentifier: "saveSegue", sender: nil)
    }
    
    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
