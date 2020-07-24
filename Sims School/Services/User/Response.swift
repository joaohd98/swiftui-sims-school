import SwiftUI
import CoreData
import FirebaseAuth

class UserResponse: ObservableObject {
	let entity = UserEntity.entity()
	@Published var uid: String
	@Published var name: String
	@Published var rm: String
	@Published var idClass: String
	@Published var actualClass: String
	@Published var course: String
	@Published var profilePicture: URL?
	@Published var coverPicture: URL?
	
	init(data: [String: Any]) {
		
		self.uid = data["uid"] as! String
		self.name = data["name"] as! String
		self.rm = data["rm"] as! String
		self.idClass = data["id_class"] as! String
		self.actualClass = data["actual_class"] as! String
		self.course = data["course"] as! String

		let coverPicture = data["cover_picture"] as! String
		FirebaseDatabase.storage.reference().child(coverPicture).downloadURL { url, error in
			if error == nil {
				self.coverPicture = url
			}
		}
		
		let profilePicture = data["profile_picture"] as! String
		FirebaseDatabase.storage.reference().child(profilePicture).downloadURL { url, error in
			if error == nil {
				self.coverPicture = url
			}
		}
		
	}
		
	func getContext(managedObjectContext: NSManagedObjectContext) {
		
		
	}
	
	func saveContext(managedObjectContext: NSManagedObjectContext) {
		do {
			
			
			try managedObjectContext.save()
		} catch {
			print("Error saving managed object context: \(error)")
		}
	}
	
}

