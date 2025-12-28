<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Profile</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background: linear-gradient(135deg, #f8e0f5, #ffccff); /* Gradient background */
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      flex-direction: column;
    }

    /* Main container */
    .content-container {
      width: 80%; /* Set width to 80% */
      max-width: 1200px; /* Limit max width */
      display: flex;
      flex-direction: column;
      gap: 30px;
      align-items: center;
    }

    /* Profile Section */
    .profile-container,
    .call-buttons,
    .chat-section {
      width: 100%; /* Full width of content container */
      text-align: center;
      padding: 30px;
      background-color: #ffffff;
      border-radius: 12px;
      box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
      background-color: #ffccff;
      transition: transform 0.3s ease;
    }

    .profile-container:hover,
    .chat-section:hover,
    .call-buttons:hover {
      transform: translateY(-10px); /* Subtle hover effect */
    }

    .profile-header img {
      border-radius: 50%;
      width: 120px;
      height: 120px;
      border: 5px solid #9b59b6;
      transition: transform 0.3s ease;
    }

    .profile-header img:hover {
      transform: scale(1.1); /* Scale up image on hover */
    }

    .profile-header h2 {
      color: #9b59b6;
    }

    /* Call Buttons */
    .call-buttons .button-row {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 15px;
    }

    button {
      padding: 12px 25px;
      cursor: pointer;
      background-color: #9b59b6;
      color: white;
      border: none;
      border-radius: 50px;
      font-size: 16px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    button:hover {
      transform: translateY(-5px);
      box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
    }

    /* Chat Section */
    textarea {
      width: 100%;
      height: 120px;
      margin-bottom: 20px;
      padding: 12px;
      border: 1px solid #9b59b6;
      border-radius: 10px;
      font-size: 16px;
      color: #9b59b6;
      transition: border-color 0.3s ease;
    }

    textarea:focus {
      border-color: #6a1b9a;
      outline: none;
    }

    /* Emoji Picker Section */
    .emoji-picker {
      display: flex;
      justify-content: space-around;
      margin-top: 10px;
    }

    .emoji-picker button {
      background: transparent;
      border: none;
      font-size: 24px;
      cursor: pointer;
    }

    .emoji-picker button:hover {
      transform: scale(1.2);
    }

    /* Success Message */
    .success-message {
      color: green;
      font-weight: bold;
      display: none;
    }

    /* Video Call Section */
    #videoCallSection {
      display: none;
      margin-top: 20px;
    }

    #videoCallSection video {
      width: 100%;
      max-width: 500px;
      height: 300px;
      border-radius: 12px;
      border: 2px solid #9b59b6;
    }
  </style>
