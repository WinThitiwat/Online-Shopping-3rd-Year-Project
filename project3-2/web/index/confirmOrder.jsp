<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/30/2016
  Time: 5:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat" %>
<html>
<head>
    <title>$Title$</title>
</head>
<style type="text/css">
    @import "../css/main_style.css";
    @import "../css/shopping_cart_style.css";

</style>

<%
    Class.forName("org.gjt.mm.mysql.Driver").newInstance();
    String url = "jdbc:mysql://localhost/online_shopping";
    Connection conn = DriverManager.getConnection(url, "root", "123456789");
    Statement stmt2 = conn.createStatement();
    Statement stmt= conn.createStatement();
    ResultSet rs=null;
    ResultSet rss=null;
    String sql = "";
    String userID = "";
    String query_id = "";
    Double totalPrice=0.0;
    String statusPage = "offline";
    String imgPath = "";
    String product_name = "";
    int tempCid = 0;
    int orderID = 0;

    Object statusSite = session.getAttribute("STATUS");
    if(statusSite != null){
        statusPage = statusSite.toString();
        if (statusPage.equals("online")) {
            query_id = request.getParameter("query_id");
            Object tempUserID = session.getAttribute("USER_ID").toString();
            if (tempUserID != null) {
                userID = tempUserID.toString();
                sql = "SELECT *, SUM(quantity), SUM(total) FROM online_shopping.table_order_details "+
                        "WHERE order_id = (SELECT order_id FROM online_shopping.table_orders where(user_id = "+userID+" and order_status = 'buying')) GROUP BY product_id";

                rs = stmt.executeQuery(sql);
            }
        }
    }


    String address = request.getParameter("address");
    String payment_by = request.getParameter("group1");

    out.print(address);
    out.print(payment_by);

%>
<body>
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
    <%--/******************************************************************************--%>
    <%--<div style="clear: both"></div>--%>
    <%--<div class="cleaner "></div>--%>
    <div id="main_body_wrapper">
        <div id="main_body">
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

            <%--Log in & Register--%>
            <div id="main" class="float_r">
                <div>
                    <div style="margin-bottom: 20px">
                        <span>
                            <h2>Your shipping address:</h2>
                            <label style="width: 100%; height: auto; border: blue 2px solid; font-size: 17px;"><%=address%></label>
                        </span>
                    </div>
                    <hr>
                    <hr>
                    <div>
                        <table >
                            <tr class="firstRow" style="border-bottom: 1px black solid">

                                <th class="descCol wdDescCol">Name</th>
                                <th class="qntyCol wdQntyCol">Quantity</th>
                                <th class="priceCol wdPriceCol">Price(RMB)</th>
                                <th class="totalCol wdTotalCol">Total(RMB)</th>

                            </tr>
                            <%
                                String pid;
                                while(rs != null && rs.next()) {
                                    orderID = rs.getInt("order_id");
                                    pid = new String(rs.getString("product_id").getBytes("iso-8859-1"),"gb2312");
                                    rss = stmt2.executeQuery("SELECT product_title, category_id FROM online_shopping.table_products where product_id ="+rs.getInt("product_id"));
                                    out.print("<form action='deleteCartItem.jsp?id="+pid+"'>");
                                    out.print("<tr>");
                                    if(rss.next()) {
                                        tempCid = rss.getInt("category_id");
                                        imgPath = "../images/products/"+tempCid+"/"+pid+".jpg";
                                        product_name = rss.getString("product_title");

                                    }
                                    out.print("<td>"+product_name+"</td>");
                                    out.print("<td align='center'><label>"+rs.getInt("SUM(quantity)")+"</label></td>");
                                    out.print("<td align='right'>" + rs.getFloat("price") + "</td>");
                                    out.print("<td align='right'>" + new DecimalFormat("0.00").format(rs.getFloat("SUM(total)")) + "</td>");

                                    out.print("</tr>");
                                    totalPrice += rs.getFloat("SUM(total)");
                                }
                            %>
                            <tr >
                                <td colspan="2" style="border-bottom: none"></td>
                                <td align="right" style="background:#ddd; font-weight:bold"> Total </td>
                                <td style="background:#ddd; font-weight:bold" ><%=new DecimalFormat("0.00").format(totalPrice)%></td>
                            </tr>
                        </table>

                    </div>
                    <br>
                    <br>
                    <br>
                    <div class="float_r">
                        <%out.print("<a href='redirect.jsp?action=confirmOrder&oid="+orderID+"' >Confirm Orders</a>");%>
                    </div>
                </div>
            </div>
            <div class="cleaner h10"></div>
        </div>
    </div>
    <%--/******************************************************************************--%>
    <div class="cleaner h10"></div>
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

