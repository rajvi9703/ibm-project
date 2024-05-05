<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Product</title>
</head>
<body>
    <% 
        // Retrieve the product ID and user ID from the request parameters
        String productId = request.getParameter("productid");
        String userId = request.getParameter("userid");

        // Check if both product ID and user ID are provided
        if (productId != null && !productId.isEmpty() && userId != null && !userId.isEmpty()) {
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Establish a database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                String jdbcURL = "jdbc:mysql://localhost:3307/ibm";
                String dbUser = "root";
                String dbPassword = "root";

                con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Check if the user ID and product ID exist in the orders table
                String checkQuery = "SELECT * FROM orders WHERE productId = ? AND userid = ?";
                pstmt = con.prepareStatement(checkQuery);
                pstmt.setString(1, productId);
                pstmt.setString(2, userId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // User ID and product ID exist, proceed with deletion
                    String deleteQuery = "DELETE FROM orders WHERE productId = ? AND userid = ?";
                    pstmt = con.prepareStatement(deleteQuery);
                    pstmt.setString(1, productId);
                    pstmt.setString(2, userId);

                    // Execute the delete operation
                    int rowsAffected = pstmt.executeUpdate();
                    response.sendRedirect("returnstatus.jsp");

                    // Display a success message if records are deleted successfully
                    // out.println("<h1>Records deleted successfully for Product ID: " + productId + " and User ID: " + userId + "</h1>");
                    // out.println("<h2>Number of rows affected: " + rowsAffected + "</h2>");
                } else {
                    // User ID or product ID does not exist in the orders table, display popup message
    %>
                    <script type="text/javascript">
                        alert("Error: Product ID or User ID does not exist in orders table");
                        window.history.back(); // Go back to the previous page
                    </script>
    <% 
                }
            } catch (Exception e) {
                // Display an error message if an exception occurs
                // out.println("<h1>Error deleting records: " + e.getMessage() + "</h1>");
                // e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // Display an error message if product ID or user ID is not provided
            out.println("<h1>Error: Product ID or User ID not provided</h1>");
        }
    %>
</body>
</html>
