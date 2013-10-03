package cn.gov.xaczj;

 import cn.gov.xaczj.domain.CustomizableEntity;

import org.hibernate.Session;
import org.hibernate.mapping.Column;
import org.hibernate.mapping.Property;
import org.hibernate.type.Type;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;




import java.io.FileInputStream;
import java.util.Iterator;

 public class MappingManager {
     public static void updateClassMapping(CustomizableEntityManager entityManager) {
         try {
        	 String entityName = "";
             Session session = HibernateUtil.getInstance().getCurrentSession();
             Class<? extends CustomizableEntity> entityClass = entityManager.getEntityClass();
             String file = entityClass.getResource(entityClass.getSimpleName() + ".hbm.xml").getPath();
             System.out.println(file);
            
             Document document = XMLUtil.loadDocument(file);
             NodeList componentTags = document.getElementsByTagName("dynamic-component");
             int num = 0;//决定跟新哪一套映射配置，默认第一个。实际应用应该由entityName决定
             if(!(entityName=entityManager.getEntityName()).equals("")){
            	 String[]ar = entityName.split("table");
            	 num = (Integer.parseInt(ar[1])-1)<0?0:Integer.parseInt(ar[1])-1;
             }
             Node node = componentTags.item(num);//!此处决定修改哪一个映射配置
             XMLUtil.removeChildren(node);//删除node下的全部孩子节点

             Iterator propertyIterator = entityManager.getCustomProperties().getPropertyIterator();
             while (propertyIterator.hasNext()) {
                 Property property = (Property) propertyIterator.next();
                 Element element = createPropertyElement(document, property);
                 node.appendChild(element);
             }

             XMLUtil.saveDocument(document, file);
         } catch (Exception e) {
             e.printStackTrace();
         }
    }

    private static Element createPropertyElement(Document document, Property property) {
         Element element = document.createElement("property");
         Type type = property.getType();

         element.setAttribute("name", property.getName());
         element.setAttribute("column", ((Column)
 property.getColumnIterator().next()).getName());
         element.setAttribute("type", 
type.getReturnedClass().getName());
         element.setAttribute("not-null", String.valueOf(false));

         return element;
     }
 }