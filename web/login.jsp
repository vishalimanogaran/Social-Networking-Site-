<%-- 
    Document   : login
    Created on : 11-Jan-2025, 8:58:37 pm
    Author     : sarav
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #ff69b4, #9c27b0); /* Pink to Purple gradient */
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 35%; /* Adjusted width */
            background-color: #ffffff; /* White background for form */
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
            border: 2px solid #ff69b4; /* Pink border */
        }
        h2 {
            text-align: center;
            color: #9c27b0; /* Purple header */
            font-size: 24px;
            margin-bottom: 20px;
        }
        .input-group {
            margin-bottom: 15px; /* Increased space between fields */
        }
        .input-group label {
            font-size: 14px;
            color: #9c27b0;
            display: block;
            margin-bottom: 5px;
        }
        .input-group input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 2px solid #ff69b4; /* Pink border for inputs */
            border-radius: 10px;
            box-sizing: border-box;
            background-color: #fce4ec; /* Light pink input background */
        }
        .input-group input:focus {
            border-color: #9c27b0; /* Purple border on focus */
            outline: none;
            background-color: #f3e5f5; /* Slightly darker background on focus */
        }
        .button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #ff69b4, #9c27b0); /* Pink to Purple gradient button */
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 10px;
            margin-top: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s, background-color 0.3s;
        }
        .button:hover {
            background: linear-gradient(135deg, #ff85c0, #7b1fa2); /* Brighter gradient on hover */
            transform: translateY(-3px);
        }
        .error {
            color: #e53935; /* Red error message */
            font-size: 14px;
            margin-top: 10px;
        }
        footer {
            margin-top: 20px;
            text-align: center;
            font-size: 12px;
            color: #ffffff; /* White text for footer */
        }
        footer a {
            color: #ffebee; /* Light pink link */
            text-decoration: none;
        }
        footer a:hover {
            text-decoration: underline;
        }
        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                width: 80%;
            }
            h2 {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Login Page</h2>
    <form name="loginForm" action="loginAction.jsp" method="POST">
        <div class="input-group">
            <label for="firstName">First Name</label>
            <input type="text" id="firstName" name="firstName" required>
        </div>
        <div class="input-group">
            <label for="lastName">Last Name</label>
            <input type="text" id="lastName" name="lastName" required>
        </div>
        <div class="input-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="input-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="input-group">
            <label for="profileName">Profile Name (Auto Generated)</label>
            <input type="text" id="profileName" name="profileName" disabled>
        </div>
        <button type="submit" class="button">Submit</button>
    </form>

    <!-- Already have an account? Sign In link -->
    <div style="text-align: center; margin-top: 15px;">
        <p>Already have an account? <a href="signin.jsp" style="color: #9c27b0; text-decoration: none; font-weight: bold;">Sign In</a></p>
    </div>
</div>

<footer>
    © 2025 YourWebsite. All rights reserved.
</footer>

<script>
    // Automatically set profile name when first and last name fields are entered
    document.getElementById('firstName').addEventListener('input', updateProfileName);
    document.getElementById('lastName').addEventListener('input', updateProfileName);

    function updateProfileName() {
        var firstName = document.getElementById('firstName').value;
        var lastName = document.getElementById('lastName').value;
        if (firstName && lastName) {
            var profileName = firstName + " " + lastName;
            document.getElementById('profileName').value = profileName;
        }
    }
</script>

</body>
</html>
