<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        /* Page background color */
        body {
            background: linear-gradient(135deg, #ff66b2, #9b4dca); /* Pink to Purple gradient */
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Container styling */
        .login-container {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* 3D shadow effect */
            padding: 40px;
            width: 300px;
            text-align: center;
            box-sizing: border-box;
        }

        h2 {
            color: #9b4dca; /* Purple color for the heading */
            margin-bottom: 20px;
            font-size: 24px;
        }

        /* Label and input fields styling */
        label {
            color: #9b4dca;
            font-size: 18px;
            text-align: left;
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 2px solid #9b4dca;
            border-radius: 10px;
            font-size: 16px;
            box-sizing: border-box;
            outline: none;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #ff66b2; /* Pink focus color */
            box-shadow: 0 0 8px rgba(255, 102, 178, 0.6); /* Pink glow effect */
        }

        /* Submit button styling */
        input[type="submit"] {
            background: #9b4dca;
            color: white;
            font-size: 18px;
            padding: 12px;
            border: none;
            border-radius: 10px;
            width: 100%;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        input[type="submit"]:hover {
            background: #ff66b2; /* Pink hover effect */
            transform: translateY(-3px); /* 3D effect on hover */
        }

        /* Error message styling */
        .error {
            color: #ff3333;
            font-size: 14px;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Admin Login</h2>
        <form method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>
            
            <input type="submit" value="Login">
        </form>
        
        <% 
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            if (username != null && password != null) {
                try {
                    // Load the JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");  // Use the new MySQL driver class
                    
                    // Database connection (Replace with your actual database credentials)
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

                    // SQL Query to verify login (ensure password is hashed in the database in production)
                    String query = "SELECT * FROM admin WHERE username=? AND password=?";
                    PreparedStatement stmt = con.prepareStatement(query);
                    stmt.setString(1, username);
                    stmt.setString(2, password); // Store password securely (hashed) in production
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        // User is authenticated, forward to dashboard.jsp
                        request.setAttribute("username", username);
                        RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
                        rd.forward(request, response);  // Redirect to admin dashboard
                    } else {
                        out.println("<p class='error'>Invalid username or password.</p>");
                    }
                    
                    // Close connections
                    rs.close();
                    stmt.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<p class='error'>An error occurred: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

</body>
</html>
