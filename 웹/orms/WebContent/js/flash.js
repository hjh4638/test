
function setFlashWidth(divid, newW){
    document.getElementById(divid).style.width = newW+"px";
}
function setFlashHeight(divid, newH){
    document.getElementById(divid).style.height = newH+"px";        
}
function setFlashSize(divid, newW, newH){
    setFlashWidth(divid, newW);
    setFlashHeight(divid, newH);
}
function canResizeFlash(){
    var ua = navigator.userAgent.toLowerCase();
    var opera = ua.indexOf("opera");
    if( document.getElementById ){
        if(opera == -1) return true;
        else if(parseInt(ua.substr(opera+6, 1)) >= 7) return true;
    }
    return false;
}

function embedFlashObject(url, width, height, variables){
    var strVariables = "";
    if(variables != undefined && variables != null && variables != ""){
        strVariables = "<param name=\"flashVars\" value=\"" + variables + "\" />";
    }

    var str = "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://hq0414.hq.af.mil:8001/MAIN/FLASH_MAIN/8.0.0.0/swflash.cab#version=8,0,0,0\" width=\"" + width + "\" height=\"" + height + "\"  align=\"middle\">" + strVariables + "<param name=\"allowScriptAccess\" value=\"sameDomain\" /><param name=\"wmode\" value=\"transparent\" /><param name=\"movie\" value=\"" + url + "\" /><param name=\"quality\" value=\"high\" /><embed src=\"" + url + "\" quality=\"high\" wmode=\"transparent\" width=\"" + width + "\" height=\"" + height + "\" name=\"test1\" align=\"middle\" allowScriptAccess=\"sameDomain\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" /></object>";

    document.write(str);
}
