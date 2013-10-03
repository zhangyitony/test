package test

class Form {
	int no
	String name
	
    static constraints = {
    }
	
	static hasMany = [registrations:Registration,authoritys:Authority]
	
	String toString(){
	    return name
	}
	
  
}
