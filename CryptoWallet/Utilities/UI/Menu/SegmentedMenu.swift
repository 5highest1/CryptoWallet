import UIKit

final class SegmentedControlView: UIView {
    
    private let stackView = UIStackView()
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0 {
        didSet { updateSelection() }
    }
    
    private let options = ["24H", "1W", "1Y", "ALL", "Point"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.white3
        layer.cornerRadius = 30
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        for (index, title) in options.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.backgroundColor = .clear
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            button.tag = index
            
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        updateSelection()
    }
    
    private func updateSelection() {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.backgroundColor = .white
                button.setTitleColor(.black, for: .normal)
                button.layer.shadowColor = UIColor.black.cgColor
                button.layer.shadowOpacity = 0.1
                button.layer.shadowOffset = CGSize(width: 0, height: 2)
                button.layer.shadowRadius = 4
            } else {
                button.backgroundColor = .clear
                button.setTitleColor(.gray, for: .normal)
                button.layer.shadowOpacity = 0
            }
        }
    }
    
    @objc private func segmentTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
}
