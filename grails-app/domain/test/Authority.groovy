package test

class Authority {
	String authority
	static belongsTo = [acount:Acount, form:Form]
    static constraints = {
    }
}
