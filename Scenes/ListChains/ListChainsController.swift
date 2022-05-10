import UIKit
import BookingUI

protocol ListChainsDisplayLogic: AnyObject {
    func displayState(_ state: ListChainsState)
}

final class ListChainsController: ViewController, ListChainsDisplayLogic {
    let interactor: ListChainsBusinessLogic
    
    init(interactor: ListChainsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dataSource = CollectionDataSource<ListChainsSectionID>(collectionView: collectionView)
    lazy var collectionView = UICollectionView.default

    override func loadView() {
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My bookings"
        configureCollectionView()
        
        displayState(.loading)
        interactor.fetchList()
    }

    override func updateStyle() {
        super.updateStyle()
        
        collectionView.backgroundColor = BUI.Color.backgroundBase.uiColor
    }
    
    func configureCollectionView() {
        collectionView.register(LabelCell.self, forCellWithReuseIdentifier: LabelViewModel.reuseIdentifier)
        collectionView.register(ChainCardCell.self, forCellWithReuseIdentifier: ChainCardViewModel.reuseIdentifier)
    }
    
    func displayState(_ state: ListChainsState) {
        view.removeLoading()
        switch state {
        case .result(let result):
            dataSource.sections = result
        case .error(let message):
            showAlert(message: message)
        case .loading:
            view.setLoading()
        }
    }
}

