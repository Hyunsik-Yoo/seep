import UIKit

import CombineCocoa

final class HomeWishGridCell: BaseCollectionViewCell {
    enum Layout {
        static let size = CGSize(
            width: (UIUtils.windowBounds.width - 40 - 15) / 2,
            height: ((UIScreen.main.bounds.width - 40 - 15) / 2) * 1.09
        )
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray5
        label.numberOfLines = 2
        label.font = .appleSemiBold(size: 16)
        return label
    }()
    
    private let ddayLabel = DdayLabel()
    
    private let tagLabel = TagLabel()
    
    private let finishButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.Icons.icCheckOff.image.resizeImage(scaledTo: 30), for: .normal)
        button.setImage(Assets.Icons.icCheckOn.image.resizeImage(scaledTo: 30), for: .selected)
        return button
    }()
    
    override func setup() {
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.attributedText = nil
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        contentView.addSubview(emojiLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ddayLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(finishButton)
        
        containerView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        
        emojiLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.top.equalToSuperview().offset(14)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.top.equalTo(emojiLabel.snp.bottom).offset(4)
        }
        
        finishButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-14)
            $0.bottom.equalToSuperview().offset(-14)
            $0.size.equalTo(30)
        }
    }
    
    func bind(viewModel: HomeWishCellViewModel) {
        setupWish(viewModel.output.wish)
        
        finishButton.tapPublisher
            .subscribe(viewModel.input.didTapFinish)
            .store(in: &cancellables)
    }
    
    func setupWish(_ wish: Wish) {
        emojiLabel.text = wish.emoji
        titleLabel.text = wish.title
        ddayLabel.bind(dday: wish.endDate)
        finishButton.isSelected = wish.isSuccess
        
        tagLabel.isHidden = wish.hashtag.isEmpty
        if wish.hashtag.isEmpty {
            ddayLabel.snp.removeConstraints()
            ddayLabel.snp.makeConstraints {
                $0.left.equalTo(titleLabel)
                $0.bottom.equalTo(finishButton)
            }
        } else {
            tagLabel.text = HashtagType(rawValue: wish.hashtag)?.description ?? wish.hashtag
            
            ddayLabel.snp.removeConstraints()
            tagLabel.snp.removeConstraints()
            ddayLabel.snp.makeConstraints {
                $0.leading.equalTo(titleLabel)
                $0.bottom.equalTo(tagLabel.snp.top).offset(-6)
            }
            
            tagLabel.snp.makeConstraints {
                $0.left.height.equalTo(ddayLabel)
                $0.bottom.equalTo(finishButton)
            }
        }
        
        if wish.isSuccess {
            emojiLabel.alpha = 0.5
            titleLabel.alpha = 0.5
            
            let attributedString = NSMutableAttributedString(string: wish.title)
            attributedString.addAttributes([
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .strikethroughColor: UIColor.gray4.copy()
            ], range: NSRange(location: 0, length: wish.title.count))
            titleLabel.attributedText = attributedString
            
            ddayLabel.alpha = 0.5
            tagLabel.alpha = 0.5
        } else {
            emojiLabel.alpha = 1
            titleLabel.alpha = 1
            ddayLabel.alpha = 1
            tagLabel.alpha = 1
        }
    }
}
