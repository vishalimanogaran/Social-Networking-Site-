<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 500px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 10px 10px 30px rgba(0, 0, 0, 0.25), -10px -10px 30px rgba(255, 255, 255, 0.5);
            background: linear-gradient(145deg, #f8d7ec, #ffffff); /* Light 3D gradient effect */
            transform: perspective(1000px) rotateX(5deg) scale(1.03); /* 3D rotation effect */
        }
        h1 {
            text-align: center;
            color: #b02fc2;
            font-size: 32px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
            font-weight: bold;
            color: #6a1b9a;
        }
        input {
            margin-bottom: 20px;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(145deg, #ece1f1, #ffffff); /* Soft 3D background */
            font-size: 14px;
            box-shadow: inset 5px 5px 10px rgba(0, 0, 0, 0.1), inset -5px -5px 10px rgba(255, 255, 255, 0.7);
            transition: all 0.3s ease;
        }
        input:focus {
            outline: none;
            box-shadow: 0 5px 15px rgba(186, 104, 200, 0.5), inset 5px 5px 15px rgba(0, 0, 0, 0.1);
            transform: scale(1.05);
        }
        button {
            padding: 15px;
            color: white;
            background: linear-gradient(145deg, #d500f9, #8e24aa);
            border: none;
            border-radius: 10px;
            cursor: pointer;
            box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.2), -5px -5px 15px rgba(255, 255, 255, 0.7);
            transition: all 0.3s ease;
            font-weight: bold;
            font-size: 16px;
        }
        button:hover {
            background: linear-gradient(145deg, #ba68c8, #d500f9);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
            transform: translateY(-5px);
        }
        button:active {
            transform: translateY(2px);
            box-shadow: inset 5px 5px 15px rgba(0, 0, 0, 0.2);
        }
        .message {
            margin-top: 20px;
            text-align: center;
            font-size: 16px;
            color: #4caf50;
        }
        .error {
            color: #f44336;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Update Profile</h1>
        <%
            String message = "";
            if (request.getParameter("update") != null) {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("confirm_password");

                if (password.equals(confirmPassword)) {
                    Connection con = null;
                    Statement stmt = null;
                    try {
                        // Load MySQL JDBC driver
                        Class.forName("com.mysql.jdbc.Driver");

                        // Connect to the database
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");
                        stmt = con.createStatement();

                        // Check if the new email is already in use (excluding current user's email)
                        String checkEmailQuery = "SELECT * FROM users WHERE LOWER(email) = LOWER('" + email + "') AND username != '" + username + "';";
                        ResultSet emailRs = stmt.executeQuery(checkEmailQuery);

                        if (emailRs.next()) {
                            message = "<span class='error'>Error: The email '" + email + "' is already in use.</span>";
                        } else {
                            // Check if the username exists
                            String checkQuery = "SELECT * FROM users WHERE LOWER(username) = LOWER('" + username + "');";
                            ResultSet rs = stmt.executeQuery(checkQuery);

                            if (rs.next()) {
                                // Username exists, so update the user's email and password
                                String updateQuery = "UPDATE users SET email='" + email + "', password='" + password + "' WHERE username='" + username + "';";
                                int rowsUpdated = stmt.executeUpdate(updateQuery);

                                if (rowsUpdated > 0) {
                                    message = "Profile updated successfully!";
                                } else {
                                    message = "<span class='error'>Error: Could not update profile.</span>";
                                }
                            } else {
                                message = "<span class='error'>Error: Username not found.</span>";
                            }
                        }
                    } catch (Exception e) {
                        message = "<span class='error'>Error: " + e.getMessage() + "</span>";
                    } finally {
                        try {
                            if (stmt != null) stmt.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            message = "<span class='error'>Error: " + e.getMessage() + "</span>";
                        }
                    }
                } else {
                    message = "<span class='error'>Error: Passwords do not match.</span>";
                }
            }
        %>
        <form method="post">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>

            <label for="confirm_password">Confirm Password</label>
            <input type="password" id="confirm_password" name="confirm_password" required>

            <button type="submit" name="update">Update</button>
        </form>
        <div class="message">
            <%= message %>
        </div>
    </div>
</body>
</html>
