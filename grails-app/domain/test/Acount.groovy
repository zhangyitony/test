package test

class Acount {
	String acountName
	String password
	String jobTitle//职务名称
	String parentAcount//上级单位

	
	static hasMany = [authoritys:Authority]
	static belongsTo = [role:Role]
    static constraints = {
    }
	
	String toString(){
		return acountName;
	}
}
