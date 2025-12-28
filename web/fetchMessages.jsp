<%-- 
    Document   : fetchMessages
    Created on : 14-Jan-2025, 7:39:22 pm
    Author     : sarav
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.dbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

        String sql = "SELECT * FROM messages WHERE sender = ? OR receiver = ? ORDER BY timestamp ASC";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "User");
        pstmt.setString(2, "Friend");
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String sender = rs.getString("sender");
            String message = rs.getString("message");
            String cssClass = sender.equals("User") ? "chat-message user" : "chat-message friend";
%>
            <div class="<%= cssClass %>">
                <strong><%= sender %>:</strong> <%= message %>
            </div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

