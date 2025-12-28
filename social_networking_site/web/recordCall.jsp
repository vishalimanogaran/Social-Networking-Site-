<%-- 
    Document   : recordCall
    Created on : 14-Jan-2025, 5:56:40 pm
    Author     : sarav
--%>

<%@ page import="java.sql.*"%>
<%
    // Get action and status from the request
    String action = request.getParameter("action");
    String status = request.getParameter("status");

    // Database connection
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_db", "your_username", "your_password");

        // If action is to record, save the status (true or false)
        if ("record".equals(action)) {
            String sql = "INSERT INTO call_recordings (call_status, timestamp) VALUES (?, NOW())";
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);  // True for recording, false for stopped recording

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                response.getWriter().write("Recording status saved.");
            } else {
                response.getWriter().write("Error saving recording status.");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.getWriter().write("Error: " + e.getMessage());
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

