<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<%
    String username = request.getParameter("username");
    String userid = request.getParameter("userid");
    String newPassword = request.getParameter("newPassword");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ibm", "root", "root");

        // Call the stored procedure
        String callProc = "{ CALL forgotpassword(?, ?, ?) }";
        CallableStatement callableStatement = con.prepareCall(callProc);
        callableStatement.setString(1, username);
        callableStatement.setInt(2, Integer.parseInt(userid));
        callableStatement.setString(3, newPassword);

        try {
            // Try executing the stored procedure
            callableStatement.execute();

            // Redirect to a new page with a success message and login button
            response.sendRedirect("passwordupdated.jsp");
        } catch (SQLException e) {
            // Handle the exception - user does not exist
            out.println("<h1>User does not exist.</h1>");
        }

        callableStatement.close();
        con.close();
    } catch (Exception e) {
        out.println("Exception: " + e.getMessage());
    }
%>

</body>
</html>
