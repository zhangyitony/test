package cn.gov.xaczj.domain;

 import java.util.Map;
 import java.util.HashMap;

 public abstract class CustomizableEntity {

 private Map<String,Object> customProperties;

 public Map<String,Object> getCustomProperties() {
         if (customProperties == null)
             customProperties = new HashMap<String,Object>();
        return customProperties;
 }
 public void setCustomProperties(Map<String,Object> customProperties) {
        this.customProperties = customProperties;
 }

 public Object getValueOfCustomField(String name) {
     return getCustomProperties().get(name);
 }

 public void setValueOfCustomField(String name, Object value) {
     getCustomProperties().put(name, value);
 }

 }