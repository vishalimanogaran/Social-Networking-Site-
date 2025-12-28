<%-- 
    Document   : loginAction
    Created on : 11-Jan-2025, 9:00:25 pm
    Author     : sarav
--%>

<%@ page import="java.sql.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Action</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(90deg, #ff69b4, #9b59b6); /* Pink to Purple gradient */
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            color: #9b59b6;
            width: 40%;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .container h3 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .container p {
            font-size: 16px;
            margin-top: 10px;
        }

        .container a {
            color: #ff69b4;
            font-weight: bold;
            text-decoration: none;
        }

        .container a:hover {
            text-decoration: underline;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #9b59b6;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #ff69b4;
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            // Retrieve form parameters
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String username = request.getParameter("username");

            Connection con = null;
            Statement stmt = null;

            try {
                // Load the database driver
                Class.forName("com.mysql.jdbc.Driver");

                // Establish a database connection
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

                // Create a statement object
                stmt = con.createStatement();

                // SQL query to insert the new user into the database
                String query = "INSERT INTO users (firstName, lastName, email, password, username) " +
                               "VALUES ('" + firstName + "', '" + lastName + "', '" + email + "', '" + password + "', '" + username + "')";

                // Execute the query
                int result = stmt.executeUpdate(query);

                if (result > 0) {
        %>
                    <h3>Sign-Up Successful</h3>
                    <p>Your account has been created successfully.</p>
                    <a href="header.jsp" class="btn">Login Now</a>
        <%
                } else {
        %>
                    <h3>Error: Account Creation Failed</h3>
                    <p>Please try again.</p>
                    <a href="login.jsp" class="btn">Go Back</a>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
                <h3>Error Occurred</h3>
                <p><%= e.getMessage() %></p>
                <a href="login.jsp" class="btn">Try Again</a>
        <%
            } finally {
                // Close resources
                try {
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
