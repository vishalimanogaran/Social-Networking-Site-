<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Search Carousel with Images</title>
  <style>
    /* General Styles */
    body {
      font-family: Arial, sans-serif;
      background-color: #f8e0f5;
      margin: 0;
      padding: 0;
    }

    /* Header Styles */
    .header {
      display: flex;
      justify-content: space-between;
      background-color: #9b59b6;
      padding: 10px 20px;
      color: white;
    }
    .logo {
      font-size: 24px;
      font-weight: bold;
    }
    .nav-links a {
      color: white;
      text-decoration: none;
      margin: 0 15px;
      font-size: 16px;
    }
    .nav-links a:hover {
      color: #8e44ad;
    }

    /* Search Section */
    .search-container {
      margin: 20px auto;
      text-align: center;
    }
    .search-container input {
      padding: 10px;
      width: 60%;
      font-size: 16px;
      border-radius: 5px;
      border: 1px solid #9b59b6;
    }
    .search-container button {
      padding: 10px 20px;
      font-size: 16px;
      border: none;
      background-color: #9b59b6;
      color: white;
      border-radius: 5px;
      cursor: pointer;
      margin-left: 10px;
    }
    .search-container button:hover {
      background-color: #8e44ad;
    }

    /* Carousel Styles */
    .carousel-container {
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 30px auto;
      position: relative;
    }
    .carousel-track {
      display: flex;
      gap: 20px;
      transition: transform 0.5s ease-in-out;
    }
    .carousel-item {
      width: 200px;
      height: 300px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 20px;
      text-align: center;
      box-sizing: border-box;
    }
    .carousel-item img {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 8px;
    }
    .friend-name {
      font-size: 18px;
      font-weight: bold;
      color: #9b59b6;
    }
    .follow-btn, .unfollow-btn {
      padding: 10px 20px; /* Ensuring both buttons have the same size */
      margin: 5px 0;
      border-radius: 5px;
      border: 1px solid #9b59b6;
      cursor: pointer;
      width: 100%;
    }
    .follow-btn {
      background-color: #9b59b6;
      color: white;
    }
    .unfollow-btn {
      background-color: #8e44ad;
      color: white;
    }

    /* Popup Style */
    .popup {
      position: fixed;
      top: 20px;
      left: 50%;
      transform: translateX(-50%);
      background-color: #9b59b6;
      color: white;
      padding: 10px;
      border-radius: 5px;
      display: none;
      z-index: 1000;
      font-size: 16px;
    }
    .popup.show {
      display: block;
    }
  </style>
</head>
<body>
  <!-- Header Section -->
  <div class="header">
    <div class="logo">Welcome...</div>
    <div class="nav-links">
      <a href="header.jsp">Home</a>
      <a href="profile.jsp">Profile</a>
      <a href="notification.html">Messages</a>
      <a href="post.jsp">Post</a>
      <a href="logout.jsp">Logout</a>
    </div>
  </div>

  <!-- Search Section -->
  <div class="search-container">
    <form action="search.jsp" method="post">
      <input type="text" placeholder="Search..." id="searchInput" name="searchQuery">
      <button id="searchBtn">Search</button>
    </form>
  </div>

  <!-- Popup for Success Message -->
  <div id="popup" class="popup">Action Successful!</div>

  <!-- Carousel Container -->
  <div class="carousel-container">
    <div class="carousel-track" id="carouselTrack">
      <% 
        String searchQuery = request.getParameter("searchQuery");
        if (searchQuery == null) {
            searchQuery = "";
        }
        
        // Define carousel items with images in the "images" folder
        String[][] items = {
           {"Arisha", "girl1.jpg"},
           {"Sarjun", "boy1.jpg"},
           {"Keerthi", "girl2.jpg"},
           {"Vikas", "boy3.jpg"},
           {"Deepthi", "girl3.jpg"},
           {"Sidharth", "boy4.jpg"},
           {"Saha", "girl4.jpg"},
           {"Vihaan", "boy5.jpg"},
           {"zara", "girl6.jpg"},
           {"Mithu", "girl5.jpg"},
           {"zach", "boy6.jpg"},
           {"shiv", "boy7.jpg"},
           {"pranav", "boy2.jpg"}

                
        };

        for (String[] item : items) {
            String name = item[0];
            String image = item[1];

            if (name.toLowerCase().contains(searchQuery.toLowerCase())) {
      %>
        <div class="carousel-item" data-name="<%= name %>">
          <img src="<%= image %>" alt="<%= name %>" class="lazy">
          <p class="friend-name"><%= name %></p>

          <!-- Follow Button -->
          <form action="follower1.jsp" method="get">
            <input type="hidden" name="followerName" value="<%= name %>">
            <input type="hidden" name="followerImage" value="<%= image %>">
            <button type="submit" class="follow-btn" onclick="followUser('<%= name %>')">Follow</button>
          </form>

          <!-- Unfollow Button -->
          <button class="unfollow-btn" onclick="unfollowUser('<%= name %>')">Unfollow</button>
        </div>
      <% 
            }
        }
      %>
    </div>
  </div>

  <script>
    // Show success popup
    function showPopup(message) {
      const popup = document.getElementById("popup");
      popup.textContent = message;
      popup.classList.add("show");
      setTimeout(() => popup.classList.remove("show"), 3000);
    }

    // Handle unfollow button action
    function unfollowUser(userName) {
      showPopup(userName + " has been unfollowed successfully!");
    }

    // Handle follow button action
    function followUser(userName) {
      showPopup(userName + " has been followed successfully!");
      setTimeout(function() {
        // Redirect after 4 seconds
        window.location.href = "nextpage.jsp"; // Replace with actual redirect URL
      }, 4000); // Wait for 4 seconds before redirect
    }
  </script>
</body>
</html>
