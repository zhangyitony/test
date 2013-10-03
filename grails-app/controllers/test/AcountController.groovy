package test

import org.springframework.dao.DataIntegrityViolationException
import cn.gov.xaczj.TableDynamic
import grails.converters.*
import groovy.json.*

import java.util.Map.Entry

class AcountController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def dynamic;
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: Acount.list(params), userInstanceTotal: Acount.count()]
    }

    def create() {
        [userInstance: new Acount(params)]
    }

    def save() {
        def userInstance = new Acount(params)
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def show(Long id) {
        def userInstance = Acount.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def edit(Long id) {
        def userInstance = Acount.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def update(Long id, Long version) {
        def userInstance = Acount.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def delete(Long id) {
        def userInstance = Acount.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def register = {}
	
	def loginCheck = {
		def user = Acount.findByUserNameAndPassword(params.userName,params.password)
		//def role = Role.findById(user.role.id)
		//def registration =  Registration.findAllByRole(role)
		//def authority =  Authority.findAllByUser(user)
		if(user){
			session.userId = user.id
			flash.message = message(code:'login.success',args:[user.userName])
			//render(view: "hello", model: [userInstance: user,roleInstance:role,registrationInstance:registration,authorityInstance:authority])
			 redirect(action: "json", id: user.id)
			
		}else{
			flash.message = message(code:'login.failed')
			redirect(action:'login')
		}
	}
	List change(table)
	{
		def tmap = table.getProperties();
		def list = [];
		int i;
		for(i=0;i<10;i++)
		{
			tmap.each {
				if(it.value.class.name=="groovy.util.Expando")
				{
					Expando aa = it.value;
					
			   
				   if(aa.num==i)
				   {
					   def name;
					   def map = [:];
					   if(it.value.class.name=="groovy.util.Expando")
					   {
					   
						   map.putAt("id", it.key)
					   }
					   println("|"+it.key+"->"+it.value+"|");
					   println it.value.class.name;
					   if(it.value.class.name=="groovy.util.Expando")
					   {
						   Expando child = it.value;
						   for(Entry e:child.getProperties().entrySet()){
							   println("|"+e.key+"->"+e.value+"|");
							   println(e.value);
							   if (e.value == "")
								name = e.key;
										
						   }
						   println name;
						   map.putAt("name", name)
						   if(it.value.getProperties().entrySet().size()!=2)
						   {
							   def li = [];
							   map.putAt("child", change(child))
						   }
					   }
					   if(it.value.class.name=="groovy.util.Expando")
					   {
						   list.add(map);
					   }
					   println list;
				   }
				}
				
				
			}
		}
		
		return list
	}

	List change2( llist)
	{
		def ll=[];
		def size=llist.size()
		for(int i=0;i<size;i++)
		{
			def map=[:];
			def aa=llist.get(i);
			if (!aa.containsKey("child"))
				map.putAt("${llist.get(i).getAt("id")}", llist.get(i).getAt("name"));
			else 
				map.putAt("${llist.get(i).getAt("name")}",change2(llist.get(i).getAt("child")) );
			ll.add(map);
		}
		return ll
	}

	def json(Long id) {
	//	def user = User.get(id)
	//	def role = Role.findById(user.role.id)
	//	def registration =  Registration.findAllByRole(role)
	//	def authority =  Authority.findAllByUser(user)
		def tableList = dynamic.getTableList()
		//render(view: "hello", model: [userInstance: user,roleInstance:role,registrationInstance:registration,authorityInstance:authority]) 				
		id=id-1;
		TableDynamic td = tableList.get((int)id);
		def map=td.entityName;
		Expando table = td.table;
		def tmap = table.getProperties();
//		tmap.get("investgatePlan");	
	
		def list =change(table);
		def listend = change2(list);
		println list.toString();
//		JsonBuilder result = new JsonBuilder();
//		result{
//				for(Entry tmp:tmap.entrySet())
//				{
//					String key = tmp.key;
//					Expando value = tmp.value;
//						 //TODO: read child properties
//		//				 if(!value.getProperties().isEmpty()){
//		//					 readChild(value);
//		//				 }
//						 
//						 //TODO: put key into json
//					System.out.println(""+key+"|"+value);
//					 "${key}" value;
//				}
//			
//			}
//					
//		println result.toString();
//		for(Entry tmp:tmap.entrySet())
//		{
//			String key = tmp.key;
//			Expando value = tmp.value;
//				 //TODO: read child properties
//				 if(!value.getProperties().isEmpty()){
//					 readChild(value);
//				 }
//				 
//				 //TODO: put key into json 
//			System.out.println(""+key+"|"+value);
//		}
		
		
			render(contentType: "application/json",encoding: "gbk",model: map) {
//	        users = array {
//				for (u in user) {
//					us userName:u.userName,zwmz:u.zwmz,sjdw:u.sjdw 		
//				}				
//			}
//			forms = array {
//	            for (r in registration) {
//	                form_id id: r.form.id
//	            }
//	        }
//			limits = array {
//				for (a in authority) {
//				//	form_id id:a.form.id
//					limit id:a.form.id,authority: a.authority
//				}
//			}
//			tables  = array{
//				for (l in list) {
//	                if(l.child!=null)
//					{
//						aa "${l.name}":child = array{
//							for (ll in l.child){
//								 bb "${l.id}" : l.name 
//							}
//						}
//					}
//					else
//					{
//						 aa "${l.id}" : l.name 
//						
//					}
//				}
//			}
//			tables =list;
	//		title = map;
			columModle = listend;
		}
			
		//[title:map]	
	}
	
	/**
	 * chen modify
	 * user login.undone
	 */
	def login = {
		def acount = Acount.findByAcountNameAndPassword(params.acountname,params.password);
		def tmp;
		if(acount){
			session.userId = acount.id;
			flash.message = message(code:'login.success',args:[acount.acountName]);
			println("login success!");
//			redirect(url:"/main1.gsp");
			tmp =[success:true]
			render tmp as JSON;
		}else{
			flash.message = message(code:'login.failed');
			println("login failed!");
			tmp =[success:false]
			render tmp as JSON;
		}
		
//		println("login username:"+params.username+"|password:"+params.password);
		
		
	}
	
	def logout = {
		session.invalidate()
		redirect(action:'login')
	}
	
	def auth(){
		if(!session.userId){
			redirect(action:'login',controller:'acount')
			return false
		}
	}
	
	def beforeInterceprtor = [action:this.&auth,expect:['register','save','login','loginCheck','logout']]
	
}
