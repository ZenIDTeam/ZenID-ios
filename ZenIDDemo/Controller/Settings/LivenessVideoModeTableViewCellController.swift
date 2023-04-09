import UIKit

final class LivenessVideoModeTableViewCellController: TableCellController {
    private let service: ConfigService

    init(service: ConfigService) {
        self.service = service
    }

    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.reuseIdentifier, for: indexPath) as! SwitchTableViewCell
        removeAllTargets(of: cell.valueSwitch)
        cell.title.text = NSLocalizedString("settings-selfie-mode-video", comment: "")
        cell.valueSwitch.isOn = service.load().isLivenessVideo
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
        try? service.update(isLivenessVideo: sender.isOn)
    }
}

final class NfcReaderTableViewCellController: TableCellController {
    private let nfcStateProvider: NfcStateProvider

    init(nfcStateProvider: NfcStateProvider) {
        self.nfcStateProvider = nfcStateProvider
    }

    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.reuseIdentifier, for: indexPath) as! SwitchTableViewCell
        removeAllTargets(of: cell.valueSwitch)
        cell.title.text = NSLocalizedString("settings-nfc-enabled", comment: "")
        cell.valueSwitch.isOn = (try? nfcStateProvider.load()) ?? false
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
        nfcStateProvider.save(isEnabled: sender.isOn, completion: { _ in })
    }
}
