<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login</title>
</head>
<body>

<%
    String userid = request.getParameter("userid");
    String pass = request.getParameter("pass");
    


    // Check for admin login
    if ("admin".equals(userid) && "admin".equals(pass)) {
        // Admin login successful, redirect to the main admin page
        response.sendRedirect("admin.html");
    } else {
        // Perform regular database authentication

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ibm", "root", "root");

            // Call the stored procedure
            String callProc = "{ CALL chatbotlogin(?, ?, ?) }";
            CallableStatement callableStatement = con.prepareCall(callProc);
            callableStatement.setInt(1, Integer.parseInt(userid));
            callableStatement.setString(2, pass);
            callableStatement.registerOutParameter(3, Types.VARCHAR);

            callableStatement.execute();

            String status = callableStatement.getString(3);

            if ("authenticated".equals(status)) {
                // User is authenticated, redirect to the main page
                response.sendRedirect("chatbotmain.html");
            } else {
                // Authentication failed, you can redirect to a failure page or display an error message.
                out.println("<h1>Login failed. Invalid username or password.</h1>");
                response.sendRedirect("chatbotlogin.html");
            }

            callableStatement.close();
            con.close();
        } catch (Exception e) {
            out.println("Exception: " + e.getMessage());
        }
    }
%>

</body>
</html>