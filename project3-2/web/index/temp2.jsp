<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/28/2016
  Time: 10:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style type="text/css">
    @import "../css/temp.css";
    @import "../css/main_style.css";
</style>
<body>
<div id="wrapper">
    <div class="global-3">

        <div class="tosa-2">
            <div class="top">
                <div class="log"><a href="login.html">Login</a></div>
            </div>
            <%----%>
            <div class="bck"></div>
            <%----%>
            <div class="ok">
                <nav>
                    <ul>
                        <li class="rien">  Menu  </li><!--
		            --><li><a href="fhjhfjd.fd">Home</a></li><!--
					--><li><a href="fhjhfjd.fdf">shop store</a></li><!--
			        --><li><a href="fhjhfjd.fdf">Contact us</a></li><!--
			       --><li><a href="fhjhfjd.fd"> About us</a></li>
                        <li class="miss"><a href="fhjhfjd.fd"> swith us pay</a></li>
                    </ul>
                </nav>
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
                                <a id="myHeader1" href="product.jsp?cid=1&cate=category">Category1</a>
                            </li>
                            <li>
                                <%--href="javascript:toggle2('myContents','myHeaders');"--%>
                                <a id="myHeaders2" href="product.jsp?cid=2&cate=category">Category2</a>
                            </li>
                            <li>
                                <a id="myHeaders3" href="product.jsp?cid=3&cate=category">Category3</a>
                            </li>
                            <li>
                                <a id="myHeaders4" href="product.jsp?cid=4&cate=category">Category4</a>
                            </li>
                            <li class="last">
                                <a id="myHeaders5" href="product.jsp?cid=5&cate=category">Category5</a>
                            </li>
                        </ul>
                    </div>
                    <div class="box-content" style="float: left">

                    </div>

                </div>
            </div>


            <div id="main" class="float_r">
                <%--<div class="content">--%>
                <div id="slider" class="box">
                    <div id="slider-holder">
                        <ul>
                            <li><a href="#"><img style="width: 100%; height: 100%;" src="../images/slide1.jpg" alt="" /></a></li>
                            <li><a href="#"><img style=" width: 100%; height: 100%;" src="../images/city_scape5b.jpg" alt="" /></a></li>
                            <li><a href="#"><img style=" width: 100%; height: 100%; " src="../images/banner.jpg" alt="" /></a></li>
                            <li><a href="#"><img style=" width: 100%; height: 100%;" src="../images/promotion1.jpg" alt="" /></a></li>
                        </ul>
                    </div>
                    <div id="slider-nav">
                        <a href="#" class="active">1</a>
                        <a href="#">2</a>
                        <a href="#">3</a>
                        <a href="#">4</a>
                    </div>
                    <%--</div>--%>
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
