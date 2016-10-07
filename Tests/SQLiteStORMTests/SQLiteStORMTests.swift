import XCTest
import PerfectLib
import StORM
@testable import SQLiteStORM

//
//class User: SQLiteStORM {
//	// NOTE: First param in class should be the ID.
//	var id				: Int = 0
//	var firstname		: String = ""
//	var lastname		: String = ""
//	var email			: String = ""
//
//
//	override open func table() -> String {
//		return "users"
//	}
//
//	override func to(_ this: StORMRow) {
//		id				= this.data["id"] as! Int
//		firstname		= this.data["firstname"] as! String
//		lastname		= this.data["lastname"] as! String
//		email			= this.data["email"] as! String
//	}
//
//	func rows() -> [User] {
//		var rows = [User]()
//		for i in 0..<self.results.rows.count {
//			let row = User()
//			row.to(self.results.rows[i])
//			rows.append(row)
//		}
//		return rows
//	}
////	override func makeRow() {
////		self.to(self.results.rows[0])
////	}
//}
//
//
//class PostgresSTORMTests: XCTestCase {
//	var connect = PostgresConnect(
//		host: "localhost",
//		username: "perfect",
//		password: "perfect",
//		database: "perfect_testing",
//		port: 32768
//	)
//	
//	override func setUp() {
//		super.setUp()
//	}
//
//	/* =============================================================================================
//	Save - New
//	============================================================================================= */
//	func testSaveNew() {
//		let obj = User(connect)
//		//obj.connection = connect    // Use if object was instantiated without connection
//		obj.firstname = "X"
//		obj.lastname = "Y"
//
//		do {
//			try obj.save {id in obj.id = id as! Int }
//		} catch {
//			XCTFail(error as! String)
//		}
//		XCTAssert(obj.id > 0, "Object not saved (new)")
//	}
//
//	/* =============================================================================================
//	Save - Update
//	============================================================================================= */
//	func testSaveUpdate() {
//		let obj = User(connect)
//		//obj.connection = connect    // Use if object was instantiated without connection
//		obj.firstname = "X"
//		obj.lastname = "Y"
//
//		do {
//			try obj.save {id in obj.id = id as! Int }
//		} catch {
//			XCTFail(error as! String)
//		}
//
//		obj.firstname = "A"
//		obj.lastname = "B"
//		do {
//			try obj.save()
//		} catch {
//			XCTFail(error as! String)
//		}
//		print(obj.errorMsg)
//		XCTAssert(obj.id > 0, "Object not saved (update)")
//	}
//
//	/* =============================================================================================
//	Save - Create
//	============================================================================================= */
//	func testSaveCreate() {
//		let obj = User(connect)
//
//		do {
//			obj.id			= 10001
//			obj.firstname	= "Mister"
//			obj.lastname	= "PotatoHead"
//			obj.email		= "potato@example.com"
//			try obj.create()
//		} catch {
//			XCTFail(error as! String)
//		}
//		XCTAssert(obj.id == 10001, "Object not saved (create)")
//	}
//
//	/* =============================================================================================
//	Get (with id)
//	============================================================================================= */
//	func testGetByPassingID() {
//		let obj = User(connect)
//		//obj.connection = connect    // Use if object was instantiated without connection
//		obj.firstname = "X"
//		obj.lastname = "Y"
//
//		do {
//			try obj.save {id in obj.id = id as! Int }
//		} catch {
//			XCTFail(error as! String)
//		}
//
//		let obj2 = User(connect)
//
//		do {
//			try obj2.get(obj.id)
//		} catch {
//			XCTFail(error as! String)
//		}
//		XCTAssert(obj.id == obj2.id, "Object not the same (id)")
//		XCTAssert(obj.firstname == obj2.firstname, "Object not the same (firstname)")
//		XCTAssert(obj.lastname == obj2.lastname, "Object not the same (lastname)")
//	}
//
//
//	/* =============================================================================================
//	Get (by id set)
//	============================================================================================= */
//	func testGetByID() {
//		let obj = User(connect)
//		//obj.connection = connect    // Use if object was instantiated without connection
//		obj.firstname = "X"
//		obj.lastname = "Y"
//
//		do {
//			try obj.save {id in obj.id = id as! Int }
//		} catch {
//			XCTFail(error as! String)
//		}
//
//		let obj2 = User(connect)
//		obj2.id = obj.id
//		
//		do {
//			try obj2.get()
//		} catch {
//			XCTFail(error as! String)
//		}
//		XCTAssert(obj.id == obj2.id, "Object not the same (id)")
//		XCTAssert(obj.firstname == obj2.firstname, "Object not the same (firstname)")
//		XCTAssert(obj.lastname == obj2.lastname, "Object not the same (lastname)")
//	}
//
//	/* =============================================================================================
//	Get (with id) - integer too large
//	============================================================================================= */
//	func testGetByPassingIDtooLarge() {
//		let obj = User(connect)
//
//		do {
//			try obj.get(874682634789)
//			XCTFail("Should have failed (integer too large)")
//		} catch {
//			print("^ Ignore this error, that is expected and should show 'ERROR:  value \"874682634789\" is out of range for type integer'")
//			// test passes - should have a failure!
//		}
//	}
//	
//	/* =============================================================================================
//	Get (with id) - no record
//	// test get where id does not exist (id)
//	============================================================================================= */
//	func testGetByPassingIDnoRecord() {
//		let obj = User(connect)
//
//		do {
//			try obj.get(1111111)
//			XCTFail("Should have failed (record not found)")
//		} catch {
//			if obj.error.string() != StORMError.noRecordFound.string() {
//				XCTFail("Fall through... Should have failed (record not found): \(obj.error.string())")
//			}
//			print("^ Ignore this error, that is expected and should show 'ERROR:  not found'")
//			// test passes - should have a failure!
//		}
//	}
//	
//
//
//
//	// test get where id does not exist ()
//	/* =============================================================================================
//	Get (preset id) - no record
//	// test get where id does not exist (id)
//	============================================================================================= */
//	func testGetBySettingIDnoRecord() {
//		let obj = User(connect)
//		obj.id = 1111111
//		do {
//			try obj.get()
//			XCTFail("Should have failed (record not found)")
//		} catch {
//			if obj.error.string() != StORMError.noRecordFound.string() {
//				XCTFail("Fall through... Should have failed (record not found): \(obj.error.string())")
//			}
//			print("^ Ignore this error, that is expected and should show 'ERROR:  not found'")
//			// test passes - should have a failure!
//		}
//	}
//	
//
//	/* =============================================================================================
//	Returning DELETE statement to verify correct form
//	// deleteSQL
//	============================================================================================= */
//	func testCheckDeleteSQL() {
//		let obj = User(connect)
//		XCTAssert(obj.deleteSQL("test", idName: "testid") == "DELETE FROM test WHERE testid = $1", "DeleteSQL statement is not correct")
//
//	}
//
//
//
//	// delete(id: Int, idName: String = "id")
//	// delete()
//
//
//	/* =============================================================================================
//	Find
//	============================================================================================= */
//	func testFind() {
//		let obj = User(connect)
//
//		do {
//			try obj.find([("firstname", "Joe")])
//			//print("Find Record:  \(obj.id), \(obj.firstname), \(obj.lastname), \(obj.email)")
//		} catch {
//			XCTFail("Find error: \(obj.error.string())")
//		}
//	}
//
//
//
//
//
//
//	static var allTests : [(String, (PostgresSTORMTests) -> () throws -> Void)] {
//		return [
//			("testSaveNew", testSaveNew),
//			("testSaveUpdate", testSaveUpdate),
//		]
//	}
//
//}
