
import UIKit


final class SettingsView: UIView {
    
    @IBOutlet weak var tableView: GroupedTableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        setupVersionLabel()
    }
    
    private func setupVersionLabel() {
        versionLabel.font = .version
        versionLabel.textColor = .gray
        versionLabel.alpha = 0.7
        versionLabel.text = "verze \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)"
    }
    
}
