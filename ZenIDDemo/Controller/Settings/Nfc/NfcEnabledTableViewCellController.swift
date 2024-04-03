import UIKit

final class NfcTableViewCellController: NSObject, TableCellController{
    private let service: ConfigService
    
    init(service: ConfigService) {
        self.service = service
    }
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.reuseIdentifier, for: indexPath) as! SwitchTableViewCell
        removeAllTargets(of: cell.valueSwitch)
        cell.title.text = NSLocalizedString("nfc-feature-enabled", comment: "")
        if #available(iOS 13.0, *) {
            cell.valueSwitch.isOn = service.load().isNfcEnabled
        } else {
            cell.valueSwitch.isOn = false
            cell.valueSwitch.isEnabled = false
        }
        cell.valueSwitch.addTarget(self, action: #selector(valueSwitchDidChange(sender:)), for: .valueChanged)
        return cell
    }
    
    func select() {
        
    }
    
    private func removeAllTargets(of element: UIControl) {
        for target in element.allTargets {
            element.removeTarget(target, action: #selector(valueSwitchDidChange(sender:)), for: .valueChanged)
        }
    }
    
    @objc
    private func valueSwitchDidChange(sender: UISwitch) {
        try? service.update(isNfcEnabled: sender.isOn)
    }
}
