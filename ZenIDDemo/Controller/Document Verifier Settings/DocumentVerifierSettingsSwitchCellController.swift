
import UIKit


final class DocumentVerifierSettingsSwitchCellController: TableCellController {
    
    private let viewModel: DocumentVerifierSettingsSwitchViewModel
    private weak var valueLabel: UILabel?
    
    init(viewModel: DocumentVerifierSettingsSwitchViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentSwitchTableViewCell", for: indexPath) as! DocumentSwitchTableViewCell
        cell.titleLabel.text = viewModel.title
        cell.valueSwitch.isOn = viewModel.value
        cell.valueSwitch.addTarget(self, action: #selector(valueDidEnd), for: .touchUpInside)
        return cell
    }
    
    func select() {
        
    }
    
    @objc
    private func valueDidEnd(sender: UISwitch) {
        viewModel.onChange(sender.isOn)
    }
    
}

