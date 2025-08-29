//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by GS Agrawal on 27/08/25.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTableViewControllerDelegate {
    func selectRoomTableViewController(_ controller: SelectRoomTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
        updateCharge()
    }
    var updateRegistration : Registration?
    
    init?(coder: NSCoder, registration : Registration?) {
        self.updateRegistration = registration
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    

    var roomType : RoomType?
    
    var registration : Registration? {
        guard let roomType else {
            return nil
        }
        let firstName = firstNameField.text ?? ""
        let lastName = lastNameField.text ?? ""
        let email = emailField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChild = Int(numberOfChildStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChild: numberOfChild, wifi: hasWifi, roomType: roomType)
        
        
    }
    
    @IBOutlet weak var totalChargeLabel: UILabel!
    @IBOutlet weak var hasWifiLabel: UILabel!
    @IBOutlet weak var wifiChargeLabel: UILabel!
    @IBOutlet weak var roomDescriptionLabel: UILabel!
    @IBOutlet weak var roomChargeLabel: UILabel!
    @IBOutlet weak var dateRangeLabel: UILabel!
    @IBOutlet weak var numberOfNightsLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    
    @IBOutlet weak var numberOfChildLabel: UILabel!
    
    @IBOutlet weak var numberOfChildStepper: UIStepper!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let updateRegistration {
            updateUIWithData(registration : updateRegistration)
        }
        updateUi()
        updateCharge()
        updateNumberOfGuests()
        updateRoomType()
        let midNightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midNightToday
        checkOutDatePicker.date = midNightToday
    }

    func updateCharge(){
        var totalCharge = 0;
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let difference = checkOutDate.timeIntervalSince(checkInDate)
        let numberOfDays = Int(difference / (60 * 60 * 24))
            numberOfNightsLabel.text = "\(numberOfDays)"
            dateRangeLabel.text = (checkInDatePicker.date..<checkOutDatePicker.date).formatted(date: .numeric, time: .omitted)
        
        if let roomType {
            roomDescriptionLabel.text = "\(roomType.name) @ $\(roomType.price)/night"
            roomChargeLabel.text = "$ \(roomType.price * numberOfDays)"
            totalCharge += roomType.price * numberOfDays
        }else{
            roomDescriptionLabel.text = "Not set"
            roomChargeLabel.text = "$ 0"
        }
        if (wifiSwitch.isOn) {
            wifiChargeLabel.text = "$ 40"
            hasWifiLabel.text = "Yes"
            totalCharge += 40
        }
        else {
            wifiChargeLabel.text = "$ 0"
            hasWifiLabel.text = "No"
            
        }
        
        totalChargeLabel.text = "$ \(totalCharge)"
    }
    func updateUIWithData(registration : Registration) {
        firstNameField.text = registration.firstName
        lastNameField.text = registration.lastName
        emailField.text = registration.emailAddress
        numberOfAdultsLabel.text = "\(registration.numberOfAdults)"
        numberOfChildLabel.text = "\(registration.numberOfChild)"
        checkInDatePicker.date = registration.checkInDate
        checkOutDatePicker.date = registration.checkOutDate
        wifiSwitch.isOn = registration.wifi
        roomType = registration.roomType
    }
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    var isCheckInDatePickerVisible: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    var isCheckOutDatePickerVisible: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
   
    
    func updateUi(){
        
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1 , to: checkInDatePicker.date)
        checkInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        checkOutDateLabel.text =
        checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        updateUi()
        updateCharge()
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath
            where isCheckInDatePickerVisible == false:
            return 0
        case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false :
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath :
            return 190
        case checkOutDatePickerCellIndexPath :
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == checkInDateLabelCellIndexPath && isCheckOutDatePickerVisible == false {
            isCheckInDatePickerVisible.toggle()
        }else if indexPath == checkOutDateLabelCellIndexPath && isCheckInDatePickerVisible == false{
            isCheckOutDatePickerVisible.toggle()
        }else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath {
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        } else{
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func updateNumberOfGuests(){
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildLabel.text = "\(Int(numberOfChildStepper.value))"
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchedChanged(_ sender: UISwitch) {
        updateCharge()
    }
    
    func updateRoomType(){
        if let roomType {
            roomTypeLabel.text = roomType.name
        }
        else{
            roomTypeLabel.text = "Not set"
        }
    }
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTableViewController? {
        let selectRoomTypeController = SelectRoomTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        return selectRoomTypeController
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
