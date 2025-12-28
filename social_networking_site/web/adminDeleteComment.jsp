<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*, java.sql.*" %>
<%
    String commentIdStr = request.getParameter("commentId");

    // Ensure the commentId is valid and an integer
    if (commentIdStr != null && !commentIdStr.isEmpty()) {
        try {
            int commentId = Integer.parseInt(commentIdStr);

            Connection conn = null;
            Statement stmt = null;

            String url = "jdbc:mysql://localhost:3306/mydatabase";
            String user = "root";
            String password = "";

            try {
                // Register JDBC driver (use the correct one for your MySQL version)
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                
                stmt = conn.createStatement();

                // Check if the comment_id exists
                ResultSet rs = stmt.executeQuery("SELECT comment_id FROM comments WHERE comment_id = " + commentId);
                if (rs.next()) {
                    // If the comment exists, proceed with the delete
                    String query = "DELETE FROM comments WHERE comment_id = " + commentId;
                    int rowsAffected = stmt.executeUpdate(query);
                    
                    if (rowsAffected > 0) {
                        out.println("<div class='message success'>Comment deleted successfully.</div>");
                    } else {
                        out.println("<div class='message error'>Failed to delete comment.</div>");
                    }
                } else {
                    out.println("<div class='message error'>Comment ID does not exist.</div>");
                }
            } catch (Exception e) {
                out.println("<div class='message error'>Error: " + e.getMessage() + "</div>");
            } finally {
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        } catch (NumberFormatException e) {
            out.println("<div class='message error'>Invalid comment ID format.</div>");
        }
    } else {
        out.println("<div class='message error'>Comment ID is missing or empty.</div>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Comment</title>
    <style>
        body {
            background-color: #f3f3f3;
            font-family: 'Arial', sans-serif;
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

        .message {
            padding: 20px;
            margin: 20px;
            text-align: center;
            font-size: 1.2rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }

        .message:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .form-container {
            width: 50%;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .form-container:hover {
            transform: translateY(-10px);
        }

        .form-container input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #6a0dad; /* Purple */
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
    </style>
</head>
<body>



</body>
</html>
