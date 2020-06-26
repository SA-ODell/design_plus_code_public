//
//  CoreData.swift
//  DesignCodeApp
//
//  Created by Meng To on 2017-08-14.
//  Copyright © 2017 Meng To. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataService {
    
    static let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Chapter
    static func addChapter(title: String, caption: String, image: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Chapter", in: managedContext)!
        let chapter = NSManagedObject(entity: entity, insertInto: managedContext)
        chapter.setValue(title, forKey: "title")
        chapter.setValue(caption, forKey: "caption")
        chapter.setValue(image, forKey: "image")
        
        do {
            try managedContext.save()
            print("Saved chapter")
        } catch let error as NSError {
            print(error)
        }
    }
    
    // Page
    static func addPage(title: String, caption: String, body: String, image: String, video: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Page", in: managedContext)!
        let page = NSManagedObject(entity: entity, insertInto: managedContext)
        page.setValue(title, forKey: "title")
        page.setValue(caption, forKey: "caption")
        page.setValue(body, forKey: "body")
        page.setValue(image, forKey: "image")
        page.setValue(video, forKey: "video")
        
        let chapters = fetch(entityName: "Chapter")
        for chapter in chapters {
            if chapter.value(forKey: "title") as! String == "Learn iOS Design" {
                let pages = chapter.mutableSetValue(forKey: "pages")
                pages.add(page)
            }
        }
        
        do {
            try managedContext.save()
            print("Saved page")
        } catch let error as NSError {
            print(error)
        }
    }
    
    // Block
    static func addBlock(title: String, body: String, image: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Block", in: managedContext)!
        let block = NSManagedObject(entity: entity, insertInto: managedContext)
        block.setValue(title, forKey: "title")
        block.setValue(body, forKey: "body")
        block.setValue(image, forKey: "image")
        
        do {
            try managedContext.save()
            print("Saved block")
        } catch let error as NSError {
            print(error)
        }
    }
    
    // User
    static func login(email: String, password: String) {
        let users = fetch(entityName: "User")
        for user in users {
            if user.value(forKey: "email") as! String == email
                && user.value(forKey: "password") as! String == password {
                print("You're logged in!")
            } else {
                print("Wrong username or password")
            }
        }
    }
    
    // Add
    static func addUser(email: String, password: String) {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(email, forKeyPath: "email")
        user.setValue(password, forKeyPath: "password")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    // Delete
    static func deleteUser(email: String) {
        let users = fetch(entityName: "User")
        for user in users {
            if user.value(forKey: "email") as! String == email {
                managedContext.delete(user)
                print("User \(user.value(forKey: "email") as! String) was deleted")
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
    }
    
    // Fetch
    static func fetch(entityName: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let results = try! managedContext.fetch(fetchRequest)
        return results
    }
}
