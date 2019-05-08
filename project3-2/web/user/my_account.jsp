<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/19/2016
  Time: 3:11 PM
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
    @import "../css/my_account.css";

    /**************************************************************/
</style>

<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/easy-editable-text.js"></script>
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

    function editInfo(form){
        form.lastName.contenteditable;
        form.lastName.value = "Hello word";
    }
</script>
<%
    try{
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
        String sql = "SELECT * FROM online_shopping.table_user_account WHERE user_id = " + userID;
        rs = stmt.executeQuery(sql);
        String msg = "";
        String signal = request.getParameter("msg");
        if (signal != null) {
            msg = signal.toString();
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
                            <li><a href="my_account.jsp"  class="active">Personal Info</a></li>
                            <li><a href="history_order.jsp" >History orders</a></li>
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
        <%if(msg.equals("1"))
            out.print("<h1>Update information successfully !!</h1>");
        else if(msg.equals("0"))
            out.print("<h1>Update failed!!</h1>");
        else
            out.print("<h1></h1>");
        %>
        <div id="main_body">

            <%
                out.print("<form method='post' action='updateInfo.jsp?uid='"+userID+">");
                while (rs!=null && rs.next()){
            %>
                <table >
                    <tr>
                        <td class="firstCol">Email:</td>
                        <td class="secondCol">
                            <label class="text_label" for="newEmail"><%=rs.getString("user_email")%></label>
                            <div class="edit"></div>
                            <input type="text" value="<%=rs.getString("user_email")%>" name="newEmail" id="newEmail"/>

                        </td>
                    </tr>
                    <tr>
                        <td class="firstCol">First name</td>
                        <td class="secondCol">
                            <label class="text_label" for="newFirstName"><%=rs.getString("user_firstname")%></label>
                            <div class="edit"></div>
                            <input type="text" value="<%=rs.getString("user_firstname")%>" name="newFirstName" id="newFirstName"  />
                        </td>

                    </tr>
                    <tr>
                        <td class="firstCol">Last name</td>
                        <td class="secondCol">
                            <label class="text_label" for="newLastName"><%=rs.getString("user_lastname")%></label>
                            <div class="edit"></div>
                            <input type="text" value="<%=rs.getString("user_lastname")%>" name="newLastName" id="newLastName"/>
                        </td>

                    </tr>
                    <tr>
                        <td class="firstCol">Phone number</td>
                        <td class="secondCol">
                            <label class="text_label" for="newPhoneNo" ><%=rs.getString("user_phoneNo")%></label>
                            <div class="edit"></div>
                            <input type="text" value="<%=rs.getString("user_firstname")%>" name="newPhoneNo" id="newPhoneNo"  />
                        </td>
                    </tr>

                </table>
            <%
                }
            %>
            <div class="float_r">
                <button id="saveButton" type="submit">Update Info</button>
            </div>
            </form>
        </div>



        <div class="cleaner h30"></div>

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
<%
        rs.close();
        conn.close();
        stmt.close();
    }catch (ClassNotFoundException cnfe) {
        out.print("Hello ClassNotFound");
        out.print(cnfe);
    } catch (SQLException sqle) {
        out.print("Hello SQLException");
        out.print(sqle);
    } catch (Exception e) {
        out.print("Hello Exception");
        out.print(e);
    }
%>
</html>

