/*
	函数作用：
	从后台JSON文件中获得列的JSON数组
	参数: 
	json:后台发送的json文件
	arr :Array类型，初始值为空
*/

function makeTextClean(str){
			str = str.replace(/\s/g,"");
			str= str.replace(/\[{/g,"{");
			str= str.replace(/},{/g,",");
			str= str.replace(/\]/g,"");
			return str;
	}
		
	function makeColumJson(json,arr){
		for(var i in json) {
			if(typeof json[i] == 'object'){
				if(i == "columModle"){
					arr.push("{\""+i+"\": [");
					makeColumJson(json[i],arr);
					arr.push("]}");
				}else {
					arr.push("{\"text\":\""+i+"\",\"columns\": [");
					makeColumJson(json[i],arr);
					arr.push("]}");
				}
			}else {
				arr.push("{\"text\":\""+json[i]+"\",\"dataIndex\":\""+i+"\",\"editor\":\"textfield\"}");
				//arr.push("{\"text\":\""+json[i]+"\",\"dataIndex\":\""+i+"\"}");
			}
		}
	}		
	/*
	参数: 
	json:后台发送的json文件
	arr :Array类型，初始值为空
	*/
	function makeFieldsJson(json,arr){
		for(var i in json){
			if(typeof json[i] == 'object'){
				if(i == "columModle"){
					arr.push("{\"fieldsNames\": [");
					makeFieldsJson(json[i],arr);
					arr.push("]}");
				}else {
					makeFieldsJson(json[i],arr);
				}
			}else {
				arr.push("{\"name\":\""+i+"\"}");
			}
		}
	}

	function makeJsonClean(arr){
		var str = arr.toString();
		str = str.replace(/\[,/g,"[");
		str = str.replace(/\]},/g,"]}");
		str = str.replace(/},\]/g,"}]");
		return str;
	}
	/*做测试*/
	function testFun(json){
		for(var i in json) {
			document.write(i+":"+json[i]+"</br>");
			if(typeof json[i] == 'object'){
					testFun(json[i]);
			}
		}
	}
		
	function makeJson(str){
			var sendJson = Ext.JSON.decode(str);
			var temp={};
			temp.columModle = sendJson.columModle;
			delete sendJson.columModle;
			
			str = Ext.JSON.encode(temp);
			str=unescape(str.replace(/\\/g, "%"));
			str = makeTextClean(str);
			var json = Ext.JSON.decode(str);
			
			var arr= new Array ();
			var arr1 = new Array();
			
			makeColumJson(json,arr);
			var cols=makeJsonClean(arr);
			//document.write(cols+"---this is cols</br>");
			
			makeFieldsJson(json,arr1);
			var fieldsName=makeJsonClean(arr1);
			//document.write(fieldsName+"this is fields</br>");
			
			colsJson = Ext.JSON.decode(cols);
			fieldJson = Ext.JSON.decode(fieldsName);
			
			sendJson.columModle = colsJson.columModle;
			sendJson.fieldsNames = fieldJson.fieldsNames;
			
			return sendJson;
	}	

	

/*
* 使用实例，
* 由于JavaScript的面向对象编程掌握的不好，代码看起来不是很干净，只能先这样用着了。
			success : function(response) {
					var str = response.responseText;
					var result=makeJson(str);
					//str=unescape(str.replace(/\\/g, "%")) //Unicode 2 Chinese
					
					var store = Ext.create('Ext.data.Store', {  
						fields : result.fields.fieldsNames//把json的fieldsNames赋给fields  
						//data : json.data          //把json的data赋给data  
					})   
					Ext.getCmp("configGrid").reconfigure(store, result.cols.columModle);  //定义grid的store和column  
			}  
*/		