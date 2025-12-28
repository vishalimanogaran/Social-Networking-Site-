<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .profile-container {
            width: 50%;
            margin: 0 auto;
            text-align: center;
        }
        .profile-container h2 {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h2>Profile Update Status</h2>
        <%
            // Retrieve parameters from the request
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            Part filePart = null;

            try {
                // Check for multipart form data
                if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
                    filePart = request.getPart("profile_picture");
                }

                // Database connection setup
                Class.forName("com.mysql.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");
                     PreparedStatement pst = conn.prepareStatement(
                         "UPDATE users SET name = ?, email = ?, profile_picture = ? WHERE id = ?")) {

                    // Set parameters in the query
                    pst.setString(1, name);
                    pst.setString(2, email);

                    // Handle file upload if present
                    if (filePart != null && filePart.getSize() > 0) {
                        InputStream profilePicture = filePart.getInputStream();
                        pst.setBinaryStream(3, profilePicture, filePart.getSize());
                    } else {
                        pst.setNull(3, java.sql.Types.BLOB);
                    }

                    // Assuming user ID is 1 (modify based on your login system)
                    pst.setInt(4, 1);

                    // Execute the update query
                    int rowsAffected = pst.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<p>Your profile has been updated successfully!</p>");
                        out.println("<p>Name: " + name + "</p>");
                        out.println("<p>Email: " + email + "</p>");
                    } else {
                        out.println("<p>Error: Unable to update your profile. Please try again.</p>");
                    }
                }
            } catch (Exception e) {
                // Print stack trace for debugging and show error message to user
                e.printStackTrace();
                out.println("<p>Error updating profile: " + e.getMessage() + "</p>");
            }
        %>
    </div>
</body>
</html>
