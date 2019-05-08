<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/26/2016
  Time: 1:45 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html; charset=gb2312" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>response redirect</title>
</head>

<body>
<%
    try {
        String statusPage = "offline";
        Object statusSite = session.getAttribute("STATUS");
        if(statusSite != null){
            statusPage = statusSite.toString();
        }
        String pid = request.getParameter("pid");
        if (statusPage.equals("offline")) {
            response.sendRedirect("login.jsp?parent=productDetail&etc="+pid+"");
        }
        Class.forName("org.gjt.mm.mysql.Driver").newInstance();
        String url = "jdbc:mysql://localhost/online_shopping";
        Connection conn = DriverManager.getConnection(url, "root", "123456789");
        Statement stmt = conn.createStatement();
        ResultSet rs,rss,rs3;
        String query;

        String action = request.getParameter("action");

        String qnty = request.getParameter("quantity");
        String price = request.getParameter("prices");
        out.print("<h1>"+qnty+"</h1>");
        int tmpQnty = Integer.parseInt(qnty);
        float tmpPrice = Float.parseFloat(price);
                out.print(tmpPrice+"---");

        float totalPrice = tmpPrice*tmpQnty;
//
//        out.print(totalPrice+"---");

        if (statusPage.equals("offline")) {
            response.sendRedirect("login.jsp?parent=productDetail&etc="+pid+"");
        }
//        String orderStatus = (String)session.getAttribute("ORDER_STATUS");
        int userID = Integer.parseInt(session.getAttribute("USER_ID").toString());
        int orderID = 0;
        int noOfbuyingOrder = 0;

        query =  "SELECT COUNT(*) FROM online_shopping.table_orders WHERE (user_id ="+userID+" and order_status='buying')";
        rs = stmt.executeQuery(query);
        if (rs.next()) {
            noOfbuyingOrder = rs.getInt("count(*)");

        }

        /* ---------   Check if there is an order of current user   ----------- */

        /* no order of current user*/
        if (noOfbuyingOrder == 0) {
            String dateOrder = new SimpleDateFormat("yyyy/MM/dd").format(Calendar.getInstance().getTime());
            String timeOrder = new SimpleDateFormat("HH:mm:ss").format(Calendar.getInstance().getTime());
            int i = stmt.executeUpdate("INSERT INTO table_orders ( user_id, order_date, order_time,order_status) " +
                    "VALUES('"+userID+"','"+dateOrder+"','"+timeOrder+"', 'buying') ");
            if (i > 0) {
                session.setAttribute("ORDER_STATE", "created");
                session.setAttribute("ORDER_STATUS", "buying");
            }
        }
        /*There is an order*/

        query =  "SELECT order_id FROM online_shopping.table_orders WHERE (user_id ="+userID+" and order_status='buying')";
        rs = stmt.executeQuery(query);
        if(rs.next()){ orderID = rs.getInt("order_id");}

        stmt.execute("INSERT INTO table_order_details (product_id,order_id, quantity, price, total) " +
                "VALUES ("+pid+","+orderID+","+ qnty+","+ price+","+ totalPrice+")");

        Statement stmt2 = conn.createStatement();
        String queryItemNo = "select count(distinct(product_id)) as number_product from online_shopping.table_order_details\n" +
                " where order_id =(select order_id from online_shopping.table_orders where (user_id = "+userID+" and order_status = 'buying'))";
        rss = stmt2.executeQuery(queryItemNo);
        if (rss.next()) {
            session.setAttribute("NUMBER_OF_CART_ITEMS", rss.getInt("number_product"));
        }

        Statement stmt3 = conn.createStatement();
        String updateDB = "UPDATE online_shopping.table_products SET product_remaining_amount = product_remaining_amount - " + Integer.parseInt(qnty) + " WHERE product_id = "+pid ;
        int result = stmt3.executeUpdate(updateDB);

        response.sendRedirect("shoppingCart.jsp");




        stmt.close();
        conn.close();


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
