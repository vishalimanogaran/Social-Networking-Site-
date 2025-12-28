<%-- 
    Document   : adminLogout
    Created on : 15-Jan-2025, 4:38:10 pm
    Author     : sarav
--%>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>
</head>
<body>
    <%
        // Here, you just need to redirect the user to the login page.
        // No session invalidation or cookie deletion needed.
        response.sendRedirect("adminLogin.jsp");
    %>
</body>
</html>


