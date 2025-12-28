<%-- 
    Document   : viewNotification
    Created on : 15-Jan-2025, 11:14:33 am
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Notifications</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #ff69b4, #9c27b0); /* Pink to Purple gradient */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            width: 70%;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3), 
                        0 6px 6px rgba(0, 0, 0, 0.2); /* 3D shadow effect */
        }
        h2 {
            text-align: center;
            color: #9c27b0; /* Purple text for the heading */
            margin-bottom: 20px;
            font-size: 24px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 14px;
        }
        th {
            background: linear-gradient(135deg, #ff69b4, #9c27b0); /* Pink to Purple gradient header */
            color: white;
            font-weight: bold;
        }
        td {
            background-color: #fce4ec; /* Light pink row background */
            color: #333;
        }
        tr:hover td {
            background-color: #f3e5f5; /* Slightly darker pink on hover */
        }
        .error {
            color: #e53935; /* Red for error messages */
            text-align: center;
            margin-top: 10px;
        }
        @media (max-width: 768px) {
            .container {
                width: 90%;
                padding: 20px;
            }
            h2 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Notifications</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Message</th>
                <th>Created At</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");
                    Statement stmt = conn.createStatement();
                    String query = "SELECT * FROM notifications ORDER BY created_at DESC";
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getInt("id") + "</td>");
                        out.println("<td>" + rs.getString("username") + "</td>");
                        out.println("<td>" + rs.getString("message") + "</td>");
                        out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
                        out.println("</tr>");
                    }

                    conn.close();
                } catch (Exception e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                }
            %>
        </table>
    </div>
</body>
</html>
