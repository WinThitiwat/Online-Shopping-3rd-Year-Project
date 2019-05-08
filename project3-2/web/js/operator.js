/**
 * Created by thitiwat on 7/19/2016.
 */
function popupCategories(){
    var categoryList = document.getElementById("categoryList");

}

function toggle2(showHideDiv, switchTextDiv) {

    var ele = document.getElementById(showHideDiv);

    var text = document.getElementById(switchTextDiv);

    if(ele.style.display == "block") {

        ele.style.display = "none";

//                text.innerHTML = "restore";

    }

    else {

        ele.style.display = "block";

//                text.innerHTML = "collapse";

    }

}

function overlay(){
    el = document.getElementById("overlay");
    el.style.visibility = (el.style.visibility == "visible")? "hidden":"visible";
}


function checkRegisterInput(form){

    var firstName = document.getElementById("firstname").value;
    var lastName = document.getElementById("lastname").value;
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    if(form.firstname.value == "" || form.lastname.value == "" || form.email.value == "" || form.password.value == "" || form.confirmPassword.value == "" || form.password.value != form.confirmPassword.value){
        alert("Please re-enter your information again");
        form.firstname.focus();
        return false;
    }else{
        return true;
    }

}