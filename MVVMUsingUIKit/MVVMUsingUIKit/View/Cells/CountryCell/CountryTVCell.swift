//
//  CountryTVCell.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//

import UIKit

class CountryTVCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: CountryTVCell.identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configureCountryDataUsing(viewModel: CountryViewModel) {
        self.countryNameLabel.text = viewModel.name
    }
    
}
