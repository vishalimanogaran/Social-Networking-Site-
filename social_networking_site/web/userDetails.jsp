<%-- 
    Document   : userDetails
    Created on : 13-Jan-2025, 5:56:04 pm
    Author     : sarav
--%>

<%@ page import="java.sql.*" %>
<%
    String userId = request.getParameter("userId");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    if (userId != null) {
        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "");

            // Query to get the user details based on userId
            String sql = "SELECT id, name, image_url, bio FROM users WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(userId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String imageUrl = rs.getString("image_url");
                String bio = rs.getString("bio");
%>

<!-- User Details -->
<div>
    <h1><%= name %></h1>
    <img src="<%= imageUrl != null ? imageUrl : "default.jpg" %>" alt="<%= name %>" width="200"/>
    <p><%= bio != null ? bio : "No bio available." %></p>

    <!-- Follow/Unfollow Button -->
    <form method="post" action="followUnfollow.jsp">
        <input type="hidden" name="userId" value="<%= userId %>" />
        <button type="submit" name="action" value="follow">Follow</button>
        <button type="submit" name="action" value="unfollow">Unfollow</button>
    </form>
</div>

<!-- Carousel for user-related media -->
<div class="carousel-container">
    <div class="carousel-track">
        <!-- Sample carousel items -->
        <div class="carousel-item"><img src="image1.jpg" alt="Image 1"></div>
        <div class="carousel-item"><img src="image2.jpg" alt="Image 2"></div>
        <div class="carousel-item"><img src="image3.jpg" alt="Image 3"></div>
    </div>
    <div class="carousel-controls">
        <button class="carousel-control" id="prevBtn">&lt;</button>
        <button class="carousel-control" id="nextBtn">&gt;</button>
    </div>
</div>

<% 
            } else {
                out.println("<p>User not found.</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ignored) {}
        }
    }
%>

<script>
    // Carousel functionality (optional)
    let currentIndex = 0;
    const items = document.querySelectorAll('.carousel-item');
    const prevButton = document.getElementById('prevBtn');
    const nextButton = document.getElementById('nextBtn');
    
    function updateCarousel() {
        const track = document.querySelector('.carousel-track');
        track.style.transform = `translateX(-${currentIndex * 220}px)`;
    }
    
    prevButton.onclick = () => {
        if (currentIndex > 0) {
            currentIndex--;
            updateCarousel();
        }
    };
    
    nextButton.onclick = () => {
        if (currentIndex < items.length - 1) {
            currentIndex++;
            updateCarousel();
        }
    };
</script>
