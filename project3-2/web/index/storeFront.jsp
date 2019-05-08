<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/21/2016
  Time: 11:07 AM
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

<%--*********************************************************--%>
<link rel="stylesheet" type="text/css" media="all" href="../css/jquery.dualSlider.0.2.css" />
<script src="../js/jquery-1.3.2.min.js" type="text/javascript"></script>
<script src="../js/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="../js/jquery.timers-1.2.js" type="text/javascript"></script>
<script src="../js/jquery.dualSlider.0.3.min.js" type="text/javascript"></script>
<script type="text/javascript">

    $(document).ready(function() {

        $(".carousel").dualSlider({
            auto:true,
            autoDelay: 6000,
            easingCarousel: "swing",
            easingDetails: "easeOutBack",
            durationCarousel: 1000,
            durationDetails: 600
        });

    });

</script>
<%--*********************************************************--%>

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
        int counter = 0;
        String imgPath = "";
        String product_name = "";
        int tempCid = 0;

        String sql = "SELECT * FROM online_shopping.table_products WHERE category_id BETWEEN 6 AND 8";
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
                            <li><a href="storeFront.jsp" class="active">The Store</a></li>
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
                    <div class="carousel">
                        <div class="panel">

                            <div class="details_wrapper">

                                <div class="details">

                                    <div class="detail">
                                        <h2><a href="#">Station Shop</a></h2>
                                        <p>Station Shop is free website template by templatemo for ecommerce websites or online stores. </p>
                                        <a href="#" title="Read more" class="more">Read more</a>
                                    </div><!-- /detail -->

                                    <div class="detail">
                                        <h2><a href="#">Fusce hendrerit</a></h2>
                                        <p>Duis dignissim tincidunt turpis eget pellentesque. Nulla consectetur accumsan facilisis. </p>
                                        <a href="#" title="Read more" class="more">Read more</a>
                                    </div><!-- /detail -->

                                    <div class="detail">
                                        <h2><a href="#">Aenean massa cum</a></h2>
                                        <p>Sed vel interdum sapien. Aliquam consequat, diam sit amet iaculis ultrices, diam erat faucibus dolor, </p>
                                        <a href="#" title="Read more" class="more">Read more</a>
                                    </div><!-- /detail -->

                                </div><!-- /details -->

                            </div><!-- /details_wrapper -->

                            <div class="paging">
                                <div id="numbers"></div>
                                <a href="javascript:void(0);" class="previous" title="Previous" >Previous</a>
                                <a href="javascript:void(0);" class="next" title="Next">Next</a>
                            </div><!-- /paging -->

                            <a href="javascript:void(0);" class="play" title="Turn on autoplay">Play</a>
                            <a href="javascript:void(0);" class="pause" title="Turn off autoplay">Pause</a>

                        </div><!-- /panel -->

                        <div class="backgrounds">

                            <div class="item item_1">
                                <img src="../images/slider/01.jpg" alt="Slider 01" />
                            </div><!-- /item -->

                            <div class="item item_2">
                                <img src="../images/slider/02.jpg" alt="Slider 02" />
                            </div><!-- /item -->

                            <div class="item item_3">
                                <img src="../images/slider/03.jpg" alt="Slider 03" />
                            </div><!-- /item -->

                        </div>
                    </div>
                    <%-----------------------------------------------------------------------------------------%>
                    <%-----------------------------------------------------------------------------------------%>
                    <h1>Products</h1>
                    <div class="productList">

                        <%
                            String pid;
                            while(rs!=null && rs.next()) {

                                pid = new String(rs.getString("product_id").getBytes("iso-8859-1"),"gb2312");
                                if (counter % 3 == 0 && counter != 0){
                                    out.print("<div class='cleaner h30'></div>");
                                }
                                out.print("<div class='product_box'>");
                                tempCid = rs.getInt("category_id");
                                imgPath = "../images/products/"+tempCid+"/"+pid+".jpg";
                                product_name = rs.getString("product_title");
                                if(rs.getInt("product_remaining_amount")==0) {
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
                                    out.print("<a href='productDetail.jsp?pid="+pid+"' class='detail'><button class='addtocart'></button></a>");

                                }

                                out.print("</div>");
                                counter++;
                            }
                        %>

                        <div class="cleaner h30"></div>

                    </div>
                    <div class="cleaner h10"></div>

                    <%--<div class="paging_wrapper">--%>
                        <%--<div class="pagination_wrapper">--%>

                            <%--<table class="pagination" cellpadding="0" cellspacing="0">--%>
                                <%--<tbody>--%>
                                    <%--<tr>--%>
                                        <%--<td class="prev">--%>
                                            <%--<a href="#">--%>
                                                <%--<div class="nextBox">--%>
                                                    <%--<div class="text"><< Previous</div>--%>
                                                <%--</div>--%>
                                            <%--</a>--%>
                                        <%--</td>--%>
                                        <%--<td >--%>
                                            <%--<a href="#">--%>
                                                <%--<div class="box_number">1</div>--%>
                                                <%--<div class="line_pagination"></div>--%>
                                            <%--</a>--%>
                                        <%--</td>--%>
                                        <%--<td class="now">--%>
                                            <%--<a href="#">--%>
                                                <%--<div class="box_number">2</div>--%>
                                                <%--<div class="line_pagination"></div>--%>
                                            <%--</a>--%>
                                        <%--</td>--%>
                                        <%--<td >--%>
                                            <%--<a href="#">--%>
                                                <%--<div class="box_number">3</div>--%>
                                                <%--<div class="line_pagination"></div>--%>
                                            <%--</a>--%>
                                        <%--</td>--%>
                                        <%--<td class="next">--%>
                                            <%--<a href="#">--%>
                                                <%--<div class="nextBox">--%>
                                                    <%--<div class="text">Next >></div>--%>
                                                <%--</div>--%>

                                            <%--</a>--%>
                                        <%--</td>--%>
                                    <%--</tr>--%>
                                <%--</tbody>--%>

                            <%--</table>--%>
                        <%--</div>--%>
                        <%--<div class="show_page">--%>
                            <%--<div class="first_last">--%>
                                <%--<a href="#" title="Last page">--%>
                                    <%--Go to last page >>--%>
                                <%--</a>--%>
                            <%--</div>--%>
                            <%--Show items 1-40 from 120 items--%>
                        <%--</div>--%>
                    <%--</div>--%>
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



