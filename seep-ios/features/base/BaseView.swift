import UIKit
import Combine

import RxSwift
import SnapKit

class BaseView: UIView {
  
  var disposeBag = DisposeBag()
    var cancellables = Set<AnyCancellable>()
  
  private lazy var dimView = UIView(frame: self.frame).then {
    $0.backgroundColor = .clear
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    bindConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
    bindConstraints()
  }
  
  func setup() { }
  
  func bindConstraints() { }
  
  func showDim(isShow: Bool) {
    if isShow {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.addSubview(self.dimView)
        UIView.animate(withDuration: 0.3) {
          self.dimView.backgroundColor = UIColor.init(r: 0, g: 0, b: 0, a:0.5)
        }
      }
    } else {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        UIView.animate(withDuration: 0.3, animations: {
          self.dimView.backgroundColor = .clear
        }) { (_) in
          self.dimView.removeFromSuperview()
        }
      }
    }
  }
}
