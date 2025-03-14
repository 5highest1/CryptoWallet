import UIKit
import SnapKit

class SortMenu: UIView {
    
    private let ascendingButton = UIButton(type: .system)
    private let descendingButton = UIButton(type: .system)
    
    var onAscending: (() -> Void)?
    var onDescending: (() -> Void)?
    
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
        
        ascendingButton.setTitle("По возрастанию", for: .normal)
        ascendingButton.addTarget(self, action: #selector(didTapAscending), for: .touchUpInside)
        ascendingButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 18)
        ascendingButton.setTitleColor(.black, for: .normal)
        ascendingButton.contentHorizontalAlignment = .left
        
        descendingButton.setTitle("По убыванию", for: .normal)
        descendingButton.addTarget(self, action: #selector(didTapDescending), for: .touchUpInside)
        descendingButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 18)
        descendingButton.setTitleColor(.black, for: .normal)
        descendingButton.contentHorizontalAlignment = .left
        
        let stackView = UIStackView(arrangedSubviews: [ascendingButton, descendingButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func didTapAscending() {
        onAscending?()
        self.removeFromSuperview()
    }
    
    @objc private func didTapDescending() {
        onDescending?()
        self.removeFromSuperview()
    }
}
