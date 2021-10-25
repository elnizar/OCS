//
//  ViewController.swift
//  OCS
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import UIKit
import Combine

@available(iOS 13.0, *)
class HomeViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UISearchBarDelegate , UICollectionViewDelegateFlowLayout {
    
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var programView: UICollectionView!
    
    // MARK: Variable
    var program : Programme?
    var viewModel = HomeViewModel()
    var bag = Set<AnyCancellable>()
    var titleT = ""
    var subTitle = ""
    var urlProgram = ""
    var uImage = UIImage()
    var indexPathVC : IndexPath!
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        programView.register(UINib.init(nibName: "ProgrammeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "programmeViewCell")
        setViewModel(viewModel)
        bindViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    private func setViewModel(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    private func bindViewModel() {
        viewModel.errorFromServer.sink(receiveValue: {
            isError  in
            if isError {
                showError(errorDescription: NSLocalizedString("ErrorServer", comment: ""))
            }
            
        }).store(in: &bag)
        viewModel.connexion.sink(receiveValue: {
            isError  in
            if isError {
                showError(errorDescription: NSLocalizedString("NoConnection", comment: ""))
            }
            
        }).store(in: &bag)
        viewModel.programme.sink(receiveValue: {
            programme in
            
            self.program = programme
            self.programView.reloadData()
            
        }).store(in: &bag)
    }
    
    // MARK: collectionView Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let programme = program?.count else{
            return 0
        }
        return programme
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = programView.dequeueReusableCell(withReuseIdentifier: "programmeViewCell", for: indexPath) as! ProgrammeCollectionViewCell
        guard let title = program?.contents![indexPath.row].title![0].value else {
            return cell
        }
        guard let subTitle = program?.contents![indexPath.row].subtitle else {
            return cell
        }
        cell.titleLabel.text = title
        cell.subtitleLabel.text = subTitle
        guard let image = program?.contents![indexPath.row].imageurl else {
            return cell
        }
        let url = Constants.API_URL + image
        
        viewModel.loadImage(imageUrl: url) { (data) in
            guard let dataImg = data else {
                return
            }
            if dataImg.isEmpty {
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(named: "movie")
                }
            }else{
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: dataImg)
                }

            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout a: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 15, height: self.view.frame.width/2 - 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let titleCheck = program?.contents![indexPath.row].title![0].value {
            titleT = titleCheck
        }
        if let sub = program?.contents![indexPath.row].subtitle {
            subTitle = sub
        }
        
        if let urlPr = program?.contents![indexPath.row].detaillink  {
            urlProgram = Constants.API_URL + urlPr
        }
        performSegue(withIdentifier: "vcToVideo", sender: nil)

    }
    
    // MARK: searchBar Method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.programmeTitle.send(searchText)
        self.viewModel.getProgramme()
    }
    
    // MARK: navigation Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VideoViewController {
            let videoVM = self.viewModel.VideoVM(subtitle: subTitle, titleT: titleT, urlPrg: urlProgram)

            let vc = segue.destination as? VideoViewController
            vc?.initViewMode(viewModel: videoVM)
        }
    }

    

    

    
}

