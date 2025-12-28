<%-- 
    Document   : adminUpdate_user
    Created on : 16-Jan-2025, 11:02:07 am
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int user_id = Integer.parseInt(request.getParameter("user_id"));
    String username = request.getParameter("username");
    String email = request.getParameter("email");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

        String query = "UPDATE users SET username = ?, email = ? WHERE user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        pstmt.setString(2, email);
        pstmt.setInt(3, user_id);

        int rowsAffected = pstmt.executeUpdate();
        conn.close();

        if (rowsAffected > 0) {
            request.setAttribute("message", "User updated successfully!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Failed to update user.");
            request.setAttribute("messageType", "error");
        }
    } catch (Exception e) {
        request.setAttribute("message", "Error: " + e.getMessage());
        request.setAttribute("messageType", "error");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Update</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }
        .feedback {
            max-width: 500px;
            margin: 30px auto;
            padding: 20px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .feedback:hover {
            transform: scale(1.05);
        }
        .success {
            background-color: #e6ffe6; /* Light Green */
            color: #008000; /* Green */
            border: 2px solid #4CAF50;
        }
        .error {
            background-color: #ffe6e6; /* Light Red */
            color: #ff0000; /* Red */
            border: 2px solid #f44336;
        }
        .feedback h3 {
            font-size: 20px;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.1);
        }
        a {
            display: inline-block;
            margin-top: 20px;
            color: #800080; /* Purple */
            font-size: 18px;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #ff69b4; /* Pink */
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="feedback <%= request.getAttribute("messageType") %>">
        <h3><%= request.getAttribute("message") %></h3>
        <a href="adminManage_users.jsp">Back to Manage Users</a>
    </div>
</body>
</html>


