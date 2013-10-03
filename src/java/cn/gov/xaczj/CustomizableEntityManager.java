package cn.gov.xaczj;

 import java.util.HashMap;

import org.hibernate.mapping.Component;

 public interface CustomizableEntityManager {
     public static String CUSTOM_COMPONENT_NAME = "customProperties";

     void addCustomField(String name,String type);

     public void addCustomField(HashMap<String,String> addFileds);
     
     void removeCustomField(String name);

     Component getCustomProperties();

     Class getEntityClass();
     
     public String getEntityName();
 }