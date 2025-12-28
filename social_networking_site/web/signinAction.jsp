<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In Action</title>
    <style>
        /* General Body Styling */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #f8bbd0, #9c27b0); /* Gradient background with pink and purple */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #ffffff; /* White text for contrast */
        }

        /* Centered Container */
        .signin-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
            color: #9c27b0;
        }

        .signin-container h2 {
            margin-bottom: 20px;
            color: #9c27b0; /* Purple heading */
        }

        /* Error and Success Messages */
        .error-message {
            color: #d32f2f; /* Red color for error */
            margin-top: 15px;
            animation: fadeIn 1s ease-in-out;
        }

        .success-message {
            color: #388e3c; /* Green color for success */
            margin-top: 15px;
            animation: fadeIn 1s ease-in-out;
        }

        /* Keyframes for Fade-in */
        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        /* Responsive Design for Mobile Screens */
        @media (max-width: 600px) {
            body {
                flex-direction: column;
            }

            .signin-container {
                padding: 20px;
                max-width: 90%;
            }
        }

        /* Footer */
        footer {
            position: fixed;
            bottom: 10px;
            width: 100%;
            text-align: center;
            color: white;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="signin-container">
        <h2>Sign In Action</h2>
        <%
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");
                Statement stmt = con.createStatement();
                
                // Using raw SQL query
                String query = "SELECT * FROM users WHERE email = '" + email + "' AND password = '" + password + "'";

                out.println("<p>SQL Query: " + query + "</p>");  // Debugging line to check query

                ResultSet rs = stmt.executeQuery(query);

                if (rs.next()) {
                    session.setAttribute("username", rs.getString("username"));
                    out.println("<div class='success-message'>Welcome, " + rs.getString("username") + "!</div>");
                    response.sendRedirect("header.jsp");
                } else {
                    out.println("<div class='error-message'>Invalid email or password.</div>");
                    out.println("<script>setTimeout(function(){window.history.back();}, 2000);</script>");
                }
            } catch (Exception e) {
                out.println("<div class='error-message'>Error: " + e.getMessage() + "</div>");
                out.println("<script>setTimeout(function(){window.history.back();}, 2000);</script>");
            }
        %>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 YourWebsite. All rights reserved.</p>
    </footer>
</body>
</html>


