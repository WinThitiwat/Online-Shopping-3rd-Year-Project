<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/27/2016
  Time: 3:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<html>
<head>
    <title>$Title$</title>
</head>
<style type="text/css" media="all">
    @import "../css/main_style.css";
    @import "../css/shopping_cart_style.css";
    /**************************************************************/
</style>


<%--*********************************************************--%>
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
    String statusPage = "offline";
    Object statusSite = session.getAttribute("STATUS");
    if(statusSite != null){
        statusPage = statusSite.toString();
    }

    Class.forName("org.gjt.mm.mysql.Driver").newInstance();
    String url = "jdbc:mysql://localhost/online_shopping";
    Connection conn = DriverManager.getConnection(url, "root", "123456789");

    Statement stmt = conn.createStatement();
    ResultSet rs = null;
    String userID=  session.getAttribute("USER_ID").toString();

    String query = "SELECT * FROM online_shopping.table_orders WHERE user_id="+userID;
    rs = stmt.executeQuery(query);
%>
<body>
<div id="wrapper">
    <div id="header_wrapper">
        <div  id="loginBar">
            <%
                if(statusPage.equals("offline")){
                    out.print("<a href='login.jsp?parent=homepage&etc=?' class='loginBar'>Sign in</a>");
                }else{

                    out.print("<a href='../index/redirect.jsp?action=signout'>Sign out</a>");
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
                            <li><a href="my_account.jsp"  >Personal Info</a></li>
                            <li><a href="history_order.jsp" class="active">History orders</a></li>
                        </ul>
                    </div>
                </div>
                <div class="float_r">
                    <%if(statusPage.equals("online")){%>
                    <div class="float_l">
                        <div id="my_acc">
                            <ul>
                                <li><a href="../index/index.jsp" >Home page</a></li>
                            </ul>
                        </div>
                    </div>
                    <%}%>
                    <div class="float_r">
                        <div id="cart">
                            <a href="../index/shoppingCart.jsp" class="cart-link">Your Shopping Cart</a>
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

            <table >
                <tr class="firstRow" style="border-bottom: 1px black solid; ">
                    <th class="qntyCol wdQntyCol">Order ID</th>
                    <th class="qntyCol wdQntyCol">Order Date</th>
                    <th class="qntyCol wdQntyCol">Order Time </th>
                    <th class="qntyCol wdQntyCol">Order Status</th>
                    <th class="totalCol wdTotalCol"></th>
                    <%--<th class="wdRemoveCol"></th>--%>
                </tr>
                <%
                    while (rs != null && rs.next()){
                        out.print("<tr style='height:50px;'>");
                %>



                        <td class="description"><%=rs.getInt("order_id")%></td>
                        <td class="description"><%=rs.getString("order_date")%></td>
                        <td class="description"><%=rs.getString("order_time")%></td>
                        <td class="description"><%=rs.getString("order_status")%></td>
                        <td class="description"><a href="#" style="font-weight: bold;">View detail</a> </td>

                <%
                        out.print("</tr>");
                    }
                %>

                </table>
        </div>
    </div>
    <%--/******************************************************************************--%>
    <div class="cleaner h10"></div>
    <div id="bottom_wrapper">
        <div class="row1">
            <p><a href="../index/index.jsp">Home</a> | <a href="../index/aboutUs.jsp">About</a> | <a
                    href="../index/checkout.jsp">Checkout</a> | <a href="../index/contact.jsp">Contact Us</a>
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

</body>
</html>

