<%-- 
    Document   : add_user
    Created on : 16-Jan-2025, 11:36:14 am
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(45deg, #8e44ad, #f78fb3);
            color: #fff;
            text-align: center;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .message {
            padding: 20px;
            margin: 20px auto;
            width: 80%;
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.3);
            background: rgba(255, 255, 255, 0.1);
        }

        .success {
            border: 2px solid #2ecc71;
            color: #2ecc71;
        }

        .error {
            border: 2px solid #e74c3c;
            color: #e74c3c;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #9b59b6;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        }

        a:hover {
            background: #f78fb3;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.4);
        }

        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
        }

    </style>
</head>
<body>
    <div>
        <h1>User Management</h1>
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

                int rows = pstmt.executeUpdate();
                conn.close();

                if (rows > 0) {
                    out.println("<div class='message success'>User added successfully!</div>");
                } else {
                    out.println("<div class='message error'>Failed to add user.</div>");
                }
            } catch (Exception e) {
                out.println("<div class='message error'>Error: " + e.getMessage() + "</div>");
            }
        %>
        <a href="adminManage_users.jsp">Back to Manage Users</a>
    </div>
</body>
</html>
