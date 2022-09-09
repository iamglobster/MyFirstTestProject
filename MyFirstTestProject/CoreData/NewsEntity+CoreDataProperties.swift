//
//  NewsEntity+CoreDataProperties.swift
//  
//
//  Created by Yaroslav on 09.09.2022.
//
//

import Foundation
import CoreData


extension NewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }

    @NSManaged public var imageNewsEntity: URL
    @NSManaged public var titleNewsEntity: String
    @NSManaged public var id: UUID

}
