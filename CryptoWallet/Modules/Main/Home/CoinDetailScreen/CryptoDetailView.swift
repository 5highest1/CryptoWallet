import UIKit
import SnapKit

final class CryptoDetailViewController: UIViewController {
    
    var presenter: CryptoDetailPresenter!
    
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    private let logoutButton = UIButton()
    private let nameAndSymbolStackView = UIStackView()
    private let supplyMarketCapView = UIView()
    private let supplyTitleLabel = UILabel()
    private let marketCapTitleLabel = UILabel()
    private let supplyValueLabel = UILabel()
    private let marketCapValueLabel = UILabel()
    private let segmentedControl = SegmentedControlView()
    private let priceChangeImageView = UIImageView()
    private let marketCapSubTitleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.loadCryptoDetails()
    }
    
    @objc private func logoutTapped() {
        presenter?.goBack()
    }
    
    private func setupUI() {
        view.backgroundColor = .white1
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        configureLabels()
        configurePriceChangeImageView()
        configureLogoutButton()
        configureStackView()
        configureSupplyMarketCapView()
        setupConstraints()
        setupSegmentedControl()
    }
    
    private func configurePriceChangeImageView() {
        priceChangeImageView.contentMode = .scaleAspectFit
        priceChangeImageView.tintColor = .black
    }
    
    
    private func configureLabels() {
        let labels = [(nameLabel, UIColor.blue1),
                      (symbolLabel, UIColor.blue1),
                      (priceLabel, UIColor.blue1),
                      (changeLabel, UIColor.gray1),
                      (supplyTitleLabel, UIColor.gray1),
                      (marketCapTitleLabel, UIColor.gray1),
                      (supplyValueLabel, UIColor.blue1),
                      (marketCapValueLabel, UIColor.blue1),
                      (marketCapSubTitleLabel, UIColor.blue1)]
        
        labels.forEach { label, color in
            label.textColor = color
        }
        
        supplyTitleLabel.text = "Circulating Supply"
        marketCapTitleLabel.text = "Market capitalization"
        marketCapSubTitleLabel.text = "Market Statistic"
        
        nameLabel.font = UIFont(name: "Poppins-Medium", size: 14)
        symbolLabel.font = UIFont(name: "Poppins-Medium", size: 14)
        priceLabel.font = UIFont(name: "Poppins-Medium", size: 28)
        changeLabel.font = UIFont(name: "Poppins-Medium", size: 14)
        supplyTitleLabel.font = UIFont(name: "Poppins-Medium", size: 14)
        marketCapTitleLabel.font = UIFont(name: "Poppins-Medium", size: 14)
        supplyValueLabel.font = UIFont(name: "Poppins-SemiBold", size: 14)
        marketCapValueLabel.font = UIFont(name: "Poppins-SemiBold", size: 14)
        marketCapSubTitleLabel.font = UIFont(name: "Poppins-Medium", size: 20
        )
    }
    
    private func configureLogoutButton() {
        logoutButton.setImage(UIImage(named: "back"), for: .normal)
        logoutButton.tintColor = .black
        logoutButton.backgroundColor = .white
        logoutButton.layer.cornerRadius = 24
        logoutButton.layer.masksToBounds = true
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    private func configureStackView() {
        nameAndSymbolStackView.axis = .horizontal
        nameAndSymbolStackView.spacing = 5
        nameAndSymbolStackView.alignment = .center
        nameAndSymbolStackView.addArrangedSubview(nameLabel)
        nameAndSymbolStackView.addArrangedSubview(symbolLabel)
    }
    
    private func configureSupplyMarketCapView() {
        supplyMarketCapView.backgroundColor = UIColor.white4
        supplyMarketCapView.layer.cornerRadius = 20
        supplyMarketCapView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] 
        supplyMarketCapView.layer.shadowColor = UIColor.black.cgColor
        supplyMarketCapView.layer.shadowOpacity = 0.1
        supplyMarketCapView.layer.shadowOffset = CGSize(width: 0, height: 2)
        supplyMarketCapView.layer.shadowRadius = 4
        
        supplyMarketCapView.addSubview(marketCapSubTitleLabel)
        supplyMarketCapView.addSubview(supplyTitleLabel)
        supplyMarketCapView.addSubview(marketCapTitleLabel)
        supplyMarketCapView.addSubview(supplyValueLabel)
        supplyMarketCapView.addSubview(marketCapValueLabel)
    }

    
    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(changeLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func setupConstraints() {
        view.addSubview(nameAndSymbolStackView)
        view.addSubview(priceLabel)
        view.addSubview(changeLabel)
        view.addSubview(logoutButton)
        view.addSubview(supplyMarketCapView)
        view.addSubview(priceChangeImageView)
        
        nameAndSymbolStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameAndSymbolStackView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(25)
            make.height.width.equalTo(48)
        }
        
        supplyMarketCapView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(160)
        }
        
        marketCapSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(supplyMarketCapView.snp.top).offset(25)
            make.left.equalToSuperview().offset(25)
        }
        
        marketCapTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapSubTitleLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(25)
        }
        
        marketCapValueLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapTitleLabel)
            make.right.equalToSuperview().offset(-25)
        }
        
        supplyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(25)
        }
        
        supplyValueLabel.snp.makeConstraints { make in
            make.top.equalTo(supplyTitleLabel)
            make.right.equalToSuperview().offset(-25)
        }
        
        priceChangeImageView.snp.makeConstraints { make in
            make.centerY.equalTo(changeLabel)
            make.right.equalTo(changeLabel.snp.left).offset(-5)
        }
    }
}

extension CryptoDetailViewController: CryptoDetailView {
    func updateCryptoDetails(viewModel: CryptoDetailViewModel) {
        nameLabel.text = viewModel.name
        symbolLabel.text = "(\(viewModel.symbol))"
        
        if let priceValue = Double(viewModel.price) {
            priceLabel.text = "$\(formatNumber(priceValue))"
        }
        
        if let change1hValue = Double(viewModel.change1h) {
            changeLabel.text = "\(formatNumber(abs(change1hValue)))%" 
            
            let imageName = change1hValue >= 0 ? "arrowup" : "arrowdown"
            priceChangeImageView.image = UIImage(named: imageName)
        }
        
        marketCapValueLabel.text = "$\(formatNumber(viewModel.marketCap))"
        supplyValueLabel.text = "\(formatNumber(viewModel.suply)) \(viewModel.symbol)"
    }
}

private extension CryptoDetailViewController {
    func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "en_US")
        
        let formattedString = formatter.string(from: NSNumber(value: number)) ?? "\(number)"
        let components = formattedString.split(separator: ",")
        
        if components.count > 2 {
            return components[0] + "," + components[1]
        }
        
        return formattedString
    }
}
