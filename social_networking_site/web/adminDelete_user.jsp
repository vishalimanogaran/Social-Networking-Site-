<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Enumeration" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            text-align: center;
            margin: 0;
            padding: 50px;
        }
        .message {
            font-size: 18px;
            padding: 15px;
            border-radius: 10px;
            margin: 10px auto;
            width: 80%;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .error { color: red; background-color: #ffe6e6; }
        .success { color: green; background-color: #e6ffea; }
        a {
            display: inline-block;
            margin-top: 20px;
            color: #800080;
            text-decoration: none;
        }
    </style>
</head>
<body>
<%
    String user_id = request.getParameter("user_id");

    if (user_id == null || user_id.trim().isEmpty()) {
        out.println("<div class='message error'>User ID is missing or invalid. <a href='manage_users.jsp'>Go back</a>.</div>");
    } else {
        try {
            int userId = Integer.parseInt(user_id);

            // Database Connection
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");
                 PreparedStatement deletePostsStmt = conn.prepareStatement("DELETE FROM posts WHERE user_id = ?");
                 PreparedStatement deleteUserStmt = conn.prepareStatement("DELETE FROM users WHERE user_id = ?")) {

                // Step 1: Delete related posts (child rows)
                deletePostsStmt.setInt(1, userId);
                int postsDeleted = deletePostsStmt.executeUpdate();

                // Step 2: Delete the user (parent row)
                deleteUserStmt.setInt(1, userId);
                int userDeleted = deleteUserStmt.executeUpdate();

                // Display the result
                if (userDeleted > 0) {
                    out.println("<div class='message success'>User and " + postsDeleted + " related post(s) deleted successfully. <a href='adminManage_users.jsp'>Go back</a>.</div>");
                } else {
                    out.println("<div class='message error'>User not found or deletion failed. <a href='adminManage_users.jsp'>Go back</a>.</div>");
                }
            }
        } catch (NumberFormatException e) {
            out.println("<div class='message error'>Invalid User ID format. <a href='manage_users.jsp'>Go back</a>.</div>");
        } catch (Exception e) {
            out.println("<div class='message error'>An error occurred: " + e.getMessage() + "</div>");
        }
    }
%>
</body>
</html>

