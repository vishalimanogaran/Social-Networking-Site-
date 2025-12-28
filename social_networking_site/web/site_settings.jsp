<%-- 
    Document   : site_settings
    Created on : 16-Jan-2025, 10:43:15 am
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Site Settings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }
        h2 {
            text-align: center;
            color: #800080; /* Purple */
        }
        form {
            width: 50%;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        form:hover {
            transform: scale(1.05); /* 3D Hover Effect */
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 16px;
            transition: border 0.3s ease, box-shadow 0.3s ease;
        }
        input[type="text"]:focus {
            border: 1px solid #800080; /* Purple */
            box-shadow: 0 0 8px rgba(128, 0, 128, 0.3);
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #800080; /* Purple */
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #ff69b4; /* Pink */
            transform: scale(1.05); /* 3D Hover Effect */
        }
        .message {
            font-size: 18px;
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .error {
            color: red;
            background-color: #ffe6e6;
            border: 1px solid #f44336;
        }
        .success {
            color: green;
            background-color: #e6ffea;
            border: 1px solid #4caf50;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-align: center;
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

    <h2>Admin - Site Settings</h2>

    <%
        String siteName = "";

        // Fetch the current site name from the database
        try {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

            // SQL query to fetch the current site name
            String query = "SELECT site_name FROM settings WHERE id = 1";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            if (rs.next()) {
                siteName = rs.getString("site_name");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<div class='message error'>" + e.getMessage() + "</div>");
        }
    %>

    <!-- Display the current site name -->
    <form method="post">
        <label for="site_name">Site Name:</label>
        <input type="text" id="site_name" name="site_name" value="<%= siteName %>" required>
        <br><br>
        <input type="submit" value="Update Settings">
    </form>

    <%
        // Update the site name if the form is submitted
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String newSiteName = request.getParameter("site_name");

            try {
                // Connect to the database
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

                // SQL query to update the site name
                String updateQuery = "UPDATE settings SET site_name = ? WHERE id = 1";
                PreparedStatement pstmt = conn.prepareStatement(updateQuery);
                pstmt.setString(1, newSiteName);
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<div class='message success'>Settings updated successfully!</div>");
                    siteName = newSiteName; // Update the displayed site name
                } else {
                    out.println("<div class='message error'>Failed to update settings.</div>");
                }

                conn.close();
            } catch (Exception e) {
                out.println("<div class='message error'>" + e.getMessage() + "</div>");
            }
        }
    %>

    <br>
    <a href="dashboard.jsp">Back to Dashboard</a>

</body>
</html>
