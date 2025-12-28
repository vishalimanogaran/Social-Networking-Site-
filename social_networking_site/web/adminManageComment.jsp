<%-- 
    Document   : adminManageComment
    Created on : 16-Jan-2025, 1:35:02 pm
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    ArrayList<String> comments = new ArrayList<>();
    String postId = request.getParameter("postId");  // Assume postId is passed in URL

    String url = "jdbc:mysql://localhost:3306/mydatabase";
    String user = "root";
    String password = "";
    
    try {
        Class.forName("com.mysql.jdbc.Driver"); // Use the correct driver for MySQL 8
        conn = DriverManager.getConnection(url, user, password);
        
        stmt = conn.createStatement();
        String query = "SELECT comment_content FROM comments WHERE post_id = " + postId;
        rs = stmt.executeQuery(query);
        
        while (rs.next()) {
            comments.add(rs.getString("comment_content"));
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
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
    <title>Manage Comments</title>
    <style>
        body {
            background-color: #f0f0f0;
            font-family: Arial, sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #6a0dad; /* Purple */
            font-size: 2.5rem;
            margin-top: 20px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        }

        .comment-container {
            width: 80%;
            margin: 20px auto;
            padding: 10px;
            background: #fff;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            transform: perspective(1px) translateZ(0);
            transition: transform 0.25s ease;
        }

        .comment-container:hover {
            transform: translateY(-10px);
        }

        .comment {
            background: #f8f8f8;
            border-radius: 5px;
            padding: 15px;
            margin: 10px 0;
            font-size: 1.1rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .comment:hover {
            background: #ffccf9; /* Light pink on hover */
            transform: scale(1.05);
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .form-container input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #6a0dad;
            border-radius: 5px;
            margin: 10px 0;
            font-size: 1rem;
        }

        .form-container input[type="submit"] {
            padding: 10px 20px;
            background-color: #6a0dad; /* Purple */
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-container input[type="submit"]:hover {
            background-color: #ff69b4; /* Pink */
        }

        .message {
            text-align: center;
            font-size: 1.2rem;
            color: #ff0000;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>Comments for Post <%= postId %></h2>

<div class="comment-container">
    <% 
    if (comments.size() > 0) {
        for (String comment : comments) { 
    %>
        <div class="comment"><%= comment %></div>
    <% 
        }
    } else {
    %>
        <div class="message">No comments yet for this post.</div>
    <% 
    }
    %>
</div>

<div class="form-container">
    <form method="POST" action="adminDeleteComment.jsp">
        <label for="commentId">Comment ID:</label>
        <input type="text" name="commentId" id="commentId" placeholder="Enter Comment ID" />
        <input type="submit" value="Delete Comment" />
    </form>
</div>

</body>
</html>
