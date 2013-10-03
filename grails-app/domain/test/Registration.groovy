package test

class Registration {
	Role role
	Form form
	
	static belongsTo = [role:Role, form:Form]
	
    static constraints = {
    }
}
