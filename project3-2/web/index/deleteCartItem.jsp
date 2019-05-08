<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/26/2016
  Time: 7:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"%>
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

        Class.forName("org.gjt.mm.mysql.Driver").newInstance();
        String url = "jdbc:mysql://localhost/online_shopping";
        Connection conn = DriverManager.getConnection(url, "root", "123456789");
        Statement stmt = conn.createStatement();
        ResultSet rs,rss;
        String query;
        int userID = Integer.parseInt(session.getAttribute("USER_ID").toString());
        String pid = request.getParameter("id");

        query = "DELETE FROM table_order_details WHERE product_id =" + pid;
        int result = stmt.executeUpdate(query);

        Statement stmt2 = conn.createStatement();
        String queryItemNo = "select count(distinct(product_id)) as number_product from online_shopping.table_order_details\n" +
                " where order_id =(select order_id from online_shopping.table_orders where (user_id = "+userID+" and order_status = 'buying'))";
        rss = stmt2.executeQuery(queryItemNo);
        if (rss.next()) {
            session.setAttribute("NUMBER_OF_CART_ITEMS", rss.getInt("number_product"));
        }


//        Statement stmt3 = conn.createStatement();
//        String updateDB = "UPDATE online_shopping.table_products SET product_remaining_amount = product_remaining_amount + " + Integer.parseInt(qnty) ;
//        int temp = stmt3.executeUpdate(updateDB);

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
