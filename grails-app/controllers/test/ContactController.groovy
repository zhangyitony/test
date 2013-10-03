package test

import java.io.Serializable;

import org.hibernate.*;


import cn.gov.xaczj.*;
import cn.gov.xaczj.domain.Table;

class ContactController {
	private static final String TEST_FIELD_NAME = "email";
	private static final String TEST_VALUE = "test@test.com";
	
	
	def action() { 
		
	}
    def index = {
		  HibernateUtil.getInstance().getCurrentSession();
		
		  System.out.println(HibernateUtil.getInstance() );
		  System.out.println("11111111" );
		  CustomizableEntityManager contactEntityManager = new CustomizableEntityManagerImpl(Table.class);
		
		  contactEntityManager.addCustomField(TEST_FIELD_NAME);
		  Session session = HibernateUtil.getInstance().getCurrentSession();
		  
				   Transaction tx = session.beginTransaction();
				   try {
		  
					   Table contact = new Table();
					   contact.setName("Contact Name 1");
					   contact.setValueOfCustomField(TEST_FIELD_NAME, TEST_VALUE);
					   Serializable id = session.save(contact);
					   tx.commit();
		  
					   contact = (Table) session.get(Table.class, id);
					   Object value = contact.getValueOfCustomField(TEST_FIELD_NAME);
					   System.out.println("value = " + value);
		  
				   } catch (Exception e) {
					  tx.rollback();
					  System.out.println("e = " + e);
				   }
		
	
    }

	
}
