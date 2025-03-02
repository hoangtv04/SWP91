<%-- 
    Document   : AdminHome
    Created on : Mar 1, 2025, 11:23:49 PM
    Author     : tovie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                width: 80%;
                margin: 0 auto;
            }
            .header, .footer {
                background-color: #f1f1f1;
                padding: 20px;
                text-align: center;
            }
            .nav {
                margin: 20px 0;
                text-align: center;
            }
            .nav a {
                margin: 0 15px;
                text-decoration: none;
                color: #333;
            }
            .nav a:hover {
                text-decoration: underline;
            }
            .content {
                margin: 20px 0;
            }
            .section {
                margin-bottom: 40px;
            }
            .section h2 {
                background-color: #f2f2f2;
                padding: 10px;
                border: 1px solid #ddd;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>Admin Dashboard</h1>
                <p>Welcome, Admin!</p>
            </div>
            <div class="nav">
                <a href="#movies">Manage Movies</a>
                <a href="#showtimes">Manage Showtimes</a>
                <a href="#bookings">Manage Bookings</a>
                <a href="#customers">Manage Customers</a>
            </div>
            <div class="content">
                <div class="section" id="movies">
                    <h2>Manage Movies</h2>
                    <p>Here you can add, edit, and delete movies.</p>
                </div>
                <div class="section" id="showtimes">
                    <h2>Manage Showtimes</h2>
                    <p>Here you can add, edit, and delete showtimes.</p>
                </div>
                <div class="section" id="bookings">
                    <h2>Manage Bookings</h2>
                    <p>Here you can view and manage bookings.</p>
                </div>
                <div class="section" id="customers">
                    <h2>Manage Customers</h2>
                    <p>Here you can view and manage customer information.</p>
                </div>
            </div>
            <div class="footer">
                <p>&copy; 2025 Movie Ticket Booking System</p>
            </div>
        </div>
    </body>
</html>
