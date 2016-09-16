//
//  TestAnimalRepository.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class TestAnimalRepository: IAnimalRepository {
    
    static let sharedInstance = TestAnimalRepository()
    
    var animals = [ Animal(name: "turtle",
                    description: "it's really Slooww.",
                        picture: "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRUgZ8DPCK_XVqfb6thS4tH1sbas1sefNwdQE3MoYmGioIMwnag"),
                    Animal(name: "pelican",
                    description: "nice peak",
                        picture: "http://www.outdooralabama.com/sites/default/files//images/Image/white-pelican-3.jpg"),
                    Animal(name: "tiger",
                    description: "be care always is angry",
                        picture: "http://vignette3.wikia.nocookie.net/spiritanimals/images/0/05/Tiger.jpg/revision/latest?cb=20140510200316"),
                    Animal(name: "lion",
                    description: "sometimes is really lazy",
                        picture: "http://www.universeofsymbolism.com/images/xlion-symbolism.jpg.pagespeed.ic.YPvRkLWxnO.jpg"),
                    Animal(name: "buffalo",
                    description: "it's really nice",
                        picture: "http://assets.bwbx.io/images/users/iqjWHBFdfxIU/i3Yp1mXpDIMA/v2/1200x-1.jpg"),
                    Animal(name: "elephant",
                    description: "it can't Jump :(",
                        picture: "http://res.cloudinary.com/dk-find-out/image/upload/q_80,w_1440/MA_00077427_yjtgnj.jpg"),
                    Animal(name: "fish",
                    description: "just tasty",
                        picture: "https://i.ytimg.com/vi/Tqkq4zUJ3Yw/maxresdefault.jpg"),
                    Animal(name: "eagle",
                    description: "eagle",
                        picture: "https://upload.wikimedia.org/wikipedia/commons/a/a7/Adler_jagt.jpg"),
                    Animal(name: "dog",
                    description: "nice to play with it",
                        picture: "https://s3.graphiq.com/sites/default/files/stories/t2/25_Loudest_Dog_Breeds_33246_17020.jpg"),
                    Animal(name: "cat",
                    description: "it don't like play to much",
                        picture: "https://pixabay.com/static/uploads/photo/2016/05/18/20/57/cat-1401557_960_720.jpg"),
                    Animal(name: "alligator",
                    description: "nice teeths",
                        picture: "http://animalsadda.com/wp-content/uploads/2013/04/Alligators.jpg"),
                    Animal(name: "crow",
                    description: "just scary",
                        picture: "https://www.allaboutbirds.org/guide/PHOTO/LARGE/american_crow_8.jpg"),
                    Animal(name: "squirrel",
                    description: "really nice tail",
                        picture: "https://upload.wikimedia.org/wikipedia/commons/d/d1/Indian_Palm_Squirrel_DS.jpg"),
                    Animal(name: "bear",
                    description: "what about a teddy hug",
                        picture: "http://animalia-life.com/data_images/bear/bear7.jpg"),
                    Animal(name: "castor",
                    description: "long teeths",
                        picture: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOLHDF1HRzBcuBmmY_KtCd7lx1aBzdRH79Vjvwo8zwb5mRg7EQ"),
                    Animal(name: "frog",
                    description: "don't try to lick it",
                        picture: "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTunuR0QjZxBDcpG5PtLC7aep17SCpkz8XAjjG1YCxXgu14bjcl")
    ]
    
    func findAnimals(completion: (success: [Animal]?, fail: NSError?) -> Void) {
        
        findAnimals(byName: nil, sortAsc: nil, currentPage: 1) { (success, fail) in
            completion(success: success, fail: fail)
        }
    }
    
    func findAnimals(byName name: String?, sortAsc isAsc: Bool? = true, currentPage page: Int, completion: (success: [Animal]?, fail: NSError?) -> Void) {
        
        let data = findSortedAnimals(byName: name, sortAsc: isAsc ?? true, page: page)
        completion(success: data, fail: nil)
        
    }

    private func findSortedAnimals(byName name: String?, sortAsc isAsc: Bool = true, page: Int) -> [Animal] {
        
        let orderCriteria = isAsc ? NSComparisonResult.OrderedAscending : NSComparisonResult.OrderedDescending
        var filtered = false
        var animals = self.animals
        if let name = name where !name.isEmpty {
            animals = self.animals.filter { $0.name!.containsString(name) }
            filtered = true
        }
        
        let sorted = animals.sort{ $0.name!.localizedCaseInsensitiveCompare($1.name!) == orderCriteria }

        if filtered {
            return sorted
        }
        
        let splitData = sorted.split()

        if  page == 1 {
            return splitData.left
        } else if page == 2 {
            return splitData.right
        }
        
        let emptyArray: [Animal] = []
        return emptyArray
    }
}
