<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Order</title>
</head>
<body>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ibm", "root", "root");

    // Call the stored procedure
    String callProc = "{ CALL orderpage(?, ?, ?, ?, ?) }";
    CallableStatement callableStatement = con.prepareCall(callProc);
    callableStatement.setString(1, request.getParameter("userid"));
    callableStatement.setString(2, request.getParameter("address"));
    callableStatement.setString(3, request.getParameter("phone"));
    callableStatement.setString(4, request.getParameter("productId"));
    callableStatement.registerOutParameter(5, Types.VARCHAR);

    callableStatement.execute();

    String result = callableStatement.getString(5);

    out.println("<h1>" + result + "</h1>");

    callableStatement.close();
    con.close();
} catch (Exception e) {
    out.println("<h1>Exception: " + e.getMessage() + "</h1>");
}
%>
</body>
</html>
