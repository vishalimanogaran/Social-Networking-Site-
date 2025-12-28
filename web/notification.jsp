<%-- 
    Document   : notification
    Created on : 15-Jan-2025, 10:49:45 am
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/mydatabase";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>



<%
    int userId = 1; // Assume logged-in user ID is 1
    String query = "SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC";

    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();
%>
<html>
<head>
    <title>Notifications</title>
</head>
<body>
    <h1>Your Notifications</h1>
    <ul>
        <% while (rs.next()) { %>
            <li>
                <%= rs.getString("message") %> 
                (<%= rs.getBoolean("is_read") ? "Read" : "Unread" %>)
            </li>
        <% } %>
    </ul>
</body>
</html>
<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
