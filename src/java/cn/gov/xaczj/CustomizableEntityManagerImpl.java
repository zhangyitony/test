package cn.gov.xaczj;

import org.hibernate.MappingException;
import org.hibernate.mapping.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

public class CustomizableEntityManagerImpl implements CustomizableEntityManager {
	private Component customProperties;
	private Class entityClass;
	private String entityName;
	
	
	public CustomizableEntityManagerImpl(Class entityClass) {
		this.entityClass = entityClass;
	}

	public CustomizableEntityManagerImpl(Class entityClass, String entityName) {
		this.entityClass = entityClass;
		this.entityName = entityName;
	}
	public String getEntityName() {
		return entityName;
	}

	public Class getEntityClass() {
		return entityClass;
	}

	public Component getCustomProperties() {
		if (customProperties == null) {
			Property property = getPersistentClass().getProperty(
					CUSTOM_COMPONENT_NAME);
			customProperties = (Component) property.getValue();
		}
		return customProperties;
	}

	/**
	 * @brief 澧炴坊瀹氬埗灞炴�
	 * @param name
	 *            鍒楀悕绉�
	 * @param type
	 *            鍒楃被鍨嬶紝鍙傝�锛歨ttp://maomao.blog.51cto.com/115985/55701
	 * @return void
	 */
	public void addCustomField(String name, String type) {
		SimpleValue simpleValue = new SimpleValue(HibernateUtil.getInstance()
				.getConfiguration().createMappings(),getPersistentClass().getTable());
		
		simpleValue.addColumn(new Column(name));
		simpleValue.setTypeName(type);

//		PersistentClass persistentClass = getPersistentClass();
//
//		Table table = persistentClass.getTable();
//		simpleValue.setTable(table);

		Property property = new Property();
		property.setName(name);
		property.setValue(simpleValue);
		try{
			getCustomProperties().getProperty(property.getName()); 
		}catch (MappingException me){
			//浠呬粎鍦ㄤ笉瀛樺湪璇ュ睘鎬х殑鏃跺�娣诲姞锛屾秷闄ら噸澶嶆坊鍔�
			getCustomProperties().addProperty(property);
		}
		
		updateMapping();
	}

	/**
	 * @brief 鎵归噺澧炴坊瀹氬埗灞炴�
	 * @param addFileds
	 *            闇�澧炲姞鐨勫睘鎬х殑鍚嶇О鍜岀被鍨�鍒楃被鍨嬶紝鍙傝�锛歨ttp://maomao.blog.51cto.com/115985/55701
	 * @return void
	 */
	public void addCustomField(HashMap<String,String> addFileds) {

		SimpleValue simpleValue;
		Property property;
		String name;
		String type;
		for(Entry<String,String> filed: addFileds.entrySet()){
			System.out.println("name:"+filed.getKey());
			System.out.println("type:"+filed.getValue());
			 name = filed.getKey();
			 type = filed.getValue();
			 simpleValue = new SimpleValue(HibernateUtil.getInstance()
					.getConfiguration().createMappings(),getPersistentClass().getTable());
			simpleValue.addColumn(new Column(name));
			simpleValue.setTypeName(type);
			property = new Property();
			
			property.setName(name);
			property.setValue(simpleValue);
			try{
				getCustomProperties().getProperty(property.getName()); 
			}catch (MappingException me){
				//浠呬粎鍦ㄤ笉瀛樺湪璇ュ睘鎬х殑鏃跺�娣诲姞锛屾秷闄ら噸澶嶆坊鍔�
				getCustomProperties().addProperty(property);
			}
			
		}


		
		
		updateMapping();
	}
	
	public void removeCustomField(String name) {
		Iterator propertyIterator = customProperties.getPropertyIterator();

		while (propertyIterator.hasNext()) {
			Property property = (Property) propertyIterator.next();
			if (property.getName().equals(name)) {
				propertyIterator.remove();
				updateMapping();
				return;
			}
		}
	}

	private synchronized void updateMapping() {
		MappingManager.updateClassMapping(this);
		HibernateUtil.getInstance().reset();
		// updateDBSchema();
	}

	private PersistentClass getPersistentClass() {

		System.out.println(HibernateUtil.getInstance());
		if (this.entityName.equalsIgnoreCase("")) {
			return HibernateUtil.getInstance()
					.getClassMapping(this.entityClass);
		} else {
			return HibernateUtil.getInstance().getClassMapping(this.entityName);
		}

	}

//	private PersistentClass getPersistentClass(String entityName) {
//
//		System.out.println(HibernateUtil.getInstance());
//		return HibernateUtil.getInstance().getClassMapping(entityName);
//
//	}
}