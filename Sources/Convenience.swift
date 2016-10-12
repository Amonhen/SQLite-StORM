//
//  Convenience.swift
//  SQLiteStORM
//
//  Created by Jonathan Guthrie on 2016-10-07.
//
//

import StORM

extension SQLiteStORM {

	/// Deletes one row, with an id
	/// Presumes first property in class is the id.
	public func delete() throws {
		let (idname, idval) = firstAsKey()
		do {
			try exec(deleteSQL(self.table(), idName: idname), params: [String(describing: idval)])
		} catch {
			self.error = StORMError.error(String(describing: error))
			throw error
		}
	}

	public func delete(_ id: Any) throws {
		let (idname, _) = firstAsKey()
		do {
			try exec(deleteSQL(self.table(), idName: idname), params: [String(describing: id)])
		} catch {
			self.error = StORMError.error(String(describing: error))
			throw error
		}
	}

	public func get(_ id: Any) throws {
		let (idname, _) = firstAsKey()
		do {
			try select(whereclause: "\(idname) = :1", params: [String(describing: id)], orderby: [])
		} catch {
			throw error
		}
	}

	public func get() throws {
		let (idname, idval) = firstAsKey()
		do {
			try select(whereclause: "\(idname) = :1", params: [String(describing: idval)], orderby: [])
		} catch {
			throw error
		}
	}


	public func find(_ data: [(String, Any)]) throws {
		let (idname, _) = firstAsKey()

		var paramsString = [String]()
		var set = [String]()
		for i in 0..<data.count {
			paramsString.append(data[i].1 as! String)
			set.append("\(data[i].0) = :\(i+1)")
		}

		do {
			try select(whereclause: set.joined(separator: " AND "), params: paramsString, orderby: [idname])
		} catch {
			print("Error detected: \(error)")
		}
		
	}

}
