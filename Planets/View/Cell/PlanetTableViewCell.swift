import UIKit

class PlanetTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    func setData(planet: Planet?) {
        nameLabel.text = planet?.name
    }
}
