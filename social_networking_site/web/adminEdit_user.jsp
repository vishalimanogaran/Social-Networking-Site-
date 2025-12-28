<%-- 
    Document   : adminEdit_user
    Created on : 16-Jan-2025, 11:01:12 am
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int userId = Integer.parseInt(request.getParameter("user_id"));
    String username = "";
    String email = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

        String query = "SELECT * FROM users WHERE id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, userId);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            username = rs.getString("username");
            email = rs.getString("email");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }
        h3 {
            color: #800080; /* Purple */
            text-align: center;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.1);
        }
        form {
            max-width: 500px;
            margin: 30px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        form:hover {
            transform: scale(1.02);
        }
        label {
            font-size: 18px;
            color: #800080; /* Purple */
        }
        input[type="text"], input[type="email"] {
            padding: 10px;
            width: 100%;
            margin-top: 8px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 16px;
            margin-bottom: 20px;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus, input[type="email"]:focus {
            border-color: #800080; /* Purple */
        }
        input[type="submit"] {
            padding: 12px 25px;
            background-color: #ff69b4; /* Pink */
            border: none;
            color: white;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }
        input[type="submit"]:hover {
            background-color: #ba55d3; /* Purple */
            transform: scale(1.05);
        }
        a {
            display: block;
            text-align: center;
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
        .form-container {
            max-width: 600px;
            margin: auto;
            padding: 30px;
            background-color: #fff0f5; /* Light Pink */
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h3>Edit User</h3>
        <form action="adminUpdate_user.jsp" method="post">
            <input type="hidden" name="user_id" value="<%= userId %>">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="<%= username %>" required>
            <br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= email %>" required>
            <br>
            <input type="submit" value="Update User">
        </form>
        <a href="adminManage_users.jsp">Back to Manage Users</a>
    </div>
</body>
</html>


