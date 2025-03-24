<%-- 
    Document   : AdminDashboard
    Created on : Feb 11, 2025, 1:38:24 AM
    Author     : tovie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Admin"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
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
            .header p {
                text-align: left;
                margin-left: 20px;
            }

        </style>
    </head>
    <body>
        <div class="header">
            <h1>Admin Dashboard</h1>
            <p>Xin chào, <%= admin.getName() %>!</p>
            <a href="logout" class="logout-btn">đăng xuất</a>
        </div>
        <div class="navbar">
            <a href="AdminDashboard">Home</a>
            <a href="user">Manage Users</a>
            <a href="Movies">Manage Movies</a>
            <a href="Showtime">Manage Showtimes</a>
            <a href="manageBookings.jsp">Manage Bookings</a>
            <a href="reviews">Manage Reviews</a>
            <a href="voucher">Manage Vouchers</a>
        </div>
        <div class="container">
            <div class="summary">
                <h2>Summary</h2>
                <ul>
                    <li>Total Users: <%= request.getAttribute("totalUsers") %></li>
                    <li>Total Movies: <%= request.getAttribute("totalMovies") %></li>
                    <li>Total Showtimes: <%= request.getAttribute("totalShowtimes") %></li>
                    <li>Total Bookings: <%= request.getAttribute("totalBookings") %></li>
                    <li>Total Reviews: <%= request.getAttribute("totalReviews") %></li>
                    <li>Total Vouchers: <%= request.getAttribute("totalVouchers") %></li>
                </ul>
            </div>
            <div class="admin-actions">
                <a href="user">Manage Users</a>
                <a href="Movies">Manage Movies</a>
                <a href="Showtime">Manage Showtimes</a>
                <a href="manageBookings.jsp">Manage Bookings</a>
                <a href="reviews">Manage Reviews</a>
                <a href="voucher">Manage Vouchers</a>
            </div>
        </div>
    </body>
</html>
