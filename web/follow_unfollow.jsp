<%@ page import="java.sql.*" %>
<%
    // Get userId and action from the request
    String userId = request.getParameter("userId");
    String action = request.getParameter("action");

    // Simulate logged-in user ID (retrieve from session instead of hard-coding)
    Integer loggedInUserId = (Integer) session.getAttribute("userId");

    if (loggedInUserId == null) {
        out.println("<p>You must be logged in to follow/unfollow users.</p>");
    } else if (userId != null && action != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

            if ("follow".equals(action)) {
                // Insert a follow entry
                String sql = "INSERT INTO follows (follower_id, followed_id) VALUES (?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, loggedInUserId); // Logged-in user ID
                pstmt.setInt(2, Integer.parseInt(userId)); // User to follow
                pstmt.executeUpdate();
                out.println("<p>You are now following the user!</p>");
            } else if ("unfollow".equals(action)) {
                // Remove a follow entry
                String sql = "DELETE FROM follows WHERE follower_id = ? AND followed_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, loggedInUserId); // Logged-in user ID
                pstmt.setInt(2, Integer.parseInt(userId)); // User to unfollow
                pstmt.executeUpdate();
                out.println("<p>You have unfollowed the user.</p>");
            }

        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            // Close database resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ignored) {}
        }
    } else {
        out.println("<p>Invalid request. Please specify a valid user ID and action.</p>");
    }
%>

<a href="search.jsp">Go Back</a>

