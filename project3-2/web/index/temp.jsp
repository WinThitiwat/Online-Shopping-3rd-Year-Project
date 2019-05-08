<%--
  Created by IntelliJ IDEA.
  User: thitiwat
  Date: 7/28/2016
  Time: 9:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    try{
        Class.forName("org.gjt.mm.mysql.Driver").newInstance();
        String url ="jdbc:mysql://localhost/online_shopping";
        Connection conn= DriverManager.getConnection(url,"root","123456789");

        PreparedStatement pstmt = null;
        Statement stmt=conn.createStatement();
        ResultSet rs = null;
        FileInputStream fis = null;
//        String file =;
        out.print("1");

//        Part filePart = request.getPart("test");
//        String fileName = filePart.getSubmittedFileName();

        File image = new File("C:/apache-tomcat-7.0.68/webapps/project3-2/web/images/slider1.jpg");

        fis = new FileInputStream(image);

        String query2 = "UPDATE table_products SET product_image_path="+((InputStream) fis)+" WHERE product_id=201601007";
//        String query = "INSERT INTO table_products(product_image_path) VALUES(?) WHERE product_id = 201601007";
//        pstmt = conn.prepareStatement(query2);
//        pstmt.setBinaryStream(1, (InputStream) fis, (int)(image.length()));
        out.print("2");
        int count = stmt.executeUpdate(query2);
//        out.print("2");
        out.print("3");
        if (count > 0) {
            System.out.println("The image has been inserted successfully");
            out.print("The image has been inserted successfully");
        }else{
            System.out.println("The image is not inserted successfully");
            out.print("The image is not inserted successfully");
        }
%>

<%
//        rs.close();
//        stmt.close();
        try {
            if (rs != null) {
                rs.close();
                rs = null;
            }
            if (pstmt != null) {
                pstmt.close();
                pstmt = null;
            }
            if (conn != null) {
                conn.close();
                conn = null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }catch(Exception e){
        out.print(e);
    }finally {

    }
%>
</body>
</html>
