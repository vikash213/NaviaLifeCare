//
//  FoodDataTableViewCell.swift
//  NaviaLifeCare
//
//  Created by vikash kumar on 10/2/18.
//  Copyright © 2018 NaviaLifeCare. All rights reserved.
//

import UIKit

class FoodDataTableViewCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var mealTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: FoodData) {
            if let image = data.image {
                if image == "" {
                    self.foodImageView.image = UIImage(named: "")
                } else {
                    let imageUrl = URL(string: image)
                    let imagedata = try? Data(contentsOf: imageUrl!)
                    self.foodImageView.image = UIImage(data: imagedata!)
                }
            }
            self.foodName.text = data.food ?? ""
            self.mealTimeLabel.text = data.mealTime ?? "08:00 AM"
    }
}
