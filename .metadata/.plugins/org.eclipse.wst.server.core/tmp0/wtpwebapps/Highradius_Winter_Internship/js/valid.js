//Validating the username and password properly
function validated(){
	var username = document.getElementById('username');
	var password = document.getElementById('password');
	var user_error = document.getElementById('user_error');
	var password_error = document.getElementById('password_error');
	
	if(username.value=="" || password.value==""){
		alert("No blank values allowed");
		return false;
	}
	else{
		if(username.value.length<5){
			username.style.border = "1px solid red";
			username.focus();
			alert("Username not valid");
			return false;
		}
		else if(password.value.length<5){
			password.style.border = "1px solid red";
			password.focus();
			alert("Password not valid")
			return false;
		}
		else{
			true;
		}
	}
}