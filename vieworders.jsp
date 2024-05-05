<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View Orders</title>
    <!-- Include DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">

    <!-- Include jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Include DataTables JavaScript -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>

    <!-- DataTables initialization script -->
    <script>
        $(document).ready(function () {
            $('#orderTable').DataTable();
        });
    </script>
</head>
<body>
<%
// Check if userid parameter is present
String userId = request.getParameter("userid");
if (userId == null || userId.isEmpty()) {
    // Display popup message and go back
%>
    <script type="text/javascript">
        alert("Error: User ID not provided");
        window.history.back(); // Go back to the previous page
    </script>
<%
} else {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/ibm", "root", "root");

        // Call the stored procedure
        String callProc = "{ CALL vieworders(?) }";
        CallableStatement callableStatement = con.prepareCall(callProc);
        callableStatement.setString(1, userId);
        ResultSet resultSet = callableStatement.executeQuery();

        out.println("<h1>Orders for User: " + userId + "</h1>");
        out.println("<table id='orderTable' border='1'>"); // Add an ID to the table for DataTables
        out.println("<thead>");
        out.println("<tr><th>Firstname</th><th>Lastname</th><th>User ID</th><th>Product ID</th><th>Phone</th><th>Timestamp</th></tr>");
        out.println("</thead>");
        out.println("<tbody>");

        while (resultSet.next()) {
            String firstname = resultSet.getString("firstname");
            String lastname = resultSet.getString("lastname");
            String orderUserId = resultSet.getString("userid");
            String productId = resultSet.getString("productId");
            String phone = resultSet.getString("phone");
            Timestamp timestamp = resultSet.getTimestamp("timestamp");

            // Display firstname and lastname as separate columns
            out.println("<tr><td>" + firstname + "</td><td>" + lastname + "</td><td>" + orderUserId + "</td><td>" + productId + "</td><td>" + phone + "</td><td>" + timestamp + "</td></tr>");
        }

        out.println("</tbody>");
        out.println("</table>");

        resultSet.close();
        callableStatement.close();
        con.close();
    } catch (Exception e) {
        out.println("<h1>Exception: " + e.getMessage() + "</h1>");
    }
}
%>
</body>
</html>
