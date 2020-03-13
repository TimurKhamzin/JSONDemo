

import UIKit

class EmployeeListVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var employeeListTableView: UITableView!
    
    var empDetailsArray: [EmployeeDetailsPOJO] = [EmployeeDetailsPOJO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadFromFile()
        
        self.employeeListTableView.tableFooterView = nil
    }
    
    //MARK:
    
   
    //MARK:
    //MARK:- Load from local file
    
    func loadFromFile(){
        
        var empName = ""
        var empRegion = ""
        var empAge = 0
        
        if let path = Bundle.main.path(forResource: "Data", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                if let jsonResult: NSDictionary = try! JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                {
                    
                    if let empDetails = jsonResult["data"] as? [[String: Any]] {
                        
                        for empDetail in empDetails {
                            if let name = empDetail["name"] as? String {
                                
                                empName = name
                            }
                            else{
                                empName = "NA"
                            }
                            if let job = empDetail["region"] as? String {
                                
                                empRegion = job
                            }
                            else{
                                empRegion = "NA"
                            }
                            if let age = empDetail["age"] as? Int {
                                
                                empAge = age
                            }
                            else{
                                empAge = 0
                            }
                            
                            let empDetailPOJO:EmployeeDetailsPOJO = EmployeeDetailsPOJO(empName: empName, empJobDescription: empRegion, empAge: empAge)
                            
                            empDetailsArray.append(empDetailPOJO)
                        }
                        empDetailsArray.sort(by: { $0.empName < $1.empName })
                        self.employeeListTableView.reloadData()
                    }
                    else{
                        empName = "NA"
                        empRegion = "NA"
                        empAge = 0
                    }
                }
            }
        }
    }

    //MARK:
    //MARK: Table Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if empDetailsArray.count == 0 {
           
            //TODO: Display alert to the user "No data available"
            print("No data available")
        }
        return empDetailsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: EmployeeDetailsTableCell = employeeListTableView.dequeueReusableCell(withIdentifier: "EmployeeDetailsTableCell") as! EmployeeDetailsTableCell
        
        cell.employeeImg.image =  #imageLiteral(resourceName: "default")
        cell.employeeName.text = empDetailsArray[indexPath.row].empName
        cell.employeeJobDescription.text = empDetailsArray[indexPath.row].empJobDescription
        
        if empDetailsArray[indexPath.row].empJobDescription == "Developer"{
            
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.employeeListTableView.deselectRow(at: indexPath, animated: false)
        
        self.employeeListTableView.deselectRow(at: indexPath, animated: false)
        
    }
}
