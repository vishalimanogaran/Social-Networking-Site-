<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- Font Awesome -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f3f8;
            margin: 0;
            padding: 0;
        }

        .dashboard-container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
            padding: 30px;
            background: linear-gradient(145deg, #f3e8f7, #ffffff);
            box-shadow: 10px 10px 20px #d1c7d6, -10px -10px 20px #ffffff;
            border-radius: 20px;
        }

        .logo {
            margin-bottom: 20px;
        }

        .logo img {
            width: 150px;
            height: auto;
            border-radius: 15px;
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.2);
        }

        h1 {
            color: #800080;
            font-size: 36px;
            font-weight: bold;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        h2 {
            color: #800080;
            font-size: 36px;
            font-weight: bold;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .menu {
            list-style-type: none;
            padding: 0;
            margin: 20px 0;
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .menu li {
            transition: transform 0.3s ease;
        }

        .menu li:hover {
            transform: scale(1.1);
        }

        .menu a {
            text-decoration: none;
            color: #ff69b4;
            font-size: 20px;
            font-weight: bold;
            padding: 10px 20px;
            border-radius: 10px;
            background: linear-gradient(145deg, #ffe6f3, #ffffff);
            box-shadow: 5px 5px 15px #d1c7d6, -5px -5px 15px #ffffff;
            transition: color 0.3s, box-shadow 0.3s;
        }

        .menu a:hover {
            color: #ba55d3;
            box-shadow: 10px 10px 25px #d1c7d6, -10px -10px 25px #ffffff;
        }

        .menu a i {
            margin-right: 10px; /* Icon spacing */
        }

        .section {
            margin: 20px 0;
            padding: 20px;
            border-radius: 15px;
            background: linear-gradient(145deg, #ffffff, #f3e8f7);
            box-shadow: 10px 10px 20px #d1c7d6, -10px -10px 20px #ffffff;
        }

        .section h3 {
            color: #6a0dad;
            margin-bottom: 15px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
        }

        .section p,
        .section ul {
            font-size: 18px;
            color: #333;
        }

        .section ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .section ul li {
            margin: 10px 0;
            font-size: 18px;
            color: #333;
        }

        .section ul li i {
            margin-right: 8px;
            color: #ba55d3;
        }

        .logout {
            margin-top: 20px;
        }

        .logout input {
            background: linear-gradient(145deg, #ff69b4, #ba55d3);
            border: none;
            color: white;
            padding: 12px 25px;
            font-size: 18px;
            cursor: pointer;
            border-radius: 10px;
            box-shadow: 5px 5px 15px #d1c7d6, -5px -5px 15px #ffffff;
            transition: background 0.3s, box-shadow 0.3s;
        }

        .logout input:hover {
            background: linear-gradient(145deg, #ba55d3, #800080);
            box-shadow: 8px 8px 20px #d1c7d6, -8px -8px 20px #ffffff;
        }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <!-- Logo Section -->
        <div class="logo">
        </div>
       <center> <h1> Social Networking Site-Admin</h1></center>

        <!-- Welcome Section -->
        <h2>Welcome, <strong><%= request.getAttribute("username") != null ? request.getAttribute("username") : "Guest" %></strong></h2>

        <!-- Admin Actions Section -->
        <div class="section">
            <h3><i class="fas fa-tools"></i> Admin Actions</h3>
            <ul class="menu">
                <li><a href="adminManage_users.jsp"><i class="fas fa-users"></i>Manage Users</a></li>
                <li><a href="adminView_report.jsp"><i class="fas fa-chart-line"></i>View Reports</a></li>
                <li><a href="site_settings.jsp"><i class="fas fa-cogs"></i>Site Settings</a></li>
            </ul>
        </div>

        <!-- Recent Activity Section -->
        <div class="section">
            <h3><i class="fas fa-bell"></i> Recent Activity</h3>
            <p>View recent actions performed by users and administrators. This section provides a quick summary of updates.</p>
            <ul>
                <li><i class="fas fa-user-plus"></i> New user registrations: <strong>5</strong></li>
                <li><i class="fas fa-pencil-alt"></i> Recent posts added: <strong>10</strong></li>
                <li><i class="fas fa-comments"></i> New comments posted: <strong>15</strong></li>
            </ul>
        </div>

        <!-- Quick Links Section -->
        <div class="section">
            <h3><i class="fas fa-link"></i> Quick Links</h3>
            <ul>
                <li><a href="adminViewPost.jsp"><i class="fas fa-eye"></i>View All Posts</a></li>
                <li><a href="adminManageComment.jsp"><i class="fas fa-comments"></i>Manage Comments</a></li>
                <li><a href="adminViewUserActivity.jsp"><i class="fas fa-user-circle"></i>View User Activity</a></li>
            </ul>
        </div>

        <!-- Logout Section -->
        <div class="logout">
            <form action="adminLogout.jsp" method="post">
                <input type="submit" value="Logout">
            </form>
        </div>
    </div>

</body>
</html>