</head>
<body>
  <div class="content-container">
    <%-- Fetching variables from session or request --%>
    <%
      String followerName = request.getParameter("name");
      String followerImage = request.getParameter("image");

      if (followerName == null || followerName.trim().isEmpty()) {
        followerName = "No Name";
      }
      if (followerImage == null || followerImage.trim().isEmpty()) {
        followerImage = "default-profile-pic.jpg";
      }
    %>

    <!-- Profile Section -->
    <div class="profile-container">
      <div class="profile-header">
        <img src="<%= followerImage %>" alt="Follower Profile Picture">
        <h2><%= followerName %></h2>
      </div>
    </div>

    <!-- Call Buttons Section -->
    <div class="call-buttons">
      <div class="button-row">
        <button onclick="startNormalCall('<%= followerName %>')">📞 Normal Call</button>
        <button id="videoCallBtn" onclick="startVideoCall()">🎥 Video Call</button>
      </div>
      <div class="button-row">
        <button id="endCallBtn" style="display: none;" onclick="endCall()">❌ End Call</button>
        <button id="muteBtn" style="display: none;" onclick="toggleMute()">🔇 Mute</button>
        <button id="holdBtn" style="display: none;" onclick="toggleHold()">⏸ Hold</button>
        <button id="addCallBtn" style="display: none;" onclick="addCall()">📞 Add Call</button>
      </div>
    </div>

    <!-- Video Call Section (hidden by default) -->
    <div id="videoCallSection">
      <video id="localVideo" autoplay muted></video>
    </div>

    <!-- Chat Section -->
    <div class="chat-section">
      <h3>Chat with <%= followerName %></h3>
      <div id="messageDisplay"></div> <!-- Messages will be appended here -->
      <textarea id="chatBox" placeholder="Type a message..."></textarea>
      <div class="emoji-picker">
        <button onclick="addEmoji('😊')">😊</button>
        <button onclick="addEmoji('😢')">😢</button>
        <button onclick="addEmoji('😂')">😂</button>
        <button onclick="addEmoji('❤️')">❤️</button>
        <button onclick="addEmoji('👍')">👍</button>
      </div>
      <div>
        <button onclick="sendMessage()">Send</button>
      </div>
      <p id="successMessage" class="success-message">Message Sent Successfully!</p>
    </div>
  </div>

  <script>
    // Start Normal Call
    function startNormalCall(name) {
      alert("Starting a normal call with " + name);

      // Show call controls
      document.getElementById("endCallBtn").style.display = "inline-block";
      document.getElementById("muteBtn").style.display = "inline-block";
      document.getElementById("holdBtn").style.display = "inline-block";
      document.getElementById("addCallBtn").style.display = "inline-block";
    }

    // Start Video Call
    function startVideoCall() {
      alert("Starting a video call...");
      
      // Show video and controls for video call
      document.getElementById("videoCallSection").style.display = "block";
      
      // Simulate starting a camera (use actual camera logic in production)
      const videoElement = document.getElementById("localVideo");
      navigator.mediaDevices.getUserMedia({ video: true })
        .then(function(stream) {
          videoElement.srcObject = stream;
        })
        .catch(function(error) {
          console.error("Error accessing camera: ", error);
        });

      // Show video call controls
      document.getElementById("endCallBtn").style.display = "inline-block";
      document.getElementById("muteBtn").style.display = "inline-block";
      document.getElementById("holdBtn").style.display = "inline-block";
      document.getElementById("addCallBtn").style.display = "inline-block";
    }

    // End Call
    function endCall() {
      alert("Ending the call");

      // Hide controls
      document.getElementById("endCallBtn").style.display = "none";
      document.getElementById("muteBtn").style.display = "none";
      document.getElementById("holdBtn").style.display = "none";
      document.getElementById("addCallBtn").style.display = "none";

      // Stop video stream if in a video call
      const videoElement = document.getElementById("localVideo");
      if (videoElement.srcObject) {
        const stream = videoElement.srcObject;
        const tracks = stream.getTracks();
        tracks.forEach(function(track) {
          track.stop();
        });
        videoElement.srcObject = null;
      }

      // Hide video call section
      document.getElementById("videoCallSection").style.display = "none";
    }

    // Mute
    function toggleMute() {
      alert("Toggling mute");
    }

    // Hold
    function toggleHold() {
      alert("Toggling hold");
    }

    // Add Call
    function addCall() {
      alert("Adding a new call");
    }

    // Send Message
    function sendMessage() {
      const message = document.getElementById("chatBox").value;
      if (message.trim() !== "") {
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "sendMessage.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send("message=" + encodeURIComponent(message));

        xhr.onload = function () {
          if (xhr.status === 200) {
            const messageDisplay = document.getElementById("messageDisplay");
            const newMessage = document.createElement("p");
            newMessage.textContent = message;
            messageDisplay.appendChild(newMessage);

            const successMessage = document.getElementById("successMessage");
            successMessage.style.display = "block";
            setTimeout(() => {
              successMessage.style.display = "none";
            }, 3000);

            document.getElementById("chatBox").value = "";
          }
        };

        xhr.onerror = function () {
          const messageDisplay = document.getElementById("messageDisplay");
          const errorMessage = document.createElement("p");
          errorMessage.style.color = "red";
          errorMessage.textContent = "Failed to send the message. Please try again!";
          messageDisplay.appendChild(errorMessage);
        };
      }
    }

    // Emoji Adding
    function addEmoji(emoji) {
      document.getElementById("chatBox").value += emoji;
    }
  </script>
</body>
</html>
