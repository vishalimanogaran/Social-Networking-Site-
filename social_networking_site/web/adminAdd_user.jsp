<%-- 
    Document   : adminAdd_user.jsp
    Created on : 16-Jan-2025, 11:00:15 am
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String email = request.getParameter("email");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

        String query = "INSERT INTO users (username, email) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        pstmt.setString(2, email);

        int rowsAffected = pstmt.executeUpdate();
        conn.close();

        if (rowsAffected > 0) {
            out.println("<h3>User added successfully!</h3>");
        } else {
            out.println("<h3>Failed to add user.</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<a href="adminManage_users.jsp">Back to Manage Users</a>

