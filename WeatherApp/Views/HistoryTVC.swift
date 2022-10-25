//
//  HistoryTVC.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import UIKit

class HistoryTVC: UITableViewCell {

    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblWindAverage: UILabel!
    @IBOutlet weak var lblWindMedian: UILabel!
    @IBOutlet weak var lblTempAverage: UILabel!
    @IBOutlet weak var lblTempMedian: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var weakItem:WeatherResponseModel!{
        didSet{
            lblCity.text = weakItem.address
            lblWindAverage.text = String(format: "%.2f",weakItem.getAverageWindSpeed)
            lblWindMedian.text = String(format: "%.2f",weakItem.getMedianWind)
            lblTempAverage.text = String(format: "%.2f",weakItem.getAverageTemp)
            lblTempMedian.text = String(format: "%.2f",weakItem.getMedianTemp)
            
        }
    }
    
}
