import UIKit


protocol CryptoHeaderViewDelegate: AnyObject {
    func refreshCryptoList()
    func logOut()
}

final class CryptoHeaderView: UIView {
    
    weak var delegate: CryptoHeaderViewDelegate?
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let learnMoreButton = UIButton()
    private let iconButton = UIButton()
    private let otherImageView = UIImageView()

    private var menu: CustomMenu?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.pink1
    
        titleLabel.text = "Home"
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        titleLabel.textColor = UIColor.white
        
        subtitleLabel.text = "Affiliate program"
        subtitleLabel.font = UIFont(name: "Poppins-Medium", size: 20)
        subtitleLabel.textColor = UIColor.white
        
        learnMoreButton.setTitle("Learn more", for: .normal)
        learnMoreButton.backgroundColor = .white
        learnMoreButton.setTitleColor(.black, for: .normal)
        learnMoreButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        learnMoreButton.layer.cornerRadius = 18

        iconButton.setImage(UIImage(named: "more"), for: .normal)
        iconButton.tintColor = .white
        iconButton.backgroundColor = .white.withAlphaComponent(0.8)
        iconButton.layer.cornerRadius = 24
        iconButton.layer.masksToBounds = true
        iconButton.addTarget(self, action: #selector(didTapIconButton), for: .touchUpInside)

        otherImageView.image = UIImage(named: "other5")
        otherImageView.contentMode = .scaleAspectFit

        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(learnMoreButton)
        addSubview(iconButton)
        addSubview(otherImageView)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(25)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(46)
            make.left.equalToSuperview().offset(25)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(25)
            make.width.equalTo(127)
            make.height.equalTo(35)
        }
        
        iconButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.right.equalToSuperview().offset(-25)
            make.height.width.equalTo(48)
        }

        otherImageView.snp.makeConstraints { make in
            make.top.equalTo(iconButton.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(30)
            make.width.height.equalTo(242)
        }
    }
    
    @objc private func didTapIconButton() {
        if let existingMenu = menu {
            existingMenu.removeFromSuperview()
            menu = nil
        } else {
            menu = CustomMenu()
            
            menu?.onRefresh = { [weak self] in
                self?.refreshData()
                self?.menu?.removeFromSuperview()
                self?.menu = nil
            }
            
            menu?.onLogout = { [weak self] in
                self?.delegate?.logOut()
                self?.menu?.removeFromSuperview()
                self?.menu = nil
            }
            
            if let menu = menu {
                self.addSubview(menu)
                menu.snp.makeConstraints { make in
                    make.top.equalTo(iconButton.snp.bottom).offset(8)
                    make.right.equalToSuperview().offset(-29)
                    make.width.equalTo(157)
                    make.height.equalTo(102)
                }
            }
        }
    }

    private func refreshData() {
        delegate?.refreshCryptoList()
    }
}

