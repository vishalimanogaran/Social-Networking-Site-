<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Search Carousel</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background: linear-gradient(135deg, #f8e0f5, #e6dbf8);
      margin: 0;
      padding: 0;
    }

    /* Header Section */
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: linear-gradient(45deg, #9b59b6, #8e44ad);
      padding: 20px 30px;
      color: white;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
      z-index: 100;
    }

    .logo {
      font-size: 30px;
      font-weight: bold;
      letter-spacing: 1px;
    }

    .nav-links a {
      color: white;
      text-decoration: none;
      margin: 0 20px;
      font-size: 18px;
      transition: color 0.3s ease;
    }

    .nav-links a:hover {
      color: #d4c3ff;
    }

    /* Search Section */
    .search-container {
      margin: 30px auto;
      text-align: center;
    }

    .search-container input {
      padding: 15px;
      width: 60%;
      font-size: 16px;
      border: 2px solid #9b59b6;
      border-radius: 30px;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .search-container input:focus {
      transform: scale(1.05);
      box-shadow: 0 6px 15px rgba(155, 89, 182, 0.4);
    }

    .search-container button {
      padding: 15px 35px;
      font-size: 16px;
      border: none;
      background: linear-gradient(45deg, #9b59b6, #8e44ad);
      color: white;
      border-radius: 30px;
      cursor: pointer;
      margin-left: 10px;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
      transition: transform 0.3s ease, background 0.3s ease;
    }

    .search-container button:hover {
      background: linear-gradient(45deg, #8e44ad, #9b59b6);
      transform: scale(1.05);
    }

    /* Popup styles */
    #popup {
      visibility: hidden;
      background: linear-gradient(45deg, #9b59b6, #8e44ad);
      color: white;
      text-align: center;
      border-radius: 25px;
      padding: 15px;
      position: fixed;
      bottom: 20px;
      left: 50%;
      transform: translateX(-50%);
      z-index: 1000;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
      opacity: 0;
      transition: visibility 0s, opacity 0.3s ease-in-out;
    }

    #popup.show {
      visibility: visible;
      opacity: 1;
    }

    /* Carousel Section */
    .carousel-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 30px;
      margin: 50px auto;
    }

    .carousel-item {
      width: 250px;
      height: 380px;
      background: linear-gradient(135deg, #ffffff, #f8e0f5);
      border-radius: 15px;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      text-align: center;
      padding: 20px;
      transform: perspective(1000px) rotateX(0deg);
      transition: transform 0.4s ease, box-shadow 0.4s ease;
    }

    .carousel-item:hover {
      transform: perspective(1000px) rotateX(-15deg);
      box-shadow: 0 12px 25px rgba(0, 0, 0, 0.3);
    }

    .carousel-item img {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }

    .friend-name {
      font-size: 20px;
      font-weight: bold;
      color: #9b59b6;
    }

    .follow-btn, .unfollow-btn {
      padding: 12px;
      border: none;
      border-radius: 30px;
      font-size: 16px;
      margin: 5px 0;
      cursor: pointer;
      width: 100%;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
      transition: transform 0.3s ease, background 0.3s ease;
    }

    .follow-btn {
      background: linear-gradient(45deg, #8e44ad, #9b59b6);
      color: white;
    }

    .follow-btn:hover {
      background: linear-gradient(45deg, #9b59b6, #8e44ad);
      transform: scale(1.05);
    }

    .unfollow-btn {
      background: linear-gradient(45deg, #9b59b6, #8e44ad);
      color: white;
    }

    .unfollow-btn:hover {
      background: linear-gradient(45deg, #8e44ad, #9b59b6);
      transform: scale(1.05);
    }
  </style>
  <script>
    // Show success popup
    function showPopup(message) {
      const popup = document.getElementById("popup");
      popup.textContent = message;
      popup.classList.add("show");
      setTimeout(() => popup.classList.remove("show"), 3000);
    }

    // Handle follow button action
    function handleFollow(userName, image, formElement) {
      showPopup(userName + " has been followed successfully!");
      setTimeout(() => {
        // Redirect to follower.jsp with the friend's name and image
        window.location.href = "follower.jsp?name=" + encodeURIComponent(userName) + "&image=" + encodeURIComponent(image);
      }, 1000); // Delay redirection for a moment
      return false; // Prevent immediate submission
    }

    // Handle unfollow button action
    function handleUnfollow(userName, formElement) {
      showPopup(userName + " has been unfollowed successfully!");
      setTimeout(() => {
        // Add logic for unfollow (e.g., update database, remove from follower list)
        // You can handle the unfollow action on the server-side or redirect the user to a different page
        formElement.submit(); // Submit the form for unfollow
      }, 1000); // Delay submission for a moment
      return false; // Prevent immediate submission
    }
  </script>
</head>
<body>
  <!-- Header Section -->
  <div class="header">
    <div class="logo">Welcome....</div>
    <div class="nav-links">
      <a href="header.jsp">Home</a>
      <a href="profile.jsp">Profile</a>
      <a href="notification.html">Messages</a>
      <a href="logout.jsp">Logout</a>
    </div>
  </div>

  <!-- Search Section -->
  <div class="search-container">
    <form action="search.jsp" method="post">
      <input type="text" name="searchQuery" placeholder="Search...">
      <button type="submit">Search</button>
    </form>
  </div>

  <!-- Popup Section -->
  <div id="popup"></div>

  <!-- Carousel Section -->
  <div class="carousel-container">
    <%
      String dbURL = "jdbc:mysql://localhost:3306/mydatabase";
      String dbUser = "root";
      String dbPassword = "";

      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;

      String searchQuery = request.getParameter("searchQuery");
      if (searchQuery == null) searchQuery = "";

      try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        stmt = conn.createStatement();

        String sql = "SELECT username, profile_image FROM user1";
        rs = stmt.executeQuery(sql);

        while (rs.next()) {
          String name = rs.getString("username");
          String image = rs.getString("profile_image");
    %>
    <div class="carousel-item">
      <img src="<%= image %>" alt="<%= name %>'s profile image">
      <div class="friend-name"><%= name %></div>

      <!-- Follow Button -->
      <form onsubmit="return handleFollow('<%= name %>', '<%= image %>', this)">
        <button type="submit" class="follow-btn">Follow</button>
      </form>

      <!-- Unfollow Button -->
      <form onsubmit="return handleUnfollow('<%= name %>', this)">
        <button type="submit" class="unfollow-btn">Unfollow</button>
      </form>
    </div>
    <% 
        }
      } catch (Exception e) {
        e.printStackTrace();
      } finally {
        try {
          if (rs != null) rs.close();
          if (stmt != null) stmt.close();
          if (conn != null) conn.close();
        } catch (SQLException e) {
          e.printStackTrace();
        }
      }
    %>
  </div>
</body>
</html>
