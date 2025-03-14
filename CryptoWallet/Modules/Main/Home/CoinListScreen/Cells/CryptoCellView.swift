import UIKit

final class CryptoCellView: UITableViewCell {
    
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let changeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(changeLabel)
        contentView.addSubview(changeIconImageView)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        nameLabel.font = UIFont(name: "Poppins-Medium", size: 18)
        nameLabel.textColor = UIColor.blue1
        
        symbolLabel.font = UIFont(name: "Poppins-Medium", size: 14)
        symbolLabel.textColor = UIColor.gray1
        
        priceLabel.font = UIFont(name: "Poppins-Medium", size: 18)
        priceLabel.textColor = UIColor.blue1
        
        changeLabel.font = UIFont(name: "Poppins-Medium", size: 14)
        changeLabel.textColor = UIColor.gray1
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(25)
            make.width.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(iconImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(15)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(iconImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(15)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.right.equalToSuperview().inset(25)
        }
        
        changeIconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(changeLabel)
            make.left.equalTo(changeLabel).offset(-20)
            make.width.height.equalTo(16)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func configureChangeIcon(for priceChange: Double) {
        let imageName: String
        if priceChange >= 0 {
            imageName = "arrowup"
        } else {
            imageName = "arrowdown"
        }
        changeIconImageView.image = UIImage(named: imageName)
        changeIconImageView.tintColor = changeLabel.textColor
    }
    
    func configure(with crypto: Cryptocurrency) {
        let formattedPrice = String(format: "%.2f", crypto.price)
        priceLabel.text = "$\(formattedPrice)"
        
        let formattedChange = String(format: "%.1f%%", abs(crypto.priceChange1h))
        changeLabel.text = formattedChange
        
        nameLabel.text = crypto.name.capitalized
        symbolLabel.text = crypto.symbol
        iconImageView.image = UIImage(named: crypto.iconName)
        
        configureChangeIcon(for: crypto.priceChange1h)
    }

}
