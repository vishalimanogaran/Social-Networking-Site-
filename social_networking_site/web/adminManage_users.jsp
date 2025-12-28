<%-- 
    Document   : adminManage_users
    Created on : 16-Jan-2025, 10:39:12 am
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }
        h2, h3 {
            color: #800080; /* Purple */
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
        }
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            border-radius: 10px;
            transition: transform 0.3s ease;
        }
        table:hover {
            transform: scale(1.02);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f0e6f7; /* Light Pink */
            transform: translateX(5px);
            transition: background-color 0.3s, transform 0.3s;
        }
        td {
            color: #555;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #ff69b4; /* Pink */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s, transform 0.2s;
        }
        input[type="submit"]:hover {
            background-color: #ba55d3; /* Purple */
            transform: scale(1.05);
        }
        form {
            margin: 0;
        }
        label {
            font-size: 18px;
            color: #800080; /* Purple */
        }
        input[type="text"], input[type="email"], input[type="password"] {
            padding: 10px;
            width: 100%;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus {
            border-color: #800080; /* Purple */
        }
        hr {
            margin-top: 40px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .actions form {
            display: inline-block;
        }
        .actions input {
            background-color: #ba55d3; /* Purple */
            transition: background-color 0.3s;
        }
        .actions input:hover {
            background-color: #ff69b4; /* Pink */
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            font-size: 18px;
            color: #800080; /* Purple */
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Admin - Manage Users</h2>

    <!-- Add New User Form -->
    <h3>Add New User</h3>
    <form action="add_user.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        <br><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br><br>
        <input type="submit" value="Add User">
    </form>

    <hr>

    <!-- Display User Table -->
    <h3>Existing Users</h3>
    <table>
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                // Updated MySQL JDBC driver
                Class.forName("com.mysql.jdbc.Driver"); 
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");
                
                String query = "SELECT * FROM users";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("email") %></td>
            <td class="actions">
                
                <!-- Edit User Form -->
                <form action="adminEdit_user.jsp" method="get">
                    <input type="hidden" name="user_id" value="<%= rs.getInt("user_id") %>">
                    <input type="submit" value="Edit">
                </form>
                
                <!-- Delete User Form -->
                <form action="adminDelete_user.jsp" method="post">
                    <input type="hidden" name="user_id" value="<%= rs.getInt("user_id") %>">
                    <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this user?');">
                </form>
            </td>
        </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='4' style='color: red;'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>

    <br>
    <a href="dashboard.jsp" class="back-link">Back to Dashboard</a>
</body>
</html>


