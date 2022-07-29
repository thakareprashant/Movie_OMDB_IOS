//
//  ViewController.swift
//  MovieOMDB
//
//  Created by prashant thakare on 13/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:_ IB OUtlets
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Declaring model here
   
    var movieListViewModel:MovieListViewModel?
    var movieModel:MovieModel?
    var searchModel:[search]?
    var searchViewModel:SearchMovieViewModel?
    
    //MARK:- View controller cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    override func viewDidAppear(_ animated: Bool) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
       
        Globals.fetchingDataFromLocalStorage(model: [search]()) { result in
            self.searchViewModel = SearchMovieViewModel(searchData: result?.reversed())
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }



        }
        
        
    }
    @IBOutlet weak var hideBtn: UIButton!
    var viewDemo = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        UIChanges()
        
        
        // Do any additional setup after loading the view.
    }
    //MARK:-UI CHANGES starting of page
    private func UIChanges(){
        searchViewHeight.constant = 0;
        loader.isHidden = true;
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        viewDemo.text = ResultError.notFound.rawValue
        viewDemo.font = UIFont(name: "Futura", size: 12);
        viewDemo.frame = CGRect(x:screenWidth/2.5, y: screenHeight/2.5, width: 200*deviceMultiplier, height: 70*deviceMultiplier)
        //viewDemo.backgroundColor = .red
        self.view.addSubview(viewDemo)
        viewDemo.isHidden = true
        hideBtn.isHidden = true
    }
    
    //MARK:- IB ACTIONS
    
    
    @IBAction func didTapHideSearch(_ sender: UIButton) {
        searchBar.resignFirstResponder()
        hideBtn.isHidden = true
        searchViewHeight.constant = 0
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    //MARK:- fetching data from API
    
    
    func apiCalling(query:String){
        loader.isHidden = false
        loader.startAnimating()
        let url = baseUrl+movieListUrl+query+apiKey;
        WebService.shared.apiCalling(url:url, Request: [:], Response: movieModel) { (isSuccess, result) in
            
            if(isSuccess){
                guard let result = result else {
                    
                    fatalError("decoding Error");
                }
              
                self.movieListViewModel = MovieListViewModel(MovieList: result?.Search ?? [])
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else{
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.loader.isHidden = true
                }
                
            }
            
        }
    }
    
    
}
//MARK:- tableview methods
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel?.numberOfRowsInSections(section) ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell else{
            return UITableViewCell();
        }
        guard  let model = movieListViewModel?.movieAtIndex(indexPath.row) else{
            return cell
        }
        cell.configureCell(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        movieListViewModel?.saveData(index: indexPath.row)
        
        guard  let vc = storyboard?.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController else{
            return
        }
        
        vc.imdbId = movieListViewModel?.movieAtIndex(indexPath.row).search.imdbID ?? ""
        
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
//MARK:- Search bar delegate method
extension ViewController:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        
        if searchViewModel?.searchData != nil{
            self.searchViewHeight.constant = 119
            hideBtn.isHidden = false
            UIView.animate(withDuration: 0.8) {
                
                self.view.layoutIfNeeded()
                
            }
            
        }
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if let text = searchBar.text{
            
            apiCalling(query: text)
        }
    }
}

//MARK:tableview cycle
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchViewModel?.searchData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecentSearchCollectionViewCell else{
            return UICollectionViewCell();
            
        }
        cell.loader.startAnimating()
        if let url = URL(string:searchViewModel?.searchData?[indexPath.row].Poster ?? ""){
            cell.imageV.load(url: url) { (isSucesss) in
                DispatchQueue.main.async {
                    cell.loader.stopAnimating()
                    cell.loader.isHidden = true
                }
                
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard  let vc = storyboard?.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController else{
            return
        }
        vc.imdbId = searchViewModel?.searchData?[indexPath.row].imdbID ?? ""
        vc.title = "Movie Details"
        
        // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3, height:collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}



enum ResultError:String{
    case notFound = "Result not found";
    case alert = "Alert!!!"
}
