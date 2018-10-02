//
//  FoodsPlanViewController.swift
//  NaviaLifeCare
//
//  Created by vikash kumar on 10/2/18.
//  Copyright © 2018 NaviaLifeCare. All rights reserved.
//
public enum CurrentDay : Int {
    case Monday          =  1
    case Tuesday         =  2
    case Wednesday       =  3
    case Thursday        =  4
    case Friday          =  5
    case Saturday        =  6
    case Sunday          =  7
}


import UIKit
import ObjectMapper


class FoodsPlanViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var dietPlanTableView: UITableView!
    @IBOutlet weak var dayLabel: UILabel!
    
    // MARK: Variables
    var wednesday: [FoodData] = []
    var monday: [FoodData] = []
    var thursday: [FoodData] = []
    
    var currentDate: Int = 0
    
    //MARK: - View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Registering Cell
        self.dietPlanTableView.register(UINib.init(nibName: "FoodDataTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodDataTableViewCell")
        self.getCurrentDate()
        self.parseData()
        self.dayLabel.text = self.getCurrentDay()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Functions
    
    //Parse data from json file
    func parseData() {
        if let path = Bundle.main.path(forResource: "Food", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let result = jsonResult as? [String: AnyObject], let mondaydata = result["monday"]  as? [Dictionary<String,AnyObject>], let wednesdaydata = result["wednesday"]  as? [Dictionary<String,AnyObject>], let thursadydata = result["thursday"]  as? [Dictionary<String,AnyObject>] {
                    
                    var foodsData: [FoodData] = []
                    
                    if self.currentDate == CurrentDay.Monday.rawValue {
                        for data in mondaydata {
                            let user = Mapper<FoodData>().map(JSON: data)
                            if let ListData = user {
                                foodsData.append(ListData)
                            }
                        }
                         self.monday.append(contentsOf: foodsData)
                        
                    } else if self.currentDate == CurrentDay.Wednesday.rawValue {
                        for data in wednesdaydata {
                            let user = Mapper<FoodData>().map(JSON: data)
                            if let ListData = user {
                                foodsData.append(ListData)
                            }
                        }
                        self.wednesday.append(contentsOf: foodsData)
                    } else {
                        for data in thursadydata {
                            let user = Mapper<FoodData>().map(JSON: data)
                            if let ListData = user {
                                foodsData.append(ListData)
                            }
                        }
                    }
                   self.thursday.append(contentsOf: foodsData)
                }
            } catch {
                // handle error
            }
        }
    }
    
    //Get Current date and time
    func getCurrentDate() {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let day = components.day
        self.currentDate = day ?? 0
    }
    
    func getCurrentDay() -> String {
        switch self.currentDate {
        case CurrentDay.Monday.rawValue:
            return "Monday"
        case CurrentDay.Tuesday.rawValue:
            return "Tuesday"
        case CurrentDay.Wednesday.rawValue:
            return "Wednesday"
        case CurrentDay.Thursday.rawValue:
            return "Thursday"
        case CurrentDay.Friday.rawValue:
            return "Friday"
        case CurrentDay.Saturday.rawValue:
            return "Saturday"
        default:
           return "Sunday"
        }
    }
}

//MARK: - Tableview's Delegates
extension FoodsPlanViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.currentDate == CurrentDay.Monday.rawValue {
            return self.monday.count
        } else if self.currentDate == CurrentDay.Wednesday.rawValue {
            return self.wednesday.count
        } else {
            return self.thursday.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodDataTableViewCell", for: indexPath)
        if let theCell = cell as? FoodDataTableViewCell {
            if self.currentDate == CurrentDay.Monday.rawValue {
                theCell.configureCell(data: self.monday[indexPath.row])
            } else if self.currentDate == CurrentDay.Wednesday.rawValue {
                theCell.configureCell(data: self.wednesday[indexPath.row])
            } else {
                theCell.configureCell(data: self.thursday[indexPath.row])
            }
            return theCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}

