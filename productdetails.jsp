<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DataTables Example</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#example').DataTable();
        });
    </script>
</head>
<body>

<table id="example" class="display" style="width:100%">
    <thead>
        <tr>
            <th>Product ID</th>
            <th>Category</th>
            <th>Product Name</th>
            <th>Description</th>
            <th>Price</th>
        </tr>
    </thead>
    <tbody>
        <% 
            Connection conn = null;
            Statement statement = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String jdbcURL = "jdbc:mysql://localhost:3307/ibm";
                String dbUser = "root";
                String dbPassword = "root";

                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                statement = conn.createStatement();

                String sql = "SELECT * FROM products";
                rs = statement.executeQuery(sql);

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getInt("product_id") %></td>
                        <td><%= rs.getString("category") %></td>
                        <td><%= rs.getString("product_name") %></td>
                        <td><%= rs.getString("description") %></td>
                        <td><%= rs.getDouble("price") %></td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("An error occurred: " + e.getMessage());
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (statement != null) statement.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </tbody>
</table>
<div style="text-align: center; margin-top: 20px;">
    <button onclick="location.href='orderpage.html'" class="btn btn-primary">Place Order</button>
</div>
</body>
</html>
