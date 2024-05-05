<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // Get the email parameter from the request
    String email = request.getParameter("email");

    // Database connection variables
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3307/ibm";
        String dbUser = "root";
        String dbPassword = "root";

        // Establish the database connection
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // SQL query to insert the email into the database
        String sql = "INSERT INTO email (email) VALUES (?)";

        // Create a prepared statement
        pstmt = conn.prepareStatement(sql);

        // Set the email parameter in the prepared statement
        pstmt.setString(1, email);

        // Execute the insert query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Close the database resources
            pstmt.close();
            conn.close();

            // Redirect to the chatbotmain.html page
            response.sendRedirect("chatbotmain.html");
        } else {
            out.println("<h1>Error storing email ID!</h1>");
        }
    } catch (Exception e) {
        out.println("<h1>Error: " + e.getMessage() + "</h1>");
    } finally {
        // Close the database resources
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException se) {
            out.println("<h1>Error closing database resources: " + se.getMessage() + "</h1>");
        }
    }
%>
