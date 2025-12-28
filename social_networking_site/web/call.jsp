<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<html>
<head>
    <title>Messaging & Video Call</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffe6ff; /* Light pink */
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #990099; /* Purple */
        }

        .section {
            margin: 20px 0;
            padding: 15px;
            border: 2px solid #ff66cc; /* Pink border */
            border-radius: 10px;
            background-color: #ffe6ff;
        }

        .section h3 {
            color: #990099;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .chat-container {
            margin: 20px 0;
            padding: 15px;
            background-color: #ffccff;
            border-radius: 10px;
            border: 2px solid #ff66cc;
        }

        .chat-box {
            max-height: 300px;
            overflow-y: auto;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 10px;
            background-color: #ffffff;
            border: 1px solid #ff66cc;
        }

        .message {
            margin: 5px 0;
            padding: 8px 12px;
            border-radius: 10px;
        }

        .message.sent {
            background-color: #990099;
            color: white;
            text-align: right;
        }

        .message.received {
            background-color: #ffe6ff;
            color: #990099;
        }

        textarea {
            width: 100%;
            height: 50px;
            padding: 10px;
            border: 2px solid #ff66cc;
            border-radius: 10px;
            margin-bottom: 10px;
        }

        button {
            padding: 10px 20px;
            cursor: pointer;
            background-color: #990099;
            color: white;
            border: none;
            border-radius: 5px;
        }

        .video-container {
            margin-top: 20px;
            text-align: center;
        }

        video {
            width: 45%;
            border-radius: 10px;
            border: 2px solid #ff66cc;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Messaging & Video Call</h2>

        <!-- Call Section -->
        <div class="section">
            <h3>📞 Video Call</h3>
            <div class="action-buttons">
                <button id="startVideoCallBtn" onclick="startVideoCall()">🎥 Start Video Call</button>
                <button id="endVideoCallBtn" onclick="endVideoCall()" disabled>⛔ End Call</button>
            </div>
            <div class="video-container">
                <video id="localVideo" autoplay muted></video>
                <video id="remoteVideo" autoplay></video>
            </div>
        </div>

        <!-- Chat Section -->
        <div class="section">
            <h3>💬 Chat</h3>
            <div class="chat-container">
                <div class="chat-box" id="chatBox">
                    <% 
                        // Fetch messages from database
                        Connection conn = null;
                        Statement stmt = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chat_db", "root", "password");
                            stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM messages ORDER BY timestamp ASC");

                            while (rs.next()) {
                                String sender = rs.getString("sender");
                                String messageType = rs.getString("message_type");
                                String message = rs.getString("message");
                    %>
                    <div class="message <%= sender.equals("You") ? "sent" : "received" %>">
                        <%= messageType.equals("emoji") ? "&#x" + message + ";" : message %>
                    </div>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </div>
                <textarea id="messageInput" placeholder="Type a message..."></textarea>
                <button onclick="sendMessage()">Send</button>
            </div>
        </div>
    </div>

    <script>
        // Video Call Logic
        let localStream, peerConnection;
        const config = {
            iceServers: [{ urls: "stun:stun.l.google.com:19302" }]
        };

        async function startVideoCall() {
            try {
                localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });

                const localVideo = document.getElementById("localVideo");
                localVideo.srcObject = localStream;

                peerConnection = new RTCPeerConnection(config);
                localStream.getTracks().forEach((track) => peerConnection.addTrack(track, localStream));

                document.getElementById("startVideoCallBtn").disabled = true;
                document.getElementById("endVideoCallBtn").disabled = false;

                alert("Video call started!");
            } catch (error) {
                console.error("Error starting video call:", error);
                alert("Cannot access camera or microphone.");
            }
        }

        function endVideoCall() {
            if (peerConnection) peerConnection.close();
            if (localStream) localStream.getTracks().forEach((track) => track.stop());
            
            document.getElementById("localVideo").srcObject = null;
            document.getElementById("remoteVideo").srcObject = null;

            document.getElementById("startVideoCallBtn").disabled = false;
            document.getElementById("endVideoCallBtn").disabled = true;

            alert("Call ended!");
        }

        // Chat Logic
        function sendMessage() {
            const message = document.getElementById("messageInput").value.trim();
            if (!message) return alert("Message cannot be empty.");

            const xhr = new XMLHttpRequest();
            xhr.open("POST", "sendMessage.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    location.reload();
                }
            };
            xhr.send("message=" + encodeURIComponent(message) + "&message_type=text");
        }
    </script>
</body>
</html>
