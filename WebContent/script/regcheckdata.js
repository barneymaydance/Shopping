function checkdata() {
	var name=form.username.value.toLowerCase();
	
	if( strlen(form.password.value)<6 || strlen(form.password.value)>16 ) {
		//alert("\正确地登录密码长度为6-16位，仅可用英文、数字、特殊字符！");
		alert("\ correct password should be 6~16 digits");
		form.password.focus();
		return false;
	}
	
	
	if( strlen2(form.password.value) ) {
		//alert("\您的密码中包含了非法字符，仅可用英文、数字、特殊字符！")
		alert("\illegal input");
		form.password.focus();
		return false;
	}
	if( form.password.value == form.username.value ) {
		//alert("\用户名和密码不能相同！")
		alert("\ username and password can't be the same!");
		form.password.focus();
		return false;
	}
	
	if( form.password2.value =="" ) {
		alert("\ please input password again!");
		form.password2.focus();
		return false;
	}
	
	if( form.password2.value != form.password.value ) {
		alert("\ the twice passwords are not the same!");
		form.password.focus();
		return false;
	}
	
	if(form.phone.value == "") {
		alert("\ input your phone number!");
		form.phone.focus();
		return false;
	}
	
	if(!isNum(form.phone.value)){
		alert("\ input valid number! Only numbers!");
		form.phone.focus();
		return false;
	}
	if(form.addr.value == "") {
		alert("\ intput your address!");
		form.addr.focus();
		return false;
	}
	return true;
}

function checkUserName(ssn){
	if( ssn.length<3 || ssn.length>18 ) {
		alert("\please submit right username, the length should be 3-18!");
		form.username.focus();
		return false;
	}
	if (isWhiteWpace(ssn)){
		alert("\please submit right username, can't contain whitespace!");
		form.username.focus();
		return false;
	}
	if (!isSsnString(ssn)){
		//alert("\    对不起，您选择的用户名不正确或已被占用！用户名\n由a～z的英文字母(不区分大小写)、0～9的数字、点、减\n号或下划线组成，长度为3～18个字符，只能以数字或字母\n开头和结尾,For exapkyzy_001。")
		alert("\please submit right username, the input username should be a~z, 0~9, \".\",\"-,+,_\"");
		form.username.focus();
		return false;
	}
	return true;
}

function strlen(str){
	var len;
	var i;
	len = 0;
	for (i=0;i<str.length;i++){
		if (str.charCodeAt(i)>255) len+=2; else len++;
	}
	return len;
}

function strlen2(str){
	var len;
	var i;
	len = 0;
	for (i=0;i<str.length;i++){
		if (str.charCodeAt(i)>255) return true;
	}
	return false;
}

function isWhiteWpace (s)
{
	var whitespace = " \t\n\r";
	var i;
	for (i = 0; i < s.length; i++){   
		var c = s.charAt(i);
		if (whitespace.indexOf(c) >= 0) {
		  	return true;
		}
	}
	return false;
}

function isSsnString (ssn)
{
	var re=/^[0-9a-z][\w-.]*[0-9a-z]$/i;
	if(re.test(ssn))
		return true;
	else
		return false;
}

function isNum(phone)
{
	var re=/\d*/i;
	if(re.test(phone)){
		return true;
	}
	else{
		return false;
	}
}