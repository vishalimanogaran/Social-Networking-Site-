<%-- 
    Document   : getMessage
    Created on : 14-Jan-2025, 5:14:00 pm
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String query = "SELECT sender, message, timestamp FROM messages WHERE receiver = ? ORDER BY timestamp ASC";
    
    try {
        // Database connection (modify with your credentials)
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");
        stmt = con.prepareStatement(query);
        stmt.setString(1, username); // receiver
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            String sender = rs.getString("sender");
            String message = rs.getString("message");
            String timestamp = rs.getString("timestamp");
%>
            <div class="chat-message">
                <strong><%= sender %></strong>: <%= message %> <br><small><%= timestamp %></small>
            </div>
<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

