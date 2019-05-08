<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/25/2016
  Time: 1:30 PM
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
    @import "../css/advanced_search_style.css";
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
        String statusPage = "offline";
        Object statusSite = session.getAttribute("STATUS");
        if (statusSite != null) {
            statusPage = statusSite.toString();
        }

%>
<body>
<div id="wrapper">
    <div id="header_wrapper">
        <div id="loginBar">
            <%
                if (statusPage.equals("offline")) {
                    out.print("<a href='login.jsp?parent=homepage&etc=?' class='loginBar'>Sign in</a>");
                } else {

                    out.print("<a href='redirect.jsp?action=signout'>Sign out</a>");
                }
                out.print("&nbsp" + statusPage);
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
                            <li><a href="index.jsp">Home</a></li>
                            <li><a href="storeFront.jsp">The Store</a></li>
                            <li><a href="contact.jsp">Contact</a></li>
                            <li><a href="aboutUs.jsp">About Us</a></li>
                        </ul>
                    </div>
                </div>
                <div class="float_r">
                    <%if (statusPage.equals("online")) {%>
                    <div class="float_l">
                        <div id="my_acc">
                            <ul>
                                <li><a href="../user/my_account.jsp">My Account</a></li>
                            </ul>
                        </div>
                    </div>
                    <%}%>
                    <div class="float_r">
                        <div id="cart">
                            <a href="shoppingCart.jsp" class="cart-link">Your Shopping Cart</a>
                            <div class="cl">&nbsp;</div>
                            <div style="text-align: center; font-size: 25px">
                                <%
                                    out.print("<span >Articles: <strong>" + session.getAttribute("NUMBER_OF_CART_ITEMS") + "</strong></span>");%>

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
                <div class="advSearch">
                    <div class="searchWord "><h3>Search:</h3></div>
                    <div class="searchBox">
                        <form action="searchResult.jsp?type=adv" method="post">
                            <div class="searchRow1">
                                <span>
                                    <label class="head">Search</label>
                                    <input type="text" name="keyword"/>
                                </span>
                                <span>
                                    <label class="head">Category</label>
                                    <select name="categories" class="category">
                                        <option name="cate0" value="between 6 and 8" selected="selected">All</option>
                                        <option name="cate6" value="=6">Clothing</option>
                                        <option name="cate7" value="=7">Souvenirs</option>
                                        <option name="cate8" value="=8">Stationary</option>
                                    </select>
                                </span>
                            </div>
                            <div class="searchRow2">
                                <div class="layoutLeft">
                                    <span class="head">Search by</span>
                                    <input name="sas[0]" value="name" checked="checked" type="checkbox"/>
                                    Name
                                    <input name="sas[1]" value="description" checked="checked" type="checkbox"/>
                                    Description
                                    <input name="sas[2]" value="code" checked="checked" type="checkbox"/>
                                    Product Code
                                    </br>
                                    <span class="head">From</span>
                                    <input name="min_price"  style="width: 60px" type="number"/>
                                    To
                                    <input name="max_price"  style="width: 60px" type="number"/>
                                    RMB
                                </div>
                                <div class="layoutRight">
                                    <span class="head">Sort by</span>
                                    <select class="sortby" name="sortby">
                                        <option value="product_title" selected="selected">Name</option>
                                        <option value="product_price" >Price</option>
                                        <option value="product_last_update" >Last update</option>
                                    </select>
                                </div>
                            </div>
                            <div class="searchLayout">
                                <button type="submit" value="submit" class="searchBtt sButton">Search</button>
                            </div>
                        </form>
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
            <p><a href="index.jsp">Home</a> | <a href="aboutUs.jsp">About</a> | <a href="checkout.jsp">Checkout</a> | <a
                    href="contact.jsp">Contact Us</a>
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
                    I have to contact.<br/>
                    I have to contact.<br/>
                    I have to contact.<br/>
                    I have to contact.<br/>
                    I have to contact.<br/>
                </p>
            </div>
        </div>

        <div class="row3">
            <h4>Copy right@2016 WHU ISS</h4>
        </div>
    </div>

</div>
</body>
<%
    } catch (Exception e) {

    }
%>
</html>


