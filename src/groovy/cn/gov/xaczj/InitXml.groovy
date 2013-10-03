
package cn.gov.xaczj;

import groovy.xml.StreamingMarkupBuilder;
import groovy.xml.XmlUtil;

class InitXml {
	public init()
	{
		def comment = '''<class abstract="false" dynamic-insert="false" 
 	   dynamic-update="false" mutable="true" 
 	   optimistic-lock="version" polymorphism="implicit" select-before-update="false" 
 	   name="cn.gov.xaczj.domain.Table" 
 	   table="tbl_table1"
 	   entity-name = "table1">

     <id column="id" name="id">
         <generator class="native"/>
     </id>

     <dynamic-component insert="true" name="customProperties" optimistic-lock="true" unique="false" update="true">
     </dynamic-component>
 </class>'''
		
		def builder = new StreamingMarkupBuilder()
		
		 builder.encoding = "UTF-8"
		 builder.standalone = "no"
		
		def person = {
		
		//  mkp.xmlDeclaration()
		
		//  mkp.pi("xml-stylesheet": "type='text/xsl' href='myfile.xslt'" )
		
		//  mkp.declareNamespace('':'http://myDefaultNamespace')
	
		//  mkp.declareNamespace('location':'http://someOtherNamespace')
		
		//  classh{
		
		//	dynamic-insert("Jane")
		
		//	lastname("Doe")
	
			mkp.yieldUnescaped(comment)
		
		//	location.address("123 Main")
	
		  }
		def writer = new FileWriter("person.xml")
		
		writer << builder.bind(person)
		}
	
	
	}
	
	


