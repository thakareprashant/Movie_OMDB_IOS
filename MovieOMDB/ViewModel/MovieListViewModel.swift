//
//  MovieListViewModel.swift
//  MovieOMDB
//
//  Created by prashant thakare on 26/07/22.
//

import Foundation
struct SearchMovieViewModel{
    
    var searchData:[search]?
}
struct SearchModel{
    var search:search
    init(_ search:search){
        self.search = search
    }
}
struct MovieListViewModel{
    let MovieList:[search]?
    
    
//     func getSavedData()->[MovieListViewModel]{
//         var move:[MovieListViewModel]?
//        Globals.fetchingDataFromLocalStorage(model: searchData!) { result in
//            move =
//
//
//
//        }
//         return move!
    //}
    func saveData(index:Int){
        let userDefaults = UserDefaults.standard
        if var searchSaveModel = try? userDefaults.getObject(forKey: "searchItems", castTo: [search].self) {
            if let searchM = MovieList?[index]{
                if searchSaveModel.count == 0 {
                    searchSaveModel.append(searchM)
                }
                
                else{
                    if searchSaveModel.count >= 10{
                        searchSaveModel.removeFirst()
                    }
                    var isFound = false;
                    
                    searchSaveModel.forEach { (obj) in
                        if(obj.Title == searchM.Title){
                            isFound = true;
                            
                        }
                        
                    }
                    
                    if(!isFound){
                        searchSaveModel.append(searchM)
                    }
                    
                }
                
            }
            
            do {
                try userDefaults.setObject(searchSaveModel, forKey: "searchItems")
            } catch {
                print(error.localizedDescription)
            }
        }
        else{
            let searchM = (MovieList?[index])!;
            var sea = [search]();
            sea.append(searchM)
            do {
                try userDefaults.setObject(sea, forKey: "searchItems")
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
}
extension MovieListViewModel{
    var numberOfSections:Int{
        return 1
    }
    func numberOfRowsInSections(_ section:Int) -> Int{
        return self.MovieList!.count
    }
    func movieAtIndex(_ index:Int) -> MovieViewModel{
        let movies = self.MovieList![index]
        return MovieViewModel(movies)
    }
}
struct MovieViewModel{
    
    let search:search
   
}
extension MovieViewModel{
    
    init(_ MovieModel:search){
        self.search = MovieModel
    }
}


