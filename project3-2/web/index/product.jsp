<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/20/2016
  Time: 3:50 PM
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
    @import "../css/store_front_style.css";

</style>

<script type="text/javascript" src="../js/jquery.leanModal.min.js"></script>

<script language="JavaScript">

    function increment(){
        var quantity = parseInt(document.getElementById("quantity").value);
        quantity = quantity + 1;
        document.getElementById("quantity").value = quantity;

    }

    function decrement(){
        var quantity = parseInt(document.getElementById("quantity").value);
        if(quantity >= 2){
            quantity = quantity - 1;
        }
        document.getElementById("quantity").value = quantity;
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

<%
    try{
        String statusPage = "offline";
        Object statusSite = session.getAttribute("STATUS");
        if(statusSite != null){
            statusPage = statusSite.toString();
        }

        Class.forName("org.gjt.mm.mysql.Driver").newInstance();
        String url ="jdbc:mysql://localhost/online_shopping";
        Connection conn= DriverManager.getConnection(url,"root","123456789");

        ResultSet  rs = null;
        Statement stmt=conn.createStatement();
        String cid = request.getParameter("cid");
        String pid;
        int counter = 0;
        String sql = "SELECT * FROM online_shopping.table_products WHERE category_id="+cid;
        String[] categoryList = {"0","1","2","3","4","5","Clothing","Souvenirs","Stationary"};

        rs = stmt.executeQuery(sql);


%>
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
                            <li><a href="index.jsp" >Home</a></li>
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

    <%--/******************* End of menubar_wrapper *****************--%>
    <%--/******************* End of header_wrapper *****************--%>
    <div id="main_wrapper">

        <div id="main_body_wrapper">
            <div id="main_body">
                <%--************** Sidebar ***************--%>
                <div id="sidebar" class="float_l">
                    <div class="box search">
                        <h2>Search by <span></span></h2>
                        <div class="box-content">
                            <form action="searchResult.jsp" method="post">
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
                    <h1><%=categoryList[Integer.parseInt(cid)]%></h1>
                    <div class="productList">
                        <%
                            int tempCid = 0;
                            String imgPath = "";
                            String product_name = "";
                            while(rs!=null && rs.next()) {
                                pid = new String(rs.getString("product_id").getBytes("iso-8859-1"),"gb2312");
                                if (counter % 3 == 0){
                                    out.print("<div class='cleaner h30'></div>");
                                }
                                out.print("<div class='product_box'>");
                                tempCid = rs.getInt("category_id");
                                imgPath = "../images/products/"+tempCid+"/"+pid+".jpg";
                                product_name = rs.getString("product_title");
                                if(rs.getInt("product_remaining_amount")<=0) {
                                    out.print(" <img src='../images/info.png' style='background-image: url("+imgPath+");' class='outOfStock' />");
                                    out.print("<h3>Code: " + pid + "</h3>");
                                    out.print("<h3 class='product_name'>" + product_name + "</h3>");
                                    out.print("<p class='product_price'>" + rs.getFloat("product_price") + " RMB</p>");
                                    out.print("<h2 style='color:red;'>Out of stock !!!</h2>");
                                }
                                else{
                                    out.print("<a href='productDetail.jsp?action=detail&pid="+pid+"'><img src='"+imgPath+"'   alt='"+product_name+"'  /></a>");
                                    out.print("<h3>Code: " + pid + "</h3>");
                                    out.print("<h3 class='product_name'>" + rs.getString("product_title") + "</h3>");
                                    out.print("<p class='product_price'>" + rs.getFloat("product_price") + " RMB</p>");
                                    out.print("<a href='productDetail.jsp?action=detail&pid="+pid+"' class='detail'><button class='addtocart'></button></a>");

                                }

                                out.print("</div>");
                                counter++;
                            }
                        %>

                        <div class="cleaner h30"></div>

                    </div>
                    <div class="cleaner h10"></div>
                </div>
                <%--/******************************************************************************--%>
                <div class="cleaner h10"></div>

            </div>
            <%--/******************* End of main_body_wrapper *****************--%>

        </div>
        <%--/******************* End of main_wrapper *****************--%>

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
<%
        rs.close();
        stmt.close();
        conn.close();
    }catch(Exception e){
        out.print(e);
    }

%>
</body>
</html>



