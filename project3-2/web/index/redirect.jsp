<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/19/2016
  Time: 3:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    try {
        Class.forName("org.gjt.mm.mysql.Driver").newInstance();
        String url = "jdbc:mysql://localhost/online_shopping";
        Connection conn = DriverManager.getConnection(url, "root", "123456789");

        Statement stmt = conn.createStatement();
        ResultSet rs = null;

        String parent = request.getParameter("parent");
        String etc = request.getParameter("etc");
        String action = request.getParameter("action");

        if(action.equals("Login")){

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            PreparedStatement theStatement = null;
            theStatement = conn.prepareStatement("SELECT * FROM online_shopping.table_user_account WHERE user_email=? AND user_password=?");
            theStatement.setString(1,username);
            theStatement.setString(2,password);
            ResultSet theResult = theStatement.executeQuery();
            if(!theResult.next() || username.isEmpty() || password.isEmpty()) {
                response.sendRedirect("login.jsp?parent="+parent+"&etc="+etc+"");
            }else{
                Statement stmt3 = conn.createStatement();
                ResultSet rss2 = stmt3.executeQuery("SELECT user_id, user_firstname FROM online_shopping.table_user_account\n" +
                        " WHERE user_email='"+username+"' and user_password = '"+password+"'");
                if (rss2.next()) {
                    session.setAttribute("USER_ID", Integer.toString(rss2.getInt("user_id")));
                    session.setAttribute("STATUS", "online");
                    session.setAttribute("USER_NAME", rss2.getString("user_firstname"));
                }
                String userID=  session.getAttribute("USER_ID").toString();
                ResultSet rss;
                Statement stmt2 = conn.createStatement();
                String queryItemNo = "select count(*) as number_product from online_shopping.table_order_details\n" +
                        " where order_id =(select order_id from online_shopping.table_orders where (user_id = "+userID+" and order_status = 'buying'))";
                rss = stmt2.executeQuery(queryItemNo);
                if (rss.next()) {
                    session.setAttribute("NUMBER_OF_CART_ITEMS", Integer.toString(rss.getInt("number_product")));
                }
                if (parent.equals("homepage")) {
                    response.sendRedirect("index.jsp");
                } else if (parent.equals("products.jsp")) {
                    response.sendRedirect("product.jsp?action=" + etc);
                } else if (parent.equals("productDetail")) {
                    response.sendRedirect("productDetail.jsp?action=detail&pid=" + etc + "");
                }else{
                    response.sendRedirect("index.jsp");
                }

                stmt2.close();
                stmt3.close();
                rss2.close();
            }

        } else if (action.equals("signout")) {
            session.setAttribute("STATUS", "offline");
            session.setAttribute("ORDER_STATE", "notCreated");
            session.setAttribute("USER_ID", "0000000");
            session.invalidate();
            response.sendRedirect("index.jsp");
        }

        else if (action.equals("register")){
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String gender = request.getParameter("gender");
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String phoneNo = request.getParameter("phoneNo");

            stmt.execute("INSERT INTO table_user_account (user_email, user_password, user_firstname, user_lastname, user_sex, user_status, user_current_order_id,user_phoneNo, user_address) " +
                    "VALUES ('" + email + "','" + password + "', '" + firstname + "','" + lastname + "', '" + gender + "',1, " +
                    "  0,'"+phoneNo+"', '"+"address"+"')");

            Statement stmt3 = conn.createStatement();
            ResultSet rss2 = stmt3.executeQuery("SELECT user_id, user_firstname from online_shopping.table_user_account " +
                    "WHERE user_id =(SELECT MAX(user_id) as Last FROM online_shopping.table_user_account)");
            if (rss2.next()) {
                session.setAttribute("USER_ID", Integer.toString(rss2.getInt("user_id")));
                session.setAttribute("USER_NAME", rss2.getString("user_firstname"));
                session.setAttribute("STATUS", "online");
            }
            String userID = session.getAttribute("USER_ID").toString();
            ResultSet rss;
            Statement stmt2 = conn.createStatement();
            String queryItemNo = "select count(distinct(product_id)) as number_product from online_shopping.table_order_details\n" +
                    " where order_id =(select order_id from online_shopping.table_orders where (user_id = " + userID + " and order_status = 'buying'))";
            rss = stmt2.executeQuery(queryItemNo);
            if (rss.next()) {
                session.setAttribute("NUMBER_OF_CART_ITEMS", Integer.toString(rss.getInt("number_product")));
            }
            response.sendRedirect("index.jsp");

            stmt3.close();

        }
        else if (action.equals("confirmOrder")){
            String order_id = request.getParameter("oid");
            out.print(order_id);

            String updateDB = "UPDATE online_shopping.table_orders SET order_status = 'paying'  WHERE order_id = "+order_id;
            int rs3 = stmt.executeUpdate(updateDB);
            response.sendRedirect("index.jsp");
        }




//        ---------------------------
        rs.close();
        stmt.close();
        conn.close();

    }
//    ****************************************************************
    catch (ClassNotFoundException cnfe) {
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
</body>
</html>
