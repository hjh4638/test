 
function isAfter(a_date,b_date){
	var a_year=parseInt(a_date.substring(0,4));
	var a_month=parseInt(a_date.substring(5,7));
	var a_day=parseInt(a_date.substring(8,10));
	var b_year=parseInt(b_date.substring(0,4));
	var b_month=parseInt(b_date.substring(5,7));
	var b_day=parseInt(b_date.substring(8,10));
	
	if(a_date.substring(5,7)=="08")
		a_month=8;
	else if(a_date.substring(5,7)=="09")
		a_month=9;
	if(a_date.substring(8,10)=="08")
		a_day=8;
	else if(a_date.substring(8,10)=="09")
		a_day=9;
	if(b_date.substring(5,7)=="08")
		b_month=8;
	else if(b_date.substring(5,7)=="09")
		b_month=9;
	if(b_date.substring(8,10)=="08")
		b_day=8;
	else if(b_date.substring(8,10)=="09")
		b_day=9;
		
	if(a_year<b_year)
		return true;
	else if(a_year>b_year)
		return false;
	else if(a_year==b_year){
		if(a_month<b_month)
			return true;
		else if(a_month>b_month)
			return false;
		else if(a_month==b_month){
			if(a_day<b_day)
				return true;
			else
				return false;
		}
	}
}
function getBeforeOrNextDay(date,beforeOrNext){
	var year=date.substring(0,4);
	var month=date.substring(4,6)-1;//달은 0부터시작함 0~11
	var day=date.substring(6,8);
	var yesterDay=new Date();
	yesterDay.setFullYear(year, month, day);
	yesterDay.setTime(yesterDay.getTime()+beforeOrNext*24*60*60*1000);
	var result=getDateToString(yesterDay);
	return result;
}
function getDate(date){
	var resultDate=new Date();
	var year=date.substring(0,4);
	var month=date.substring(4,6)-1;//달은 0부터시작함 0~11
	var day=date.substring(6,8);
	resultDate.setFullYear(year, month, day);
	return resultDate;
}
function getToday(){
	var today=new Date();
	return getDateToString(today);
}
function getNowTimeByMinutes(minutes){
	var today=new Date();
	return getTimeByMinutes(today,minutes);
}
function getToday(form){
	var today=new Date();
	return getDateToFormString(today,form);
}
function getDayIntToString(number){
	if(number<10){
		return "0"+number;
	}else{
		return number;
	}
}
function getTodayDayName(){
	var today=new Date();
	 switch(today.getDay()){
	 case 0:
		 return "일";
	 case 1:
		 return "월";
	 case 2:
		 return "화";
	 case 3:
		 return "수";
	 case 4:
		 return "목";
	 case 5:
		 return "금";
	 case 6:
		 return "토";
	 default :
		 return "";
	 }
}
function getDayName(year,month,day){
	 var date=new Date(year, month-1, day);
	 switch(date.getDay()){
	 case 0:
		 return "일";
	 case 1:
		 return "월";
	 case 2:
		 return "화";
	 case 3:
		 return "수";
	 case 4:
		 return "목";
	 case 5:
		 return "금";
	 case 6:
		 return "토";
	 default :
		 return "";
	 }
}
function getTimeByMinutes(date,minutes){
	var nowHours=date.getHours();
	var nowMinutes=date.getMinutes();
	nowMinutes=nowMinutes-nowMinutes%minutes;
	nowHours=getDayIntToString(nowHours);
	nowMinutes=getDayIntToString(nowMinutes);
	return nowHours+""+nowMinutes;
}
function getDateToString(date){
	return date.getFullYear()+""+getDayIntToString(date.getMonth()+1)+""+getDayIntToString(date.getDate());
}
function getDateToFormString(date,form){
	var result=form;
	result=result.replace('YYYY',date.getFullYear());
	result=result.replace('MM',getDayIntToString(date.getMonth()+1));
	result=result.replace('DD',getDayIntToString(date.getDate()));	
	return result;
}