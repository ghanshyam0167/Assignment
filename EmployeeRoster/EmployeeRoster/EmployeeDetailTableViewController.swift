
import UIKit

protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
    
}

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate,SelectEmployeeTypeTableViewControllerDelegate {
    func selectEmployeeTypeTableViewController(_ controller: SelectEmployeeTypeTableViewController, didSelect employeeType: EmployeeType) {
        self.employeeType = employeeType
        updateEmployeeType()
    }
    

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    
    
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
    
    var employeeType: EmployeeType?
    
    override func viewDidLoad() {
        let midnight = Calendar.current.startOfDay(for: Date())
        dobDatePicker.maximumDate = midnight
        dobDatePicker.date = midnight
        
        super.viewDidLoad()
        
        updateView()
        updateSaveButtonState()
        updateDataViews()
    }
    
    let dobDatePickerIndexPath = IndexPath(row: 2, section: 0);
    let dobDatePickerLabelIndexPath = IndexPath(row: 1, section: 0);
    
    var isDobPickerVisible: Bool = false {
        didSet{
            dobDatePicker.isHidden = !isDobPickerVisible
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case dobDatePickerIndexPath where isDobPickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case dobDatePickerIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            navigationItem.title = "New Employee"
        }
    }
    func updateDataViews(){
        dobLabel.text = dobDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    @IBAction func dobPickerValueChanged(_ sender: UIDatePicker) {
        updateDataViews()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == dobDatePickerLabelIndexPath && isDobPickerVisible == false {
            isDobPickerVisible.toggle()
        }else{
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    

    
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false
        saveBarButtonItem.isEnabled = shouldEnableSaveButton
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {
            return
        }
        
        let employee = Employee(name: name, dateOfBirth: Date(), employeeType: employeeType ?? .exempt)
        delegate?.employeeDetailTableViewController(self, didSave: employee)
    }
    
    func updateEmployeeType(){
        if let employeeType = employeeType{
            employeeTypeLabel.text = employeeType.description
        }else{
            employeeTypeLabel.text = "Not Set"
        }
    }
    
    
    @IBSegueAction func selectEmployeeType(_ coder: NSCoder) -> SelectEmployeeTypeTableViewController? {
        let selectEmployeeTypeController = SelectEmployeeTypeTableViewController(coder: coder)
        selectEmployeeTypeController?.delegate = self
        selectEmployeeTypeController?.employeeType = employeeType
        return selectEmployeeTypeController
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }

    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }

}
