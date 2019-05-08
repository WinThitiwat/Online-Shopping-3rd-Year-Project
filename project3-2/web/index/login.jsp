<!--Created by -->
<!--User: Cedric-->
<!--Date: 7/25/2016-->
<!--Time: 11:07 AM-->
<!--To change this template use File | Settings | File Templates.-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title> register</title>
    <meta charset="utf-8"/>


    <style>
        @import "../css/login_and_register.css";
        @import "../css/main_style.css";
    </style>
    <link href="../js/operator.js" rel="stylesheet"/>
</head>

<%
    String parent = request.getParameter("parent");
    String etc = request.getParameter("etc");
    out.print(parent);
    out.print(etc);
%>

<body>
    <div id="wrapper">
        <div class="introduction">
            <p>
                Have an eye on something? <br>
                Start a Cart List.<br>
                Simply create a Customer Account below,<br>
                then,whenever you see something you love on our site,<br>
                just click the <strong>"AddToCart"</strong> button on the product page.<br>
                Happy Shopping!<br>
            </p>

        </div>
        <div class="loginRegisterPart">
            <div class="loginArea">
                <div class="account_form">
                    <div>
                        <span>
                            <label class="loginForm">Log in</label>
                            <label class="notificationForm">(*  necessary information)</label>
                        </span>
                    </div>
                    <%out.print("<form action='redirect.jsp?action=Login&parent="+parent+"&etc="+etc+"' method='post' style='padding-left: 10px;'>");%>
                        <%--<form method="post" action="redirect.jsp?action=Login" style="padding-left: 10px;">--%>

                        <p>
                            <br/><br/>
                            <label for="pseudo">Email* :</label> <br/><br/>
                            <input type="text" name="username" placeholder="ex.appacha" required="required"/>

                            <br/><br/>


                            <label for="passe">Password* :</label><br/><br/>
                            <input type="password" name="password" required="required"/>
                            <br/>

                            <a href=""><h5>forgotten password</h5></a>
                            <!--you just to link it mr win-->

                            <br/>
                            <input type="submit" value="login" class="loginBtt"/><a href="register.jsp"></a>
                        </p>
                    </form>
                </div>
            </div>
            <div class="registerArea">
                <div class="registrationForm">
                    <div>
                        <span>
                            <label class="registerForm">Registration</label>
                            <label class="notificationForm">(*  necessary information)</label>
                        </span>
                    </div>
                    <form method="post" onsubmit="return checkRegisterInput(this);" action="redirect.jsp?action=register">

                    <p>
                    <label for="coco">First name* :<br/></label>
                    <input type="text" name="firstname" placeholder="appacha " id="firstname" value=""/>
                    </p>
                    <p>
                    <label for="coco">Last name* :<br/></label>
                    <input type="text" name="lastname" placeholder="appacha" id="lastname" required=""/>
                    </p>
                    <p>
                    <label for="phoneNo">Phone number* :<br/></label>
                    <input type="text" name="phoneNo" placeholder="" id="phoneNo" required=""/>
                    </p>
                    <p>
                    <label for="email">Email address* :<br/></label>
                    <input type="email" name="email" placeholder="awe@.com" id="email"/>
                    </p>
                    <p>
                    <label for="passe">Enter your password* :</label></br>
                    <input type="password" name="password" id="password"/>
                    </p>
                    <p>
                    <label for="passe">Confirm password* :</label></br>
                    <input type="password" name="confirmPassword" id="confirmPassword"/>
                    </p>

                    <p> Gender* :
                    <select name="gender">
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    </select>
                    </p>
                    <input type="submit" value="Register" class="registerBtt"/>
                    </form>
                </div>
            </div>
        </div>
        <div id="bottom_wrapper">
            <div class="row1">
                <p><a href="index.jsp">Home</a> | <a href="aboutUs.jsp">About</a> | <a
                        href="checkout.jsp">Checkout</a> | <a href="contact.jsp">Contact Us</a>
            </div>
            <div class="row2">
                <div id="col1">
                    <h2>ABOUT US</h2>
                    <p>
                        Global Market is an exceptional source for <br>
                        unique handmade gifts,clothing,home decor,art and<br>
                        sculpture,books and personal accessories represent in<br>
                        the diverse cultures of artisans around the world. <br>
                    </p>
                </div>
                <div id="col2">
                    <h2>CONTACT INFO</h2>
                    <p>
                        Tel. :15927189207<br/>
                        Email: appacha@163.com<br/>
                        Facebook: <a href="http//facebook.com">Facebook</a>.<br/>
                        Twitter:<a href="http//twitter.com">Twitter</a> .<br/>
                    </p>
                </div>
            </div>

            <div class="row3">
                <h4>Copy right@2016 appacha WHU ISS</h4>
            </div>

        </div>
    </div>




</body>

</html>