//
//  MovieListViewController.swift
//  MovieOMDB
//
//  Created by prashant thakare on 13/07/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var moviePosterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleDescLbl: UILabel!
    @IBOutlet weak var fullDesclbl: UILabel!
    @IBOutlet weak var directorLbl: UILabel!
    @IBOutlet weak var actorsLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var awardsLbl: UILabel!
    @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var reviewsCountLbl: UILabel!
    
    private var movieDetailModel:MovieDetail?
    var movieDetailVM:MovieDetailViewModel?
    //Using this imdb variable we are getting imdb id from previus controller
    var imdbId = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiCalling();
        

        // Do any additional setup after loading the view.
    }
    
    //MARK:- fetching data from API
    private func apiCalling(){
        print(imdbId)
        loader.startAnimating()
        let url = baseUrl+movieDetailUrl+imdbId+apiKey
        WebService.shared.apiCalling(url: url, Request: [:], Response: movieDetailModel) { (isSuccess, result) in
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.loader.isHidden = true;
            }
            if(isSuccess){
               
                guard let result = result else {
                    fatalError("decoding Error");
                }
                
                DispatchQueue.main.async {
                    self.movieDetailVM = MovieDetailViewModel(result!);
                    self.setData();
                    
                }
               
                
                
            }
        }
    }
    //MARK:- setting up all the data
    private func setData(){
    
        if let urlImg = URL(string:movieDetailVM?.movieDetail.Poster ?? ""){
            moviePosterImg.load(url: urlImg) { (isSuccess) in
                
            };
        }
        
        titleLbl.text = "\(movieDetailVM?.movieDetail.Title ?? "") (\(movieDetailVM?.movieDetail.Year ?? ""))"
        titleDescLbl.text = movieDetailVM?.movieDetail.Rated
        fullDesclbl.text = movieDetailVM?.movieDetail.Plot
        likeCountLbl.text = movieDetailVM?.movieDetail.imdbVotes
        reviewsCountLbl.text = movieDetailVM?.movieDetail.imdbRating
        //directorLbl.text = "Director : \(movieDetailModel?.Director ?? "")"
        directorLbl.attributedText = Globals.shared.getAttrString(str1: MovieDetailEnum.director.rawValue, str2: movieDetailVM?.movieDetail.Director ?? "")
        actorsLbl.attributedText = Globals.shared.getAttrString(str1: MovieDetailEnum.actor.rawValue, str2: movieDetailVM?.movieDetail.Actors ?? "")
        languageLbl.attributedText = Globals.shared.getAttrString(str1:  MovieDetailEnum.Language.rawValue, str2: movieDetailVM?.movieDetail.Language ?? "")
        releaseDateLbl.attributedText = Globals.shared.getAttrString(str1: MovieDetailEnum.releasedDate.rawValue, str2: movieDetailVM?.movieDetail.Released ?? "")
        awardsLbl.attributedText = Globals.shared.getAttrString(str1: MovieDetailEnum.awards.rawValue, str2: movieDetailVM?.movieDetail.Awards ?? "")
        countryLbl.attributedText = Globals.shared.getAttrString(str1: MovieDetailEnum.country.rawValue, str2: movieDetailVM?.movieDetail.Country ?? "")
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK:- enum for movies detail
enum MovieDetailEnum:String{
    case director = "Director : "
    case actor = "Actor : "
    case Language = "Language : "
    case releasedDate = "Released Date : "
    case awards = "Awards : "
    case country = "Country : "
    
    
}
