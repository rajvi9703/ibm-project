<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String feedback = request.getParameter("feedback");
    if (feedback != null && !feedback.isEmpty()) {
        try {
            // JDBC driver name and database URL
            String JDBC_DRIVER = "com.mysql.jdbc.Driver";
            String DB_URL = "jdbc:mysql://localhost:3307/ibm";

            // Database credentials
            String USER = "root";
            String PASS = "root";

            // Register JDBC driver
            Class.forName(JDBC_DRIVER);

            // Open a connection
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // Create a CallableStatement for the stored procedure
            String storedProcedure = "{CALL InsertFeedback(?)}";
            CallableStatement cstmt = conn.prepareCall(storedProcedure);

            // Set the parameter for the stored procedure
            cstmt.setString(1, feedback);

            // Execute the stored procedure
            cstmt.execute();

            // Close resources
            cstmt.close();
            conn.close();

            // Redirect to a success page
            response.sendRedirect("chatbotmain.html");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions or redirect to an error page
            response.sendRedirect("error.jsp");
        }
    } else {
        // Handle null or empty feedback (optional)
        response.sendRedirect("invalid_feedback.jsp");
    }
%>
