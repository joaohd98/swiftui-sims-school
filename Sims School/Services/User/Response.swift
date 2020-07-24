import SwiftUI
import CoreData
import FirebaseAuth

class UserResponse: ObservableObject {
	let entity = UserEntity.entity()
	@Published var uid: String
	@Published var name: String
	@Published var rm: String
	@Published var id_class: String
	@Published var actual_class: String
	@Published var course: String
	@Published var profile_picture: URL?
	@Published var cover_picture: URL?
	
	init(dictionary: [String: Any], group: DispatchGroup) {
		self.uid = dictionary["uid"] as! String
		self.name = dictionary["name"] as! String
		self.rm = dictionary["rm"] as! String
		self.id_class = dictionary["id_class"] as! String
		self.actual_class = dictionary["actual_class"] as! String
		self.course = dictionary["course"] as! String
		self.setPictures(
			coverPicture: dictionary["cover_picture"] as! String,
			profilePicture: dictionary["profile_picture"] as! String,
			group: group
		)
	}
	
	private func setPictures(coverPicture: String, profilePicture: String, group: DispatchGroup) {
		group.enter()
		
		FirebaseDatabase.storage.reference().child(coverPicture).downloadURL { url, error in
			if error == nil {
				self.cover_picture = url
			}
			
			group.leave()
		}
		
		group.enter()
		FirebaseDatabase.storage.reference().child(profilePicture).downloadURL { url, error in
			if error == nil {
				self.profile_picture = url
			}
			
			group.leave()
		}
		
	}
	
	func getContext(managedObjectContext: NSManagedObjectContext) {
		
		
	}
	
	func saveContext(managedObjectContext: NSManagedObjectContext) {
		do {
			let user = UserEntity(context: managedObjectContext)
			
			user.uid = self.uid
			user.name = self.name
			user.rm = self.rm
			user.actual_class = self.actual_class
			user.id_class = self.id_class
			user.course = self.course
			user.profile_picture = self.profile_picture
			user.cover_picture = self.cover_picture
			
			try managedObjectContext.save()
		} catch {
			print("Error saving managed object context: \(error)")
		}
	}
	
}

