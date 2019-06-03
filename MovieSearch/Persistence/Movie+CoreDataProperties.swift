//
//  Movie+CoreDataProperties.swift
//  MovieSearch
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

	@NSManaged public var moviePlot: String?
    @NSManaged public var posterUrl: String?
    @NSManaged public var movieTitle: String?
    @NSManaged public var movieWriters: String?
    @NSManaged public var movieDirector: String?
    @NSManaged public var movieActor: String?
    @NSManaged public var movieRating: String?

}
