//
//  HomeCell.swift
//  Sentia
//
//  Created by Matthew on 7/5/21.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var propertyAddressLabel: UILabel!
    @IBOutlet weak var propertyImage: UIImageView!
    @IBOutlet weak var agentImage: UIImageView!
    @IBOutlet weak var agentCompnayLabel: UILabel!
    @IBOutlet weak var agentName: UILabel!
    @IBOutlet weak var bedNumberLabel: UILabel!
    @IBOutlet weak var bathNumberLabel: UILabel!
    @IBOutlet weak var carNumberLabel: UILabel!
    var data: ListViewModel! {
        didSet {
            if let pImage = data.propertyImage {
                propertyImage.loadImageUsingCacheWithUrlString(pImage)
            }
            if let aImage = data.agentImageSmall {
                agentImage.loadImageUsingCacheWithUrlString(aImage)
            }
            agentName.text = data.agentName
            agentCompnayLabel.text = data.agentCompanyName
            propertyAddressLabel.text = data.address
            bedNumberLabel.text = data.bedrooms
            bathNumberLabel.text = data.bathrooms
            carNumberLabel.text = data.carspaces
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        agentName.sizeToFit()
        agentImage.roundedImage()
        propertyAddressLabel.sizeToFit()
        propertyAddressLabel.setLineSpacing(lineSpacing: 7.0)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
