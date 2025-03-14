import UIKit
import SnapKit

class CustomMenu: UIView {
    
    private let refreshButton = UIButton(type: .system)
    private let logoutButton = UIButton(type: .system)
    
    var onRefresh: (() -> Void)?
    var onLogout: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        if let refreshImage = UIImage(named: "free-icon-font-rocket-lunch-6955628") {
            refreshButton.setImage(refreshImage, for: .normal)
        }
        refreshButton.setTitle("Обновить", for: .normal)
        refreshButton.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)
        refreshButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 18)
        refreshButton.setTitleColor(.black, for: .normal)
        refreshButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        refreshButton.contentHorizontalAlignment = .left
        refreshButton.tintColor = .gray
        
        if let logoutImage = UIImage(named: "free-icon-font-trash-39173781") {
            logoutButton.setImage(logoutImage, for: .normal)
        }
        logoutButton.setTitle("Выйти", for: .normal)
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        logoutButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 18)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        logoutButton.contentHorizontalAlignment = .left
        logoutButton.tintColor = .gray

        let stackView = UIStackView(arrangedSubviews: [refreshButton, logoutButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }

    @objc private func didTapRefresh() {
        onRefresh?()
        self.removeFromSuperview()
    }
    
    @objc private func didTapLogout() {
        onLogout?()
        self.removeFromSuperview()
    }
}
