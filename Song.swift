//
//  Song.swift
//  iOS Example
//
//  Created by Lin Shi on 13/10/2015.
//  Copyright © 2015 Alamofire. All rights reserved.
//

import Foundation
import CoreData

class Song: NSManagedObject {

    class func createNewSong(localPath:String)  {
        let item = NSEntityDescription.insertNewObjectForEntityForName("Song", inManagedObjectContext: CoreDataManager.manager.managedObjectContext)
        item .setValue(localPath, forKey: "localPath")
        
    }

}
