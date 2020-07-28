//
//  ViewCoreData.swift
//  Sims School
//
//  Created by João Damazio on 24/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import Foundation
import CoreData

class CoreDataHelper {
	static let shared = CoreDataHelper()
	
	func deleteAllData() {
		let entities = [
			UserEntity.entity().managedObjectClassName,
			CalendarEntity.entity().managedObjectClassName,
			ClassEntity.entity().managedObjectClassName,
			ScoreEntity.entity().managedObjectClassName,
			SemesterEntity.entity().managedObjectClassName,
			TipsEntity.entity().managedObjectClassName,
			TipsMediasEntity.entity().managedObjectClassName,
			UserEntity.entity().managedObjectClassName
		]
		
		entities.forEach { entity in
			self.delete(entity: entity!)
		}
	}
	
	
	private func delete(entity: String)
	{
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
		
		do {
			try context.execute(deleteRequest)
			try context.save()
		} catch {
			print ("There was an error")
		}
		
	}
}
