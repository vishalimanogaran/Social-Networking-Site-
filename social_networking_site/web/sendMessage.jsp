<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<html>
<head>
    <title>Audio & Video Call with Chat</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffe6ff; /* Light pink */
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
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
        <h2>Audio & Video Call with Chat</h2>

        <!-- Normal Call Section -->
        <div class="section">
            <h3>📞 Normal Call</h3>
            <div class="action-buttons">
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="start">
                    <input type="hidden" name="callType" value="audio">
                    <button type="submit">🎙️ Start Call</button>
                </form>
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="mute">
                    <button type="submit">🔇 Mute</button>
                </form>
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="hold">
                    <button type="submit">⏸ Hold</button>
                </form>
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="keypad">
                    <button type="submit">🔢 Keypad</button>
                </form>
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="addCall">
                    <button type="submit">➕ Add Call</button>
                </form>
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="end">
                    <button type="submit">⛔ End Call</button>
                </form>
            </div>
        </div>

        <!-- Video Call Section -->
        <div class="section">
            <h3>🎥 Video Call</h3>
            <div class="action-buttons">
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="start">
                    <input type="hidden" name="callType" value="video">
                    <button type="submit">🎥 Start Video Call</button>
                </form>
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="pause">
                    <button type="submit">⏸ Pause Video</button>
                </form>
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="mute">
                    <button type="submit">🔇 Mute Video</button>
                </form>
                <form method="post" action="update_call.jsp">
                    <input type="hidden" name="action" value="end">
                    <button type="submit">⛔ End Video Call</button>
                </form>
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
                <div class="chat-box">
                    <% 
                        Connection conn = null;
                        Statement stmt = null;
                        try {
                            Class.forName("com.mysql.dbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "root", "password");
                            stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM messages ORDER BY timestamp ASC");

                            while (rs.next()) {
                                String sender = rs.getString("sender");
                                String message = rs.getString("message");
                    %>
                    <div class="message <%= sender.equals("You") ? "sent" : "received" %>">
                        <%= sender %>: <%= message %>
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
                <form method="post" action="send_message.jsp">
                    <textarea name="message" placeholder="Type a message..." required></textarea>
                    <button type="submit">Send</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
