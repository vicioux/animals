# Animals
 
This excercise show a list of animals, and it can be filtered, or sorted. uses a pattern called cleanSwift http://clean-swift.com/ and a repository pattern.
this architecture is more about Protocol Oriented Programing 

Used libraries:
* cache data
    *  https://github.com/Haneke/HanekeSwift

* object mapper
    * https://github.com/bryx-inc/BRYXBanner

* infinite scroll
    * https://github.com/pronebird/UIScrollView-InfiniteScroll

* alamofire
    * https://github.com/Alamofire/Alamofire

* ObjectMapper
    * https://github.com/Hearst-DD/ObjectMapper

* SkyFloatingLabelTextField
    * https://github.com/Skyscanner/SkyFloatingLabelTextField

Pd: just open animals.xcworkspace

# Response to questions 5 and 6.

5. To accomplish this i used the Repository Pattern, creating a testing repository to get filtered, sorted and paginated dummy data, leaving the responsability to get data no matter how. It can be switched changin a variable to false in the repositoryLocator.
6. The simplest approach to this is using a paginated list and leave responsibility to the "web service"