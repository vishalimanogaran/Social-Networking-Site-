<%-- 
    Document   : adminView_report
    Created on : 16-Jan-2025, 11:57:58 am
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - View Reports</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            color: #333;
        }
        h2 {
            text-align: center;
            color: #800080; /* Purple */
        }
        h3 {
            color: #800080; /* Purple */
        }
        .report-section {
            width: 60%;
            margin: 30px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .report-section:hover {
            transform: scale(1.05); /* 3D Hover Effect */
        }
        .report-item {
            margin: 15px 0;
            font-size: 18px;
        }
        .error-message {
            color: #ff0000; /* Red */
            font-size: 18px;
            text-align: center;
            padding: 10px;
            background-color: #ffe6e6; /* Light Red */
            border: 1px solid #f44336;
            border-radius: 5px;
            margin-bottom: 20px;
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

    <h2>Admin - View Reports</h2>

    <div class="report-section">
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rsUser = null;
            ResultSet rsPost = null;
            ResultSet rsComment = null;

            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.jdbc.Driver");

                // Establish connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

                // Query to get total users count
                String userQuery = "SELECT COUNT(*) AS total_users FROM users";
                stmt = conn.createStatement();
                rsUser = stmt.executeQuery(userQuery);

                if (rsUser.next()) {
                    int totalUsers = rsUser.getInt("total_users");
        %>
        <div class="report-item">
            <h3>Total Users</h3>
            <p>Total number of users: <%= totalUsers %></p>
        </div>
        <%
                }

                // Query to get total posts count
                String postQuery = "SELECT COUNT(*) AS total_posts FROM posts";
                rsPost = stmt.executeQuery(postQuery);

                if (rsPost.next()) {
                    int totalPosts = rsPost.getInt("total_posts");
        %>
        <div class="report-item">
            <h3>Total Posts</h3>
            <p>Total number of posts: <%= totalPosts %></p>
        </div>
        <%
                }

                // Query to get total comments count
                String commentQuery = "SELECT COUNT(*) AS total_comments FROM comments";
                rsComment = stmt.executeQuery(commentQuery);

                if (rsComment.next()) {
                    int totalComments = rsComment.getInt("total_comments");
        %>
        <div class="report-item">
            <h3>Total Comments</h3>
            <p>Total number of comments: <%= totalComments %></p>
        </div>
        <%
                }

            } catch (SQLException e) {
        %>
            <div class="error-message">
                <p>Error occurred while fetching data from the database. Please try again later.</p>
            </div>
        <%
            } catch (ClassNotFoundException e) {
        %>
            <div class="error-message">
                <p>JDBC Driver not found. Please ensure it's properly configured.</p>
            </div>
        <%
            } finally {
                // Clean up resources
                try {
                    if (rsUser != null) rsUser.close();
                    if (rsPost != null) rsPost.close();
                    if (rsComment != null) rsComment.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Log the error for debugging
                }
            }
        %>
    </div>

    <a href="dashboard.jsp">Back to Dashboard</a>

</body>
</html>


