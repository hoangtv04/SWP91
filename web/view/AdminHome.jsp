<%-- 
    Document   : AdminDashboard
    Created on : Feb 11, 2025, 1:38:24 AM
    Author     : tovie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Admin"%>
<%
    Admin admin = (Admin) request.getAttribute("admin");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #2980b9;
            color: white;
            padding: 10px 0;
            text-align: center;
            position: relative;
        }
        .logout-btn {
            position: absolute;
            top: 10px;
            right: 20px;
            background-color: #333;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }
        .logout-btn:hover {
            background-color: #ddd;
            color: black;
        }
        .navbar {
            overflow: hidden;
            background-color: #333;
            display: flex;
            justify-content: center;
        }
        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .container {
            padding: 20px;
        }
        .welcome {
            margin-bottom: 20px;
        }
        .admin-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .admin-actions a {
            flex: 1 1 calc(33.333% - 20px);
            background-color: #2980b9;
            color: white;
            padding: 20px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .admin-actions a:hover {
            background-color: #1f618d;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Admin Dashboard</h1>
        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
    </div>
    <div class="navbar">
        <a href="adminDashboard.jsp">Home</a>
        <a href="user">Manage Users</a>
        <a href="manageMovies.jsp">Manage Movies</a>
        <a href="Showtime">Manage Showtimes</a>
        <a href="manageBookings.jsp">Manage Bookings</a>
        <a href="manageReviews.jsp">Manage Reviews</a>
        <a href="manageVouchers.jsp">Manage Vouchers</a>
    </div>
    <div class="container">
        <div class="admin-actions">
            <a href="user">Manage Users</a>
            <a href="manageMovies.jsp">Manage Movies</a>
            <a href="Showtime">Manage Showtimes</a>
            <a href="manageBookings.jsp">Manage Bookings</a>
            <a href="manageReviews.jsp">Manage Reviews</a>
            <a href="manageVouchers.jsp">Manage Vouchers</a>
        </div>
    </div>
</body>
</html>