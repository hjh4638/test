function isNotNull(data){
	var length=data.length;
	var i=0;
	
	for(i;i<length;i++){
		var val=data.substring(i,i+1);
		var nul=" ";
		if(val!=nul)
			return true;
	}
	return false;
}

function deleteSpace(data){
	var length=data.length;
	var i=0;
	
	for(i;i<length;i++){
		var val=data.substring(i,i+1);
		var nul=" ";
		if(val!=nul)
			return data.substring(i,length);
	}
}