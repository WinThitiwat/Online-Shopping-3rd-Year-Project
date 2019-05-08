<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/19/2016
  Time: 3:15 PM
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
<%
    try {

        Class.forName("org.gjt.mm.mysql.Driver").newInstance();
        String url = "jdbc:mysql://localhost/online_shopping";
        Connection conn = DriverManager.getConnection(url, "root", "123456789");
        Statement stmt = conn.createStatement();
        Statement stmt2 = conn.createStatement();
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

                    <table >
                        <tr class="firstRow" style="border-bottom: 1px black solid">
                            <th class="imageCol wdImg">Image</th>
                            <th class="descCol wdDescCol">Description</th>
                            <th class="qntyCol wdQntyCol">Quantity</th>
                            <th class="priceCol wdPriceCol">Price(RMB)</th>
                            <th class="totalCol wdTotalCol">Total(RMB)</th>
                            <th class="wdRemoveCol"></th>
                        </tr>
                        <%
                            String pid;
                            while(rs != null && rs.next()) {
                                pid = new String(rs.getString("product_id").getBytes("iso-8859-1"),"gb2312");
                                rss = stmt2.executeQuery("SELECT product_title, category_id FROM online_shopping.table_products where product_id ="+rs.getInt("product_id"));
                                out.print("<form action='deleteCartItem.jsp?id="+pid+"'>");
                                out.print("<tr>");
                                if(rss.next()) {
                                    tempCid = rss.getInt("category_id");
                                    imgPath = "../images/products/"+tempCid+"/"+pid+".jpg";
                                    product_name = rss.getString("product_title");
                                    out.print("<td><a href='productDetail.jsp?pid="+pid+"'><img src='"+imgPath+"' alt='Cannot display'/></a></td>");
                                    out.print("<td>"+product_name+"</td>");}
                                    out.print("<td align='center'><input type='number' name='qnty' id='qnty' value="+rs.getInt("SUM(quantity)")+" style='width:40px; text-align: right'/></td>");
                                    out.print("<td align='right'>" + rs.getFloat("price") + "</td>");
                                    out.print("<td align='right'>" + new DecimalFormat("0.00").format(rs.getFloat("SUM(total)")) + "</td>");
                                    out.print(" <td align='center'> <a href='deleteCartItem.jsp?id="+pid+"' style='color: red;text-decoration: underline'>Remove</a> </td>");


                                    out.print("</tr>");
                                    totalPrice += rs.getFloat("SUM(total)");
                                }
                        %>
                        <tr >
                            <%--<td class="confirmCol" colspan="3" id="lastRow">Have you modified your basket? Please click here to <a href="shoppingCart.jsp"><strong>Update</strong></a>&nbsp;&nbsp;</td>--%>
                            <td colspan="3" style="border-bottom: none"></td>
                            <td align="right" style="background:#ddd; font-weight:bold"> Total </td>

                            <td style="background:#ddd; font-weight:bold" ><%=new DecimalFormat("0.00").format(totalPrice)%></td>
                        </tr>
                    </table>
                </form>
                <div style="float:right; width: 250px; margin-top: 20px;">
                    <p><a href="checkout.jsp">Proceed to checkout</a></p>
                    <p><a href="index.jsp">Continue shopping</a></p>
                </div>

            </div>

            <div class="cleaner h10"></div>
            <%--Products overviews--%>
            <div id="productList">

            </div>
        </div>
        <%--/******************************************************************************--%>
        <div class="cleaner h10"></div>
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
    }catch(ClassNotFoundException cnfe){
        out.print("Hello ClassNotFound");
        out.print(cnfe);
    }catch(SQLException sqle){
        out.print("Hello SQLException");
        out.print(sqle);
    }catch(Exception e){
        out.print("Hello Exception");
        out.print(e);
    }
%>
</body>
</html>


<%--<table width="680px" cellspacing="0" cellpadding="5">--%>
    <%--<tr bgcolor="#ddd">--%>
        <%--<th width="220" align="center">Image </th>--%>
        <%--<th width="180" align="left">Description </th>--%>
        <%--<th width="100" align="center">Quantity </th>--%>
        <%--<th width="60" align="right">Price </th>--%>
        <%--<th width="60" align="right">Total </th>--%>
        <%--<th width="90"> </th>--%>

    <%--</tr>--%>

    <%--<%--%>
        <%--String query_id2;--%>
        <%--while(rs!=null && rs.next()) {--%>
            <%--query_id2 = new String(rs.getString("product_id").getBytes("iso-8859-1"),"gb2312");--%>
            <%--rss = stmt2.executeQuery("SELECT product_title FROM online_shopping.table_products where product_id ="+rs.getInt("product_id"));--%>

            <%--out.print("<tr>");--%>
            <%--out.print("<td><a href='productdetail.jsp?action=detail&query_id="+query_id2+"'><img src='images/mathbook-cover.jpg' alt='Cannot display'/></a></td>");--%>
            <%--if(rss.next()) {out.print("<td>"+rss.getString("product_title")+"</td>");}--%>
            <%--out.print("<td align='center'><input type='text' value="+rs.getInt("sum(quantity)")+" style='width:20px; text=align: right'/></td>");--%>
            <%--out.print("<td align='right'>$" + rs.getFloat("price") + "</td>");--%>
            <%--out.print("<td align='right'>$" + rs.getFloat("sum(total)") + "</td>");--%>
            <%--out.print(" <td align='center'> <a href='deleteItemFromCart.jsp?id="+rs.getInt("product_id")+"'style='color: red;text-decoration: underline'> <strong>Remove</strong> </a> </td>");--%>
            <%--out.print("</tr>");--%>
            <%--totalPrice += rs.getFloat("SUM(total)");--%>
        <%--}--%>

    <%--%>--%>

    <%--<tr>--%>
        <%--<td colspan="3" align="right"  height="30px">Have you modified your basket? Please click here to <a href="shoppingcart.jsp"><strong>Update</strong></a>&nbsp;&nbsp;</td>--%>
        <%--<td align="right" style="background:#ddd; font-weight:bold"> Total </td>--%>
        <%--<%--%>
            <%--out.print("<td align='right' style='background:#ddd; font-weight:bold; text-decoration: underline'>$"+String.format("%.2f",totalPrice)+"</td>");--%>
        <%--%>--%>
        <%--<td style="background:#ddd; font-weight:bold"> </td>--%>
    <%--</tr>--%>
<%--</table>--%>