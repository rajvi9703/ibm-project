<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Order Details</title>
    <style>
        /* your existing styles here */
    </style>
</head>
<body>

<%
    Connection conn = null;
    CallableStatement stmtOrderDetails = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost:3307/ibm";
        String dbUser = "root";
        String dbPassword = "root";

        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        int orderId = Integer.parseInt(request.getParameter("id"));

        // Call the stored procedure
        String callProc = "{ CALL orderdetails(?) }";
        stmtOrderDetails = conn.prepareCall(callProc);
        stmtOrderDetails.setInt(1, orderId);
        rs = stmtOrderDetails.executeQuery();

%>

<div class="order-details-container">
    <div class="order-details-header">Order Details</div>

    <%
        if (rs.next()) {
    %>
        <table>
            <!-- your table structure here -->
        </table>
    <%
        } else {
    %>
        <p>No order found with ID <%= orderId %>.</p>
    <%
        }
    %>

    <div>
        <a href="cancelorder.jsp?id=<%= orderId %>">Cancel Order</a>
    </div>

</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmtOrderDetails != null) stmtOrderDetails.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
