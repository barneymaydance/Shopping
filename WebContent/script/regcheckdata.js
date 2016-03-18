function checkdata() {
	var name=form.username.value.toLowerCase();
	
	if( strlen(form.password.value)<6 || strlen(form.password.value)>16 ) {
		//alert("\��ȷ�ص�¼���볤��Ϊ6-16λ��������Ӣ�ġ����֡������ַ���");
		alert("\ correct password should be 6~16 digits");
		form.password.focus();
		return false;
	}
	
	
	if( strlen2(form.password.value) ) {
		//alert("\���������а����˷Ƿ��ַ���������Ӣ�ġ����֡������ַ���")
		alert("\illegal input");
		form.password.focus();
		return false;
	}
	if( form.password.value == form.username.value ) {
		//alert("\�û��������벻����ͬ��")
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
		//alert("\    �Բ�����ѡ����û�������ȷ���ѱ�ռ�ã��û���\n��a��z��Ӣ����ĸ(�����ִ�Сд)��0��9�����֡��㡢��\n�Ż��»�����ɣ�����Ϊ3��18���ַ���ֻ�������ֻ���ĸ\n��ͷ�ͽ�β,For exapkyzy_001��")
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