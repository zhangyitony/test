package cn.gov.xaczj



import org.hibernate.*
import org.springframework.web.context.support.WebApplicationContextUtils


import cn.gov.xaczj.domain.*;

import groovy.xml.StreamingMarkupBuilder;

class  Init {

	
	
	def dynamic;

	ArrayList <HashMap <String,String>> tableList =new ArrayList <HashMap <String,String>>();
	
	/**
	 * @brief 初始化数据库，定制数据库的列
	 */
	def initCustomField = {
//		addFiledOBO();
		
		System.out.println("in boot strap");
		
		
		initXml();
		
		addFiledsOT();
		
		
		Session session = HibernateUtil.getInstance().getCurrentSession();
				 Transaction tx = session.beginTransaction();
				 try {
		
		
				 } catch (Exception e) {
					tx.rollback();
					System.out.println("e = " + e);
				 }
	  
  
	}

	def addFiledsOT() {
		String tableName = "";
		HashMap<String,String> fileds = new HashMap<String,String>();
	//	ArrayList <HashMap <String,String>> list =new ArrayList <HashMap <String,String>>();
	//	tableList = new ArrayList <HashMap <String,String>>();
		readCustomFiledsFromFile(tableList);
		
		for(int i=0; i<tableList.size(); i++)
		{
			HibernateUtil.getInstance().getCurrentSession();
			fileds=tableList.get(i);
			tableName = fileds.get("tableName");
			CustomizableEntityManager tableEntityManager = new CustomizableEntityManagerImpl(Table.class,tableName);
			if(fileds.get("tableName") != null)
			{
				fileds.remove("tableName");
			}
			tableEntityManager.addCustomField(fileds);
		}
		
			
		
	}
	
	private readCustomFiledsFromFile(ArrayList <HashMap <String,String>> list){

	dynamic.lunch(list);
		//def dynamicadd;
		//dynamicadd.lunch(list);
	}
	
	def initXml()
	{
		def writer = new FileWriter("src/java/cn/gov/xaczj/domain/Table.hbm.xml")
	
		def comment = ''' <!DOCTYPE hibernate-mapping PUBLIC "-//Hibernate/Hibernate Configuration DTD//EN" "http://svn.compass-project.org/svn/compass/trunk/lib/hibernate/hibernate-mapping-3.0.dtd">'''
		int cnt=countXml();
		def xml = new StreamingMarkupBuilder().bind { 
			mkp.pi(xml: "version='1.0'  encoding='UTF-8' standalone='no'") 
			mkp.yieldUnescaped(comment)
		
			"hibernate-mapping"( "auto-import":"true", "default-access":"property", "default-cascade":"none", "default-lazy":"true"){
				for(int i=1;i<=cnt;i++)
				{
					"class"('abstract':"false","dynamic-insert":"false","dynamic-update":"false",
						"optimistic-lock":"version","polymorphism":"implicit","select-before-update":"false", 
						"name":"cn.gov.xaczj.domain.Table","table":"tbl_table${i}","entity-name":"table${i}")
					 {
						id("column":"fld_id" ,"name":"id"){
								"generator"( "class":"native")
						}
						property("column":"fld_name","generated":"never","lazy":"false","name":"name","optimistic-lock":"true","type":"string","unique":"false")
						"dynamic-component"("insert":"true","name":"customProperties","optimistic-lock":"true","unique":"false","update":"true"){}
					}
				}
			//	ns.friends(num: friendList.size()) {
			//		for (f in friendList) {
			//					ns.friend f
		     //       }
		    //    }
		    }
		}
		println xml
		writer << xml;
	}
	
	int countXml(){
		def dir = new File("src/groovy/xml")
		int num=0;
		dir.eachFile{
			if(it.name.endsWith('.xml'))
				num++;
		}
		return num;
	}
	
	
}