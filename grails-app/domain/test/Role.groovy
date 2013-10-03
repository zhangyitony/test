package test

class Role {
	String name
	
	static hasMany = [acount:Acount,registrations:Registration]
	//static belongsTo = [user:User]
	
	
	
    static constraints = {
    }
	
	String toString(){
		return name
	}
}