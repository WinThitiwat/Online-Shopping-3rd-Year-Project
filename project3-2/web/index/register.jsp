<!--Created by -->
<!--User: Cedric-->
<!--Date: 7/25/2016-->
<!--Time: 11:07 AM-->
<!--To change this template use File | Settings | File Templates.-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>

    <title></title>
    <meta charset="uft-8"/>

    <style>
        @import "../css/login_and_register.css";
        @import "../css/main_style.css";
    </style>

    <script type="text/javascript" src="../js/operator.js"></script>
    <%--<script language="JavaScript">--%>


</head>


<body>
<div class="plan">

    <div class="tosa">

        <div class="tango-2">


            <div class="tableau-1">


                <div class="prima-1">


                </div>


                <div class="prima-2">


                    <p id="bote-2">welcome in apacha online shopping </p>

                    <p class="petit-2">at apacha you are satisfy or remboursed
                        the customer are king

                    </p>

                </div>


            </div>


            <div class="tableau-2">

                <h1 class="attak">register</h1>
                <form method="post" onsubmit="return checkRegisterInput(this);" action="redirect.jsp?action=register">


                    <p>
                        <label for="coco">Enter your first name :<br/></label>
                        <input type="text" name="firstname" placeholder="appacha " id="firstname" value=""/>
                    </p>
                    <p>
                        <label for="coco">Enter your last name :<br/></label>
                        <input type="text" name="lastname" placeholder="appacha" id="lastname" required=""/>
                    </p>
                    <p>
                        <label for="phoneNo">Enter your phone number :<br/></label>
                        <input type="text" name="phoneNo" placeholder="" id="phoneNo" required=""/>
                    </p>
                    <p>
                        <label for="email">Enter your email address :<br/></label>
                        <input type="email" name="email" placeholder="awe@.com" id="email"/>
                    </p>
                    <p>
                        <label for="passe">Enter your password :</label></br>
                        <input type="password" name="password" id="password"/>
                    </p>
                    <p>
                        <label for="passe">Confirm password :</label></br>
                        <input type="password" name="confirmPassword" id="confirmPassword"/>
                    </p>

                    <p> choose your :
                        <select name="gender">
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                        </select>
                    </p>


                    <%--<p>--%>

                        <%--<label for="year"> year: </label>--%>

                        <%--<select name="year" id="year">--%>
                            <%--<optgroup label="year">--%>
                                <%--<%--%>
                                    <%--for (int year = 1950; year < 2007; year++)--%>
                                        <%--out.print("<option value=" + year + ">" + year + "</option>");--%>
                                <%--%>--%>

                            <%--</optgroup>--%>
                        <%--</select>--%>


                        <%--<label for="day"> day: </label>--%>

                        <%--<select name="day" id="day">--%>
                            <%--<optgroup label="day">--%>
                                <%--<%--%>
                                    <%--for (int day = 1; day <= 31; day++)--%>
                                        <%--out.print("<option value=" + day + ">" + day + "</option>");--%>
                                <%--%>--%>


                            <%--</optgroup>--%>
                        <%--</select>--%>


                        <%--<label for="month"> month: </label>--%>

                        <%--<select name="month" id="month">--%>
                            <%--<optgroup label="month">--%>
                                <%--<%--%>
                                    <%--for (int month = 1; month <= 12; month++)--%>
                                        <%--out.print("<option value=" + month + ">" + month + "</option>");--%>
                                <%--%>--%>
                            <%--</optgroup>--%>
                        <%--</select>--%>


                    <%--</p>--%>


                    <input type="submit" value="Register">


                </form>

                <p>
                <div class="cleaner h50"></div>
                <a href="login.jsp">
                    <button><< Back to Login page</button>
                </a>

                </p>
            </div>


        </div>

        <div class="ordre-2">


            <div id="bottom_wrapper">
                <div class="row1">
                    <p><a href="index.jsp">Home</a> | <a href="aboutUs.jsp">About</a> | <a
                            href="checkout.jsp">Checkout</a> | <a href="contact.jsp">Contact Us</a>
                </div>
                <div class="row2">
                    <div id="col1">
                        <h2>ABOUT US</h2>
                        <p>
                            At appacha online.<br/>
                            shopping the customer.<br/>
                            are the king you are.<br/>
                            satisfy or remboursed.<br/>
                            .<br/>
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


    </div>
</div>

</body>

</html>

