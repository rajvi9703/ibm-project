
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Registration</title>
</head>
<body>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ibm", "root", "root");

    // Call the stored procedure
    String callProc = "{ CALL register1(?, ?, ?, ?, ?) }"; // change the stored procedure name
    CallableStatement callableStatement = con.prepareCall(callProc);

    String userid = request.getParameter("userid");
    String firstname = request.getParameter("firstname");
    String lastname = request.getParameter("lastname");
    String username = request.getParameter("username");
    String pass = request.getParameter("pass");

    callableStatement.setInt(1, Integer.parseInt(userid));
    callableStatement.setString(2, firstname);
    callableStatement.setString(3, lastname);
    callableStatement.setString(4, username);
    callableStatement.setString(5, pass);

    callableStatement.execute();

    out.println("<h1>Values Added successfully!!</h1>");

    callableStatement.close();
    con.close();

    // Redirect to the login page after successful registration
    response.sendRedirect("chatbotlogin.html");
} catch (Exception e) {
    out.println("<h1>Exception: " + e.getMessage() + "</h1>");
}
%>
</body>
</html>
