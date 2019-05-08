<%--
Created by IntelliJ IDEA.
User: thitiwat
Date: 7/13/2016
Time: 2:33 PM
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<html>
<head>
    <title>$Title$</title>
</head>
<style type="text/css">
    @import "../css/main_style.css";
    @import "../css/login_and_register.css";
    /*@import "../css/full-slider.css";*/
    /*@import "../css/bootstrap.min.css";*/
</style>

<script src="../js/jquery-1.4.1.min.js" type="text/javascript"></script>
<script src="../js/jquery.jcarousel.pack.js" type="text/javascript"></script>
<script src="../js/jquery-func.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/operator.js"></script>
<script language="JavaScript">

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

</script>
<body>
<%-----JSP Initiation --------%>
<%
    try{
    //   --- Database connection init ---
        Class.forName("org.gjt.mm.mysql.Driver").newInstance();
        String url ="jdbc:mysql://localhost/online_shopping";
        Connection conn= DriverManager.getConnection(url,"root","123456789");
//    //    ------ stmt & query --------
        ResultSet  rss = null;
        Statement stmt2 = conn.createStatement();
        String statusPage = "offline";
        String imgPath = "";
        String product_name = "";
        session.setAttribute("NUMBER_OF_CART_ITEMS", 0);
        Object statusSite = session.getAttribute("STATUS");

        if(statusSite!= null) {
            statusPage = statusSite.toString();
            if(statusPage.equals("online")) {
                String userID=  session.getAttribute("USER_ID").toString();
                String queryItemNo = "select count(distinct(product_id)) as number_product from online_shopping.table_order_details\n" +
                        " where order_id =(select order_id from online_shopping.table_orders where (user_id = " + userID + " and order_status = 'buying'))";
                rss = stmt2.executeQuery(queryItemNo);
                if (rss.next()) {
                    session.setAttribute("NUMBER_OF_CART_ITEMS", rss.getInt("number_product"));
                }
                stmt2.close();
                rss.close();

            }
        }
        int counter = 1;
        String pid;

%>
<%-----  HTML Part ---------%>
<div id="wrapper">

    <div id="header_wrapper">
        <div  id="loginBar">
            <%
                if(statusPage.equals("offline")){
                    out.print("<a href='login.jsp?parent=homepage&etc=?' class='loginBar'>Sign in</a>");
                }else{
                    out.print("<a href='redirect.jsp?action=signout'>Sign out</a>");
                    out.print("<a href='../user/my_account.jsp' id='username'>Welcome ("+session.getAttribute("USER_NAME").toString() +") </a>");
                }
                out.print("&nbsp"+statusPage);
            %>
        </div>
        <div style="height: auto; width: auto; background-color: white;">
            <div id="header"></div>
        </div>
        <div id="menubar_wrapper">
            <div id="menubar">
                <div class="float_l" id="menus">
                    <div id="navigation">
                        <ul>
                            <li><a href="index.jsp"class="active">Home</a></li>
                            <li><a href="storeFront.jsp">The Store</a></li>
                            <li><a href="contact.jsp">Contact</a></li>
                            <li><a href="aboutUs.jsp" >About Us</a></li>
                        </ul>
                    </div>
                </div>
                <div class="float_r">
                    <%if(statusPage.equals("online")){%>
                    <div class="float_l">
                        <div id="my_acc">
                            <ul>
                                <li><a href="../user/my_account.jsp" >My Account</a></li>
                            </ul>
                        </div>
                    </div>
                    <%}%>
                    <div class="float_r">
                        <div id="cart">
                            <a href="shoppingCart.jsp" class="cart-link">Your Shopping Cart</a>
                            <div class="cl">&nbsp;</div>
                            <div style="text-align: center; font-size: 25px">
                                <%out.print("<span >Articles: <strong>"+session.getAttribute("NUMBER_OF_CART_ITEMS") +"</strong></span>");%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--/******************* End of header_wrapper *****************--%>
    <div id="main_wrapper">

        <%--/******************* End of menubar_wrapper *****************--%>
        <div id="main_body_wrapper">
            <div id="main_body">
                <%--************** Sidebar ***************--%>
                <div id="sidebar" class="float_l">
                    <div class="box search">
                        <h2>Search by <span></span></h2>
                        <div class="box-content">
                            <form action="searchResult.jsp?type=normal" method="post">
                                <label>Keyword</label>
                                <input type="text" class="field" name="keyword"/>
                                <input type="submit" class="search-submit" value="Search"/>
                            </form>
                            <div class="cleaner h20">

                            </div>
                            <a href="advanceSearch.jsp" class="advancedSearch">Advanced Search >></a>
                        </div>

                    </div>

                    <div class="box categories">
                        <h2>Categories <span></span></h2>
                        <div class="box-content" style="float: left">
                            <ul>
                                <li>
                                    <a id="myHeader1" href="product.jsp?cid=6">Clothing</a>
                                </li>
                                <li>
                                    <a id="myHeaders2" href="product.jsp?cid=7">Souvenirs</a>
                                </li>
                                <li class="last">
                                    <a id="myHeaders3" href="product.jsp?cid=8">Stationery</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <%--/*************** Main content ******************--%>
                <div id="main" class="float_r">
                    <div id="welcoming">
                        <marquee>
                            <h1>. . . Welcome to Global Market . . .</h1>
                        </marquee>


                    </div>
                    <div style=" height: 450px">
                        <div id="promotion_wrapper">
                            <div id="slider" class="box">
                                <div id="slider-holder">
                                    <ul>
                                    <%
                                        Statement stmt6=conn.createStatement();
                                        ResultSet rs6 = stmt6.executeQuery("SELECT * FROM online_shopping.table_products WHERE product_last_update = '2016-07-28'");
                                        counter = 0;
                                        int cid = 0;
                                        while(rs6!=null && rs6.next()) {
                                            counter++;
                                            pid = new String(rs6.getString("product_id").getBytes("iso-8859-1"), "gb2312");
                                            cid = rs6.getInt("category_id");
                                            imgPath = "../images/promotions/promotion"+counter+".jpg";
                                            product_name = rs6.getString("product_title");
                                            out.print("<li>");

                                                out.print("<a href='productDetail.jsp?pid=" + pid + "'><img  src='"+imgPath+"' alt='"+product_name+"' /></a>");

                                            out.print("<div class='imgDescription'>"+rs6.getString("product_description")+"</div>");
                                            out.print("</li>");
                                            if(counter == 3) break;
                                        }
                                        counter = 1;
                                        stmt6.close();
                                        rs6.close();
                                    %>

                                    </ul>
                                    <div style="height: 50px; color: #000; ">Hello world</div>
                                </div>
                                <div id="slider-nav">
                                    <a href="#" class="active">1</a>
                                    <a href="#">2</a>
                                    <a href="#">3</a>
                                    <%--<a href="#">4</a>--%>
                                </div>
                                <%--</div>--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="cleaner h10"></div>
                <%--***********  Category1 overviews ***************--%>
                <div id="product_overview">
                    <div class="topic">Clothing</div>
                    <div class="productList">

                        <%
                            Statement stmt3=conn.createStatement();
                            ResultSet rs2 = stmt3.executeQuery("SELECT * FROM online_shopping.table_products WHERE category_id = 6");

                            while(rs2!=null && rs2.next()) {

                                pid = new String(rs2.getString("product_id").getBytes("iso-8859-1"),"gb2312");
                                if (counter % 5 == 0){
                                    break;
                                }
                                out.print("<div class='product_box'>");
                                imgPath = "../images/products/"+6+"/"+pid+".jpg";
                                product_name = rs2.getString("product_title");
                                if(rs2.getInt("product_remaining_amount")==0) {
                                    out.print(" <img src='../images/info.png'style='background-image:url("+imgPath+");' class='outOfStock'/>");
                                    out.print("<h3>Code: " + pid + "</h3>");
                                    out.print("<h3 class='product_name'>" + product_name + "</h3>");
                                    out.print("<p class='product_price'>" + rs2.getFloat("product_price") + " RMB</p>");
                                    out.print("<h2 style='color:red;'>Out of stock !!!</h2>");
                                }
                                else{
                                    out.print("<a href='productDetail.jsp?action=detail&pid="+pid+"'><img src='"+imgPath+"' alt='"+product_name+"'  /></a>");
                                    out.print("<h3>Code: " + pid + "</h3>");
                                    out.print("<h3 class='product_name'>" + product_name+ "</h3>");
                                    out.print("<p class='product_price'>" + rs2.getFloat("product_price") + " RMB</p>");
                                    out.print("<a href='productDetail.jsp?pid="+pid+"' class='detail'><button class='addtocart'></button></a>");

                                }

                                out.print("</div>");
                                counter++;
                            }

                            stmt3.close();
                            rs2.close();
                            counter = 1;
                        %>

                    </div>
                    <div class="view_more"><a href="product.jsp?cid=6">View more</a></div>
                </div>
                <div class="cleaner h30"></div>
                <%--***********  Category2 overviews ***************--%>
                <div id="product_overview">
                    <div class="topic">
                        Souvenirs
                    </div>
                    <div class="productList">
                        <%
                            Statement stmt=conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM online_shopping.table_products WHERE category_id = 7");

                            while(rs!=null && rs.next()) {
                                pid = new String(rs.getString("product_id").getBytes("iso-8859-1"),"gb2312");
                                if (counter % 5 == 0){
                                    break;
                                }
                                out.print("<div class='product_box'>");
                                imgPath = "../images/products/"+7+"/"+pid+".jpg";
                                product_name = rs.getString("product_title");
                                if(rs.getInt("product_remaining_amount")==0) {
                                    out.print(" <img src='../images/info.png' style='background-image: url("+imgPath+");' class='outOfStock'/>");
                                    out.print("<h3>Code: " + pid + "</h3>");
                                    out.print("<h3 class='product_name'>" +product_name + "</h3>");
                                    out.print("<p class='product_price'>" + rs.getFloat("product_price") + " RMB</p>");
                                    out.print("<h2 style='color:red;'>Out of stock !!!</h2>");
                                }
                                else{
                                    out.print("<a href='productDetail.jsp?action=detail&pid="+pid+"'><img src='"+imgPath+"' alt='"+product_name+"'  /></a>");
                                    out.print("<h3>Code: " + pid + "</h3>");
                                    out.print("<h3 class='product_name'>" +product_name + "</h3>");
                                    out.print("<p class='product_price'>" + rs.getFloat("product_price") + " RMB</p>");
                                    out.print("<a href='productDetail.jsp?pid="+pid+"' class='detail'><button class='addtocart'></button></a>");

                                }

                                out.print("</div>");
                                counter++;
                            }

                            stmt.close();
                            rs.close();
                            counter = 1;
                        %>

                    </div>

                    <div class="view_more"><a href="product.jsp?cid=7">View more >>> </a></div>
                </div>
                <div class="cleaner h30"></div>
                    <%--***********  Category3 overviews ***************--%>
                <div id="product_overview">
                    <div class="topic">Stationary</div>
                    <div class="productList">
                        <%
                            Statement stmt4=conn.createStatement();
                            ResultSet rs4 = stmt4.executeQuery("SELECT * FROM online_shopping.table_products WHERE category_id = 8");

                            while(rs4!=null && rs4.next()) {
                                pid = new String(rs4.getString("product_id").getBytes("iso-8859-1"),"gb2312");
                                if (counter % 5 == 0){
                                    break;
                                }
                                out.print("<div class='product_box'>");
                                imgPath = "../images/products/"+8+"/"+pid+".jpg";
                                product_name = rs4.getString("product_title");
                                if(rs4.getInt("product_remaining_amount")==0) {
                                    out.print(" <img src='../images/info.png' style='background-image: url("+imgPath+");' class='outOfStock'/>");
                                    out.print("<h3>Code: " + pid + "</h3>");
                                    out.print("<h3 class='product_name'>" + product_name + "</h3>");
                                    out.print("<p class='product_price'>" + rs4.getFloat("product_price") + " RMB</p>");
                                    out.print("<h2 style='color:red;'>Out of stock !!!</h2>");
                                }
                                else{
                                    out.print("<a href='productDetail.jsp?action=detail&pid="+pid+"'><img src='"+imgPath+"' alt='"+product_name+"'  /></a>");
                                    out.print("<h3>Code: " + pid + "</h3>");
                                    out.print("<h3 class='product_name'>" + product_name + "</h3>");
                                    out.print("<p class='product_price'>" + rs4.getFloat("product_price") + " RMB</p>");
                                    out.print("<a href='productDetail.jsp?pid="+pid+"' class='detail'><button class='addtocart'></button></a>");

                                }

                                out.print("</div>");
                                counter++;
                            }

                            stmt4.close();
                            rs4.close();
                            counter = 1;
                        %>
                    </div>

                    <div class="view_more"><a href="product.jsp?cid=8">View more</a></div>
                </div>
                <div class="cleaner h30"></div>
            </div>
            <%--/******************************************************************************--%>
            <div class="cleaner h10"></div>

        </div>
        <%--/******************* End of main_body_wrapper *****************--%>

    </div>
    <%--/******************* End of main_wrapper *****************--%>
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

<div id="overlay">
    <%--<div class="div2">--%>

        <%--<div class="tableau-l">--%>

            <%--<h1 class="dodo-1">login page</h1>--%>
            <%--<form method ="post" action="../redirect.jsp?">--%>
            <%--</form>--%>
            <%--<p>--%>
                <%--<label for="pseudo">enter your name :</label>--%>
                <%--<input type ="text" name="pseudo" />--%>
            <%--</p>--%>




            <%--<p>--%>
                <%--<label for ="passe">enter the password :</label>--%>
                <%--<input type ="password" name ="passe" />--%>
            <%--</p>--%>
            <%--<button>login</button>--%>

        <%--</div>--%>
        <%--<div class="tableau-r">--%>

            <%--<h1 class="dodo-1">register</h1>--%>
            <%--<form method ="post" action="traiment.php">--%>
            <%--</form>--%>

            <%--<p>--%>
                <%--<label for ="coco">enter your name :</label>--%>
                <%--<input type ="text" name="coco" />--%>
            <%--</p>--%>
            <%--<p> choose your :<br/><br/>--%>

                <%--<input type="checkbox" name="man" id="man"/>--%>
                <%--<label for="man">masculin</label> <br/>--%>

                <%--<input type="checkbox" name="woman" id="woman"/>--%>
                <%--<label for= "woman">feminin</label>--%>
            <%--</p>--%>
            <%--<p>--%>
                <%--<label for ="passe">enter the password :</label>--%>
                <%--<input type ="password" name ="passe" />--%>
            <%--</p>--%>
            <%--<p>--%>
                <%--<label for="email">enter your email address :</label>--%>
                <%--<input type="email" name="email" id="email" />--%>
            <%--</p>--%>
            <%--<p>--%>
                <%--<label for = "site">enter your web site name :</label>--%>
                <%--<input type="url" name="site"	id="site"/>--%>
            <%--</p>--%>
            <%--<p>--%>
                <%--<label for ="tel"> enter your phone number :</label>--%>
                <%--<input type="tel" name="num" id="nume"/>--%>

            <%--<p><button>register</button></p>--%>
            <%--</p>--%>


        <%--</div>--%>


    <%--</div>--%>
    <div>
        Click here to [<a href="#" onclick='overlay()'>close</a>]
    </div>

</div>

<%
    conn.close();
    }catch(Exception e){
    out.print(e);
    }
%>
</body>
</html>


<%--<ul>--%>
    <%--<li>--%>
        <%--<a href="productDetail.jsp"><img src="../images/tempImg1.jpg" alt="" /></a>--%>
        <%--<div class="product_info">--%>
            <%--<h3><a href="productDetail.jsp">Product Title</a></h3>--%>
            <%--<div class="product_desc">--%>
                <%--<p>Product Description</p>--%>
                <%--<strong class="price">$185</strong>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a href="productDetail.jsp"><img src="../images/tempImg2.jpg" alt="" /></a>--%>
        <%--<div class="product_info">--%>
            <%--<h3><a href="productDetail.jsp">Product Title</a></h3>--%>
            <%--<div class="product_desc">--%>
                <%--<p>Product Description</p>--%>
                <%--<strong class="price">$185</strong>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a href="productDetail.jsp"><img src="../images/tempImg3.jpg" alt="" /></a>--%>
        <%--<div class="product_info">--%>
            <%--<h3><a href="productDetail.jsp">Product Title</a></h3>--%>
            <%--<div class="product_desc">--%>
                <%--<p>Product Description</p>--%>
                <%--<strong class="price">$185</strong>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a href="productDetail.jsp"><img src="../images/tempImg4.jpg" alt="" /></a>--%>
        <%--<div class="product_info">--%>
            <%--<h3><a href="productDetail.jsp">Product Title</a></h3>--%>
            <%--<div class="product_desc">--%>
                <%--<p>Product Description</p>--%>
                <%--<strong class="price">$185</strong>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</li>--%>

<%--</ul>--%>


<%--*****************************************--%>

<%--<li>--%>
    <%--<a id="myHeaders3" href="javascript:toggle2('myContents3','myHeaders3');">Category--%>
        <%--3</a>--%>
    <%--<div class="contentDiv">--%>
        <%--<div id="myContents3" style="display: none;">--%>
            <%--<ul>--%>
                <%--<li><a href="#">Category 3.1</a></li>--%>
                <%--<li><a href="#">Category 3.2</a></li>--%>
                <%--<li><a href="#">Category 3.3</a></li>--%>
                <%--<li><a href="#">Category 3.4</a></li>--%>
            <%--</ul>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</li>--%>