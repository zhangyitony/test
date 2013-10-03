package cn.gov.xaczj;

import groovy.util.Expando;

class TableDynamic {
	def entityName;
	Expando table;//store table custom fileds
	Expando operate;//store relationship between some fileds
	TableDynamic() {
		this.table = new Expando();
		this.operate = new Expando();
	}

	
	

}
