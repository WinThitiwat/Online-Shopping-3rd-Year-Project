<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/19/2016
  Time: 3:10 PM
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
</style>
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
    String statusPage = "offline";
    Object statusSite = session.getAttribute("STATUS");
    if(statusSite != null){
        statusPage = statusSite.toString();
    }

    Class.forName("org.gjt.mm.mysql.Driver").newInstance();
    String url ="jdbc:mysql://localhost/online_shopping";
    Connection conn= DriverManager.getConnection(url,"root","123456789");
    Statement stmt=conn.createStatement();
    ResultSet rs = null;

    Float   p_price;
    String pid = request.getParameter("pid");
    String imgPath = "";
    String product_name = "";
    int tempCid = 0;

    String query = "SELECT * FROM online_shopping.table_products WHERE product_id = "+pid;

    rs = stmt.executeQuery(query);
    String[] categoryList = {"0","1","2","3","4","5","Clothing","Souvenirs","Stationary"};

    while(rs.next() && rs != null){
        p_price = rs.getFloat("product_price");
        tempCid = rs.getInt("category_id");
        imgPath = "../images/products/"+tempCid+"/"+pid+".jpg";
        product_name = rs.getString("product_title");
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
                            <li><a href="aboutUs.jsp">About Us</a></li>
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
                    <h1><%=product_name%></h1>
                    <div id="content product_detail_content">
                        <div class="float_l" id="product_detail_img_wrapper">
                            <img src="<%=imgPath%>" />


                        </div>

                        <div class="float_r" id="product_detail_about_wrapper">
                            <div id="product_detail_about">

                                <%
                                out.print("<form action='addToCart.jsp?pid="+pid+"&prices="+p_price+"' method='post'>");

                                %>
                                    <table>
                                        <tr>
                                            <td class="headTB">Product code:</td>
                                            <td class="tailTB"><%=rs.getInt("product_id")%></td>
                                        </tr>
                                        <tr>
                                            <td class="headTB">Category type:</td>
                                            <td class="tailTB"><%=categoryList[rs.getInt("category_id")]%></td>
                                        </tr>
                                        <tr>
                                            <td class="headTB">Price:</td>
                                            <td class="tailTB"><%=rs.getFloat("product_price")%></td>
                                        </tr>
                                        <tr>
                                            <td class="headTB">Last update:</td>
                                            <td class="tailTB"><%=rs.getString("product_last_update")%></td>
                                        </tr>
                                        <tr>
                                            <td class="headTB">Remaining:</td>
                                            <td class="tailTB"><%=rs.getInt("product_remaining_amount")%>&nbsp;&nbsp;item(s)</td>
                                        </tr>
                                        <tr>
                                            <td class="headTB">Quantity:</td>
                                            <td class="tailTB lastTB">
                                                <input id="quantity" class="quantity_control" value="1" type="number" min="1" max="<%=rs.getInt("product_remaining_amount")%>" name="quantity">

                                                <h4>item(s)</h4>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="addToCart_area">
                                        <div class="addToCart">
                                            <%--<button type="submit">Add to Cart</button>--%>
                                                <button id="" type="submit"><img src="../images/cart-link.gif">&nbsp;&nbsp;Add to Cart</button>
                                        </div>
                                    </div>

                                </form>
                        </div>
                    </div>

                    <div class="cleaner h10"></div>
                    <div id="product_detail_wrapper">
                        <div id="product_detail">
                            <h2>Product Description</h2>
                            <p><%=rs.getString("product_description")%></p>
                        </div>
                    </div>
                </div>
                <div class="cleaner h10"></div>

            </div>
            <%--/******************************************************************************--%>
            <div class="cleaner h10"></div>
                    <%}%>
        </div>
        <%--/******************* End of main_body_wrapper *****************--%>

    </div>
    <%--/******************* End of main_wrapper *****************--%>
    <div id="bottom_wrapper">
        <div class="row1">
            <p><a href="index.jsp">Home</a> |  <a href="aboutUs.jsp">About</a> |  <a href="checkout.jsp">Checkout</a> | <a href="contact.jsp">Contact Us</a>
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
            <h4>Copy right@2016 WHU ISS</h4>
        </div>
    </div>
    </div>

</div>
</body>
</html>



