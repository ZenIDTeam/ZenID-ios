
import UIKit

final class SettingsSwitchCellController: TableCellController {
    private let viewModel: SettingsSwitchViewModel
    private weak var valueLabel: UILabel?

    init(viewModel: SettingsSwitchViewModel) {
        self.viewModel = viewModel
    }

    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SwitchSettingsTableViewCell.self), for: indexPath) as! SwitchSettingsTableViewCell
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
