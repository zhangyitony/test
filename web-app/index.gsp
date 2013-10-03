<!DOCTYPE html>
<html>
	<head>
	<link rel="stylesheet" href="${createLinkTo(dir:'js',file:'extjs/resources/css/ext-all.css')}"></link>
<%--	 <link rel="stylesheet" href="${createLinkTo(dir:'js',file:'extjs/resources/css/ext-all-neptune.css')}" ></link>--%>
		<script type="text/javascript" src="${createLinkTo(dir:'js',file:'extjs/bootstrap.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'js',file:'extjs/ext-all.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'js',file:'extjs/locale/ext-lang-zh_CN.js')}"></script>
		<title>登陆界面</title>
		<script type="text/javascript" charset="utf-8">
		       Ext.onReady(function(){
		    	   var denglu= Ext.create('Ext.form.Panel', {
		    		     x:50,
	              	     y:70,
	                     height:120,
	                     width: 350,
<%--	                     standardSubmit:true,--%>
	                     defaultType: 'textfield',
	                     items: [{
	                        fieldLabel: '用户名',
	                         name: 'acountname',
	                         allowBlank: false
	                         },{
	                         fieldLabel: '密码',
	                         name: 'password',
	                         inputType:'password',
	                         allowBlank: false
	                     }],
	                     buttons: [{
	                         text: '重置',
	                            handler: function() {
	                                 this.up('form').getForm().reset();
	                             
	                            }
	                          },{
	                         text: '登陆',
	                             handler:function(){
	                     	        var f=this.up('form').getForm();

	                     	        f.submit({
										url:'acount/login',
										method:'POST',
										failure:function(form,action){
											Ext.Msg.alert('Tip','login error');
											
											},
		                     	       success:function(form,action){
											Ext.Msg.alert('Tip','login success');
											window.location.href="main1.gsp"
											}
			                     	        });

	 	 								          }
	                          }
	                     ]
		    	   });

		    	   var main=Ext.create("Ext.panel.Panel",{
		                  layout:'border',
		                  //renderTo:Ext.getBody(),
		                  width:1000,
		                  height:500,
		                  items:[
		                     {region:'north',height:200,split:true,html:"logo"},
		                     {region:'west',width:500,split:true,html:"风采展示"},
		                     {region:'center',
		                     	layout:{type:"absolute"},
		                     	split:true,
		                     	items:[
		                     	   denglu
		                     	]
		                     }
		                  ]
		              })   
		              var viewport=new Ext.Viewport({
		            	  layout: {
		            		  align: 'middle',
		            		  pack: 'center',
		            		  type: 'hbox'
		            		},
		            	  items:[main]
		            	});	
		       })
 



		</script> 
	</head>
	<body>
	
	
	</body>
</html>
