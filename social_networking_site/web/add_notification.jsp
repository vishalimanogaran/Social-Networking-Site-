<%-- 
    Document   : add_notification
    Created on : 15-Jan-2025, 10:52:20 am
    Author     : sarav
--%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Notification</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #ff69b4, #9c27b0); /* Pink to purple gradient */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 40%;
            background: white; /* White background for form container */
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3), 
                        0 6px 6px rgba(0, 0, 0, 0.2); /* 3D shadow effect */
            text-align: center;
        }
        h2 {
            color: #9c27b0; /* Purple heading text */
            margin-bottom: 20px;
            font-size: 24px;
        }
        input, textarea {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 2px solid #ff69b4; /* Pink border for input fields */
            border-radius: 10px;
            background-color: #fce4ec; /* Light pink input background */
            font-size: 14px;
            color: #333;
        }
        input:focus, textarea:focus {
            border-color: #9c27b0; /* Purple border on focus */
            outline: none;
            background-color: #f3e5f5; /* Slightly darker pink background */
        }
        button {
            background: linear-gradient(135deg, #ff69b4, #9c27b0); /* Pink to purple gradient button */
            color: white;
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); /* Button shadow effect */
            transition: transform 0.3s, box-shadow 0.3s;
        }
        button:hover {
            background: linear-gradient(135deg, #ff85c0, #7b1fa2); /* Brighter hover effect */
            transform: translateY(-3px); /* Slight hover lift */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }
        p {
            color: #4caf50; /* Green for success message */
            margin-top: 20px;
        }
        .error {
            color: #e53935; /* Red for error message */
            margin-top: 20px;
        }
        @media (max-width: 768px) {
            .container {
                width: 80%;
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
        <h2>Add Notification</h2>
        <form method="post">
            <input type="text" name="username" placeholder="Enter Username" required />
            <textarea name="message" placeholder="Enter Notification Message" rows="4" required></textarea>
            <input type="number" name="user_id" placeholder="Enter User ID" required />
            <button type="submit">Add Notification</button>
        </form>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String username = request.getParameter("username");
                String message = request.getParameter("message");
                String userId = request.getParameter("user_id");  // Get user_id

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");
                    String query = "INSERT INTO notifications (user_id, username, message) VALUES (?, ?, ?)";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setInt(1, Integer.parseInt(userId));  // Set user_id value
                    stmt.setString(2, username);
                    stmt.setString(3, message);
                    stmt.executeUpdate();

                    out.println("<p>Notification added successfully!</p>");
                    conn.close();
                } catch (Exception e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
