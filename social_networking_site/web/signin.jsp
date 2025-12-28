<%-- 
    Document   : signin
    Created on : 11-Jan-2025, 9:29:19 pm
    Author     : sarav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <style>
        /* General Styles */
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

        /* Sign-in Container */
        .signin-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .signin-container h2 {
            margin-bottom: 25px;
            color: #9c27b0; /* Purple heading */
        }

        /* Form Group */
        .form-group {
            position: relative;
            margin-bottom: 30px;
        }

        .form-group label {
            position: absolute;
            top: 10px;
            left: 10px;
            font-size: 14px;
            color: #9c27b0;
            transition: 0.3s ease-in-out;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #f8bbd0; /* Light pink border */
            border-radius: 5px;
            font-size: 14px;
            background-color: #fce4ec;
            transition: 0.3s ease-in-out;
        }

        .form-group input:focus {
            border-color: #9c27b0;
            outline: none;
        }

        .form-group input:focus + label,
        .form-group input:not(:placeholder-shown) + label {
            top: -10px;
            font-size: 12px;
            color: #6a1b9a; /* Darker purple when focused */
        }

        /* Submit Button */
        .submit-btn {
            background-color: #9c27b0;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .submit-btn:hover {
            background-color: #8e24aa; /* Darker purple on hover */
        }

        .submit-btn:disabled {
            background-color: #ccc;
            cursor: not-allowed;
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

        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        /* Sign-up Link */
        .signup-link {
            margin-top: 20px;
        }

        .signup-link a {
            color: #9c27b0;
            text-decoration: none;
            font-size: 14px;
        }

        .signup-link a:hover {
            text-decoration: underline;
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
        <h2>Sign In</h2>
        <!-- Optional messages -->
        <div class="error-message" id="error-message" style="display:none;">
            Invalid email or password.
        </div>
        <div class="success-message" id="success-message" style="display:none;">
            Welcome back! You are successfully signed in.
        </div>
        
        <form action="signinAction.jsp" method="post">
            <div class="form-group">
                <input type="email" id="email" name="email" placeholder=" " required>
                <label for="email">Email</label>
            </div>
            <div class="form-group">
                <input type="password" id="password" name="password" placeholder=" " required>
                <label for="password">Password</label>
            </div>
            <button type="submit" class="submit-btn">Sign In</button>
        </form>

        <div class="signup-link">
            <p>Don't have an account? <a href="login.jsp">Sign Up</a></p>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 YourWebsite. All rights reserved.</p>
    </footer>
</body>
</html>

