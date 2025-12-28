<%-- 
    Document   : adminViewPost.jsp
    Created on : 16-Jan-2025, 1:32:53 pm
    Author     : sarav
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    ArrayList<String> posts = new ArrayList<>();

    String url = "jdbc:mysql://localhost:3306/mydatabase";
    String user = "root";
    String password = "";
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        
        stmt = conn.createStatement();
        String query = "SELECT post_content FROM posts"; // Ensure the column name matches your database
        rs = stmt.executeQuery(query);
        
        while (rs.next()) {
            posts.add(rs.getString("post_content"));
        }
    } catch (Exception e) {
        out.println("<div class='error'>Error: " + e.getMessage() + "</div>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin View Posts</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #ff99cc, #cc99ff);
            color: #fff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 80%;
            max-width: 800px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3), inset 0 -10px 30px rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2rem;
            color: #fff;
        }
        .post {
            background: rgba(255, 255, 255, 0.2);
            margin: 15px 0;
            padding: 15px;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .post:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }
        .post-content {
            font-size: 1.2rem;
            color: #fff;
        }
        .error {
            color: red;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>All Posts</h2> <!-- This is the heading for all posts -->
        <% for(String post : posts) { %>
            <div class="post">
                <div class="post-content"><%= post %></div>
            </div>
        <% } %>
    </div>
</body>
</html>





