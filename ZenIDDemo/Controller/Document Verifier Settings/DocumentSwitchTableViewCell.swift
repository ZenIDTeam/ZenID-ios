
import UIKit


final class DocumentSwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueSwitch: UISwitch!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueSwitch.removeTarget(nil, action: nil, for: .allEvents)
    }
    
}

