import UIKit
import SnapKit

final class CryptoListViewController: UIViewController, CryptoListView, CryptoHeaderViewDelegate {

    var presenter: CryptoListPresenter!
    
    private var cryptocurrencies: [Cryptocurrency] = []
    private var sortMenu: SortMenu?
    
    private let sortButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let headerView = CryptoHeaderView()
    private let tableView = UITableView()
    private let stackView = UIStackView()
    private let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.fetchCryptocurrencies()
    }

    private let sortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.font = UIFont(name: "Poppins-Medium", size: 20)
        label.textColor = .black
        return label
    }()

    func logOut() {
        presenter.logOut()
    }

    private func setupUI() {
        view.backgroundColor = .white2
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(600)
        }
        headerView.delegate = self
        
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(sortTitleLabel)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(sortButton)

        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.left.right.equalToSuperview().inset(25)
        }

        sortButton.setImage(UIImage(named: "Searchicon"), for: .normal)
        sortButton.tintColor = .black
        sortButton.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white2
        tableView.register(CryptoCellView.self, forCellReuseIdentifier: "CryptoCellView")
        tableView.separatorStyle = .none

        containerView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }

        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(278)
            make.left.right.bottom.equalToSuperview()
        }

        containerView.backgroundColor = .white2
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true

        containerView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }

    @objc
    private func didTapSortButton() {
        if let existingMenu = sortMenu {
            existingMenu.removeFromSuperview()
            sortMenu = nil
        } else {
            sortMenu = SortMenu()
            
            sortMenu?.onAscending = { [weak self] in
                self?.sortData(ascending: true)
                self?.sortMenu?.removeFromSuperview()
                self?.sortMenu = nil
            }
            
            sortMenu?.onDescending = { [weak self] in
                self?.sortData(ascending: false)
                self?.sortMenu?.removeFromSuperview()
                self?.sortMenu = nil
            }

            if let menu = sortMenu {
                view.addSubview(menu)
                menu.snp.makeConstraints { make in
                    make.top.equalTo(sortButton.snp.bottom).offset(8)
                    make.right.equalTo(sortButton.snp.right)
                    make.width.equalTo(180)
                    make.height.equalTo(102)
                }
            }
        }
    }

    private func sortData(ascending: Bool) {
        cryptocurrencies.sort { ascending ? $0.price < $1.price : $0.price > $1.price }
        tableView.reloadData()
    }

    func updateCryptoList(cryptos: [Cryptocurrency]) {
        activityIndicator.stopAnimating()

        guard cryptocurrencies.count == cryptos.count else {
            cryptocurrencies = cryptos
            tableView.reloadData()
            return
        }

        let updatedCryptosDict = Dictionary(uniqueKeysWithValues: cryptos.map { ($0.symbol, $0) })
        
        var indexPathsToUpdate = [IndexPath]()

        for (index, oldCrypto) in cryptocurrencies.enumerated() {
            if let newCrypto = updatedCryptosDict[oldCrypto.symbol], newCrypto.price != oldCrypto.price {
                cryptocurrencies[index] = newCrypto
                indexPathsToUpdate.append(IndexPath(row: index, section: 0))
            }
        }
        
        if !indexPathsToUpdate.isEmpty {
            tableView.reloadRows(at: indexPathsToUpdate, with: .none)
        }
    }

    func showError(message: String) {
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(title: "Ошибка",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        present(alert, animated: true)
    }

    func refreshCryptoList() {
        presenter?.fetchCryptocurrencies()
        
        let indexPaths = (0..<cryptocurrencies.count).map { IndexPath(row: $0, section: 0) }
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }

    private func navigateToLogin() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        UIApplication.shared.windows.first?.rootViewController = navController
    }
}

extension CryptoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int
    ) -> Int {
        return cryptocurrencies.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCellView", for: indexPath) as! CryptoCellView
        let crypto = cryptocurrencies[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: crypto)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath
    ) {
        let selectedCrypto = cryptocurrencies[indexPath.row]
        presenter?.didSelectCrypto(cryptocurrency: selectedCrypto)
    }
}


