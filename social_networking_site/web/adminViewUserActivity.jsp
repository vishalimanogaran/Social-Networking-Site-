<%-- 
    Document   : adminViewUserActivity
    Created on : 16-Jan-2025, 1:37:03 pm
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    ArrayList<String> userActivity = new ArrayList<>();

    String url = "jdbc:mysql://localhost:3306/mydatabase";
    String user = "root";
    String password = "";
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        
        stmt = conn.createStatement();
        String query = "SELECT username, activity_description FROM user_activity";  // Example query
        rs = stmt.executeQuery(query);
        
        while (rs.next()) {
            String activity = rs.getString("username") + ": " + rs.getString("activity_description");
            userActivity.add(activity);
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
<html>
    <head>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(to bottom, pink, purple);
                color: white;
                text-align: center;
                margin: 0;
                padding: 0;
            }

            h2 {
                text-shadow: 2px 2px 4px #000;
            }

            .activity-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-top: 20px;
            }

            .activity-box {
                background: rgba(255, 255, 255, 0.2);
                color: #fff;
                padding: 15px 20px;
                margin: 10px 0;
                border-radius: 15px;
                box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.5);
                width: 60%;
                text-align: left;
                font-size: 18px;
                transition: transform 0.2s ease-in-out;
            }

            .activity-box:hover {
                transform: translateY(-5px) scale(1.05);
                box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.8);
            }
        </style>
    </head>
    <body>
        <h2>User Activity</h2>
        <div class="activity-container">
            <% for (String activity : userActivity) { %>
                <div class="activity-box"><%= activity %></div>
            <% } %>
        </div>
    </body>
</html>
