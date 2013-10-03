<!DOCTYPE html>
<html>
	<head>
	<link rel="stylesheet" href="${createLinkTo(dir:'js',file:'extjs/resources/css/ext-all.css')}"></link>
  <link rel="stylesheet" href="${createLinkTo(dir:'js',file:'extjs/resources/css/ext-all-neptune.css')}" ></link>
		<script type="text/javascript" src="${createLinkTo(dir:'js',file:'extjs/bootstrap.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'js',file:'extjs/ext-all.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'js',file:'extjs/locale/ext-lang-zh_CN.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'js',file:'makeJson.js')}"></script>
		<title>主界面</title>
		<script type="text/javascript" charset="utf-8">		  	    
		    Ext.onReady(function(){
				//主菜单四大功能按钮										
	 			var bar = Ext.create(Ext.toolbar.Toolbar,{
	 				//style: 'background-color:C4E8FD;', 
					items:[
					   Ext.create("Ext.button.Button",{
					   	text:"首页",
					   	width:200,
					   	handler:function(){
					   		center.layout.setActiveItem(0);
					   	}
					   }),
						 Ext.create("Ext.button.Button",{
						 	text:"填报表格",
						 	width:200,
						 	handler:function(){  
						 		center.layout.setActiveItem(1);
						 	}
						 }),
						Ext.create("Ext.button.Button",{
							text:"查看历史表",
							width:200,
							menu:Ext.create("Ext.menu.Menu",{
								items:[
								{text:'查看原始表',handler:function(){							   	
								   	   center.layout.setActiveItem(5);//跳转到check1
								   	}
								},
								   {text:'查看汇总表',handler:function(){
								   	   center.layout.setActiveItem(6);//跳转到check2
								   	}}
								]
							})
						}),					
						Ext.create("Ext.button.Button",{
							text:"审核新表",
							width:200,
							handler:function(){
								center.layout.setActiveItem(2);
							}
						}),					
						Ext.create("Ext.button.Button",{
							text:"查询分析",
							width:200,
							handler:function(){
								center.layout.setActiveItem(3);
							}
						})										
					]
			  });//主菜单四个功能按钮结束
			  
			  
			  //logo	  
	       var logopanel = Ext.create('Ext.panel.Panel', {
	        items:[       
	        ]   
	      }); //logo结束
	      
	      
	      //主菜单+logo区域定义                      			
				var top=Ext.create("Ext.panel.Panel",{
					height:200,
					bbar:[bar],
					items:[
					   logopanel
					]
				});//主菜单+logo区域定义结束
				
	      //首页区域定义
				var shouye=Ext.create("Ext.panel.Panel",{
					 bodyStyle:'font-size:20px',
	         items:[
	             {xtype:'text',text:'上午好'},
	             {xtype:'text',text:'西安市财政局'},
	             {xtype:'text',text:'你有'},
	             {xtype:'text',text:'*'},
	             {xtype:'text',text:'张未审核报表，其中：'},
	             {xtype:'text',text:'市级财政：'},
	             {xtype:'text',text:'**张'},
	             {xtype:'text',text:'区县级财政'},
	             {xtype:'text',text:'**张'},
	             {xtype:'text',text:'市级建设单位：'},
	             {xtype:'text',text:'**张'}
	         ]
				});//首页区域定义


				//选择填报表格页
				var tianbao=Ext.create("Ext.panel.Panel",{
					 //html:"tianbao",
					 items:[
					     {xtype:'text',text:'所有需要填报的表格：共两张'},
					     {xtype:'button',text:'西安市房屋保障资金表',
					     	 handler:function(){
					     	 	Ext.Ajax.request({
						 			    url: '/test/table/select/1',  
					            params : {  
						             action : "query"  
					            },				              
					            method : 'POST',  
					            success : function(response) {				            	
					            	  var str = response.responseText;
					            	  //alert(str);
						              var result=makeJson(str);
													var editstore = Ext.create('Ext.data.Store', {  
																	fields : result.fieldsNames,
																	proxy:{
																		type: 'ajax',  
												                        url: '/test/table/select/1',
																	//   writer:{
																	//   	 type:'json'
																	//   }
																	  reader:{
																	  	  type: 'json',
																	      root:'data'
																	  }						
																	},
																	autoLoad:true          
													}); 
						              //alert(result.data[0].proj_name);
						              //alert(editstore.fields[0].name);
						              //editstore.data=result.data;
						              //alert(result.);
						              
						              
						              //alert(result.fieldsNames[0].name);
						              //alert(result.data);
						              //alert(editstore.fields[0].name);
					            	  /* var str = makeTextClean(response.responseText); 	
					            	   //alert(str);				              
						               editjson = Ext.JSON.decode(str); //获得后台传递json
						               //alert(editjson.tabless.proj_name); 
						               var colarr= new Array ();
						               makeColumJson(editjson,colarr);
						               var cols =makeJsonClean(colarr);
						               alert(cols);
						               var colsjson = Ext.JSON.decode(cols);
						               editgrid.columns=cols;
						               //editgrid.data=editjson.data; 
						               //alert(editgrid.fields);
						               //alert(editgrid.data);
						               //alert(editjson.fieldsNames[0].name);  */
						               
						               Ext.getCmp("editgrid").reconfigure(editstore,result.columModle);  //定义grid的store和column   
					            }  
	                });	     	   	
					     	   center.layout.setActiveItem(4);			     	   	
					     	 }
					     }			    
					 ]
				});//选择填报表格页
				//填报具体表格
			
				var gridinf=Ext.create('Ext.panel.Panel',{
					height:150,
					bbar:[
					   Ext.create("Ext.button.Button",{text:"增加行",
					   	handler:function(){
	                var rec=Ext.create("Ext.data.Store",{
	                	fields:editgrid.getStore().model.prototype.fields.keys,
	                	data:[]
	                });                
					   	    editgrid.getStore().insert(editgrid.getStore().getCount(),rec.data);
					    }
					   }),
					   Ext.create("Ext.button.Button",{text:"删除行",
					   	handler:function(){            
	              editgrid.getStore().remove(editgrid.getSelectionModel().getSelection()[0]);
					    }
					  })				  
					],
					html:'gridinf'
				});
				var editgrid=Ext.create("Ext.grid.Panel",{
	      	    height:600,
	            id:"editgrid",
	            //enableHdMenu:false,
	            enableColumnHide:false,
	            enableColumnMove:false,
	            columnLines:true,
	            //plugins: [Ext.create('Ext.grid.plugin.CellEditing', {clicksToEdit: 1})], 
	            plugins: [{ptype: 'cellediting', clicksToEdit: 1}], 
	            columns : []       	
	      });

				var tianbao2=Ext.create("Ext.panel.Panel",{
					tbar:[
					    {text:'返回',handler:function(){
					    	  center.layout.setActiveItem(1);
					       }
					    },
					    {text:'复核'},
					    {text:'存草表',handler:function(){
					    	var str=unescape(Ext.encode(Ext.pluck(editgrid.getStore().data.items, 'data')).replace(/\\/g, "%") );
					    	alert(str);
					    	
<%--								var obj={};--%>
<%--								obj.data = Ext.pluck(editgrid.getStore().data.items, 'data');--%>
<%--								var str =unescape(Ext.encode(obj).replace(/\\/g, "%") );--%>
<%--								alert(str);--%>
					    	
					    		Ext.Ajax.request({
						 			    url: '/test/table/save',  
					            params :{
						            a:str
					            },  
					           // jsonData:str,
					            method : 'POST',  
					            success : function(response) {
					            	alert("成功保存");
					            }  
	                });
					    	}
					    },
					    {text:'上报上级',handler:function(){
					    		Ext.Ajax.request({
						 			    url: 'commit',  
					            params : {  
						            // editgrid
					            },  
					            method : 'POST',  
					            success : function(response) {
					            	alert("成功上报");
					            }  
	                });
					    	}
					    },'->',
					    {text:'导出模板'},
					    {text:'导入表格'}
					],
					items:[
					   gridinf,
					   editgrid
					]		
				});//填报具体表格结束
				

				
				//查看原始表
				//树的内容
				Ext.create("Ext.data.TreeStore",{
					id:"treeStore",
	                proxy: {
	                    type: 'ajax',
	                    url : 'Tree.js'
	                }
				});
				//树
				var tree = new Ext.create("Ext.tree.Panel",{				
					region:'west',
	       	width: 250,
					store:"treeStore",
					rootVisible:false
				});
				//选择表的内容
				var gridstore=Ext.create("Ext.data.ArrayStore",{
	    	   fields:["text"],
	    	   data:[
	    	    	["表1"],
	    	    	["表2"],
	    		    ["表3"],
	    		    ["表4"],
	    		    ["表5"]
	         ]
	       });
	       //选择表
			  var gridCombo = Ext.create('Ext.form.field.ComboBox', {
			  	emptyText : '请选择要查看的表格',
	        store:gridstore
	      });
	      //选择年份内容
	      var yearstore=Ext.create("Ext.data.ArrayStore",{
	    	   fields:["text"],
	    	   data:[
	    	    	["2011年"],
	    	    	["2012年"],
	    		    ["2013年"],
	    		    ["2014年"],
	    		    ["2015年"]
	         ]
	       });
	       //选择年份
			  var yearCombo = Ext.create('Ext.form.field.ComboBox', {
			  	emptyText : '请选择年份',
	        store:yearstore
	      });
	      //选择季度内容
	      var monthstore=Ext.create("Ext.data.ArrayStore",{
	    	   fields:["text"],
	    	   data:[
	    	    	["第一季度"],
	    	    	["第二季度"],
	    		    ["第三季度"],
	    		    ["第四季度"]
	         ]
	       });
	       //选择季度
			  var monthCombo = Ext.create('Ext.form.field.ComboBox', {
			  	emptyText : '请选择季度',
	        store:monthstore
	      });

	      var configGrid=Ext.create("Ext.grid.Panel",{ 
	            id:"configGrid",  
	            columns : [],  
	            displayInfo : true,  
	            emptyMsg : "没有数据显示",  
	            items : []  
	        });		
				var originalgrid=Ext.create("Ext.panel.Panel",{
					region:'center',
					tbar:[
					   gridCombo,
					   yearCombo,
					   monthCombo,
					   {text:'查看',handler:function(){
					   	 		Ext.Ajax.request({
						 			    url: 'ajax/mydata.json',  
					            params : {  
						             action : "query"  
					            },  
					            method : 'POST',  
					            success : function(response) {  
						               var json = Ext.JSON.decode(response.responseText); //获得后台传递json  
						               var store = Ext.create('Ext.data.Store', {  
							                 fields : json.fieldsNames,//把json的fieldsNames赋给fields  
							                 data : json.data          //把json的data赋给data  
						               });   
						               Ext.getCmp("configGrid").reconfigure(store, json.columModle);  //定义grid的store和column   
					            }  
	                });
					     }
					   },
					   {text:'导出为excel'}
					],
					items:[
					   configGrid
					]
				});        	
				var check1=Ext.create("Ext.panel.Panel",{
					layout:'border',
					items:[
					   tree,
					   originalgrid
					]
				});//查看原始表结束
				
				//查看汇总表
				//树
				/*Ext.create("Ext.data.TreeStore",{
					id:"treeStore2",
	                proxy: {
	                    type: 'ajax',
	                    url : 'Tree.js'
	                }
				});*/
				var tree2 = new Ext.create("Ext.tree.Panel",{				
					region:'west',
	       	width: 250
	       	//store:'treestore2',
					//rootVisible:false
				});//树结束
				var gridstore2=Ext.create("Ext.data.ArrayStore",{
	    	   fields:["text"],
	    	   data:[
	    	    	["表1"],
	    	    	["表2"],
	    		    ["表3"],
	    		    ["表4"],
	    		    ["表5"]
	         ]
	       });
	       //选择表
			  var gridCombo2 = Ext.create('Ext.form.field.ComboBox', {
			  	emptyText : '请选择要查看的表格',
	        store:gridstore2
	      });
	      //选择年份内容
	      var yearstore2=Ext.create("Ext.data.ArrayStore",{
	    	   fields:["text"],
	    	   data:[
	    	    	["2011年"],
	    	    	["2012年"],
	    		    ["2013年"],
	    		    ["2014年"],
	    		    ["2015年"]
	         ]
	       });
	       //选择年份
			  var yearCombo2 = Ext.create('Ext.form.field.ComboBox', {
			  	emptyText : '请选择年份',
	        store:yearstore2
	      });
	      //选择季度内容
	      var monthstore2=Ext.create("Ext.data.ArrayStore",{
	    	   fields:["text"],
	    	   data:[
	    	    	["第一季度"],
	    	    	["第二季度"],
	    		    ["第三季度"],
	    		    ["第四季度"]
	         ]
	       });
	       //选择季度
			  var monthCombo2 = Ext.create('Ext.form.field.ComboBox', {
			  	emptyText : '请选择季度',
	        store:monthstore2
	      });
	      
				var sumgrid=Ext.create("Ext.panel.Panel",{
					region:'center',
					tbar:[
					   gridCombo2,
					   yearCombo2,
					   monthCombo2,
					   {text:'查看'},
					   {text:'导出为excel'}
					],
					items:[
					]
				});						
				var check2=Ext.create("Ext.panel.Panel",{
	        layout:'border',
					items:[
					   tree2,
					   sumgrid
					]
				});//查看汇总表结束

	      //审核界面
	      var shenhe2=Ext.create("Ext.panel.Panel",{
	      	tbar:[
					    {text:'返回',handler:function(){
					    	  center.layout.setActiveItem(2);
					       }
					    },
					    {text:'接收'},
					    {text:'拒绝'},'->',
					    {text:'上一张'},
					    {text:'下一张'}
					],
					items:[
					]	
	      });
				var shenhe=Ext.create("Ext.panel.Panel",{
					 //html:"shenhe"
					 items:[
					     {xtype:'text',text:'西安市财政局未审核表格：共一张'},
					     {xtype:'button',text:'西安市房屋保障资金表',
					     	   handler:function(){
					     	   	center.layout.setActiveItem(7);			     	   	
					     	   }
					     }			    
					 ]
				});//审核界面结束
				
				
				var chaxun=Ext.create("Ext.panel.Panel",{
					 html:"chaxun"
				});
				
				//主区域定义			
				var center=Ext.create("Ext.panel.Panel",{
					id:'center',
					height:800,
					layout:'card',
					items:[
					   shouye,
					   tianbao,
					   shenhe,
					   chaxun,
					   tianbao2,
					   check1,
					   check2,
					   shenhe2
					]
				});				
				var main=Ext.create("Ext.panel.Panel",{
					renderTo:Ext.getBody(),
					items:[
					   top,
					   center
					]
				})//主区域定义结束
	    	    

               
		    })
		</script> 
	</head>
	<body>
	</body>
</html>
