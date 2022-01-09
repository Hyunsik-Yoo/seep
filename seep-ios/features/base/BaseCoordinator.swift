import UIKit

protocol BaseCoordinator {
    var presenter: BaseVC { get }
    
    func popup(animated: Bool)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

extension BaseCoordinator where Self: BaseVC {
    var presenter: BaseVC {
        return self
    }
    
    func popup(animated: Bool = true) {
        self.presenter.navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.presenter.dismiss(animated: true, completion: nil)
    }
}
