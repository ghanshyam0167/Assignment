//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by GSKey on 01/09/25.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController{
    
    
    var toDo:ToDo?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    
    var isdatePickerHidden = true
    let datelabelIndex = IndexPath(row:0,section: 1)
    let datePickerIndex = IndexPath(row:1,section: 1)
    let notesPathIndex = IndexPath(row:0,section: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDueDate : Date
        if let toDo = toDo{
            navigationItem.title = "To-Do"
            titleTextField.text = toDo.title
            isCompleteButton.isSelected = toDo.isComplete
            currentDueDate = toDo.dueDate
            notesTextField.text = toDo.notes
            
        }else{
            currentDueDate = Date().addingTimeInterval(24*60*60)
        }
        
        
       
        dueDatePicker.date = currentDueDate
        updateDueDateLabel(date : dueDatePicker.date)
        updateSaveButton()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    
    func updateSaveButton(){
        let shouldSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldSaveButton
    }
    
    
    func updateDueDateLabel(date : Date){
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year().hour().minute())
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    
    @IBAction func textChanged(_sender :UITextField){
        updateSaveButton()
    }
    
    
    @IBAction func returnPressed(_ sender:UITextField){
        sender.resignFirstResponder()
    }
    
    
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        
        isCompleteButton.isSelected.toggle()
    }
    
        

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else {return}
        
        let title = titleTextField.text!
        let notes = notesTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePicker.date
        
        if toDo != nil {
              toDo?.title = title
              toDo?.isComplete = isComplete
              toDo?.dueDate = dueDate
              toDo?.notes = notes
        }else{
              toDo = ToDo(title: title, isComplete: isComplete, dueDate:dueDate, notes: notes)
        }
    }
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
            case datePickerIndex where isdatePickerHidden == true:
            return 0
        case notesPathIndex:
            return 200
        default:
           return UITableView.automaticDimension
        
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case datePickerIndex:
            return 216
        case notesPathIndex:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == datelabelIndex{
            isdatePickerHidden.toggle()
            updateDueDateLabel(date: dueDatePicker.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
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
