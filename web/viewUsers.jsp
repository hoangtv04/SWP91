<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.Customer" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
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
        .table-container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #2980b9;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
            border-radius: 10px;
            border: 3px solid #2980b9;
        }
        .popup input {
            width: 100%;
            padding: 5px;
            margin: 5px 0;
        }
        .popup .close-btn {
            cursor: pointer;
            background-color: red;
            color: white;
            padding: 5px 10px;
            border: none;
        }
    </style>
    <script>
        function openPopup(id, phone, name, password, email, address) {
            document.getElementById("customerID").value = id;
            document.getElementById("phone").value = phone;
            document.getElementById("name").value = name;
            document.getElementById("password").value = password;
            document.getElementById("email").value = email;
            document.getElementById("address").value = address;
            document.getElementById("popup").style.display = "block";
        }
        function closePopup() {
            document.getElementById("popup").style.display = "none";
        }
    </script>
</head>
<body>
    <div class="header">
        <h1>Admin Dashboard - Manage Users</h1>
        <a href="logout" class="logout-btn">Đăng xuất</a>
    </div>
    
    <div class="navbar">
        <a href="AdminDashboard.jsp">Home</a>
        <a href="user">Manage Users</a>
        <a href="manageMovies.jsp">Manage Movies</a>
        <a href="Showtime">Manage Showtimes</a>
        <a href="manageBookings.jsp">Manage Bookings</a>
        <a href="manageReviews.jsp">Manage Reviews</a>
        <a href="manageVouchers.jsp">Manage Vouchers</a>
    </div>

    <div class="container">
        <div class="table-container">
            <h2 class="text-center" style="display: inline-block;">Danh sách người dùng</h2>
            <button onclick="openAddPopup()" style="float: right; padding: 8px 12px; background-color: #2980b9; color: white; border: none; border-radius: 5px; cursor: pointer;">Add User</button>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Phone</th>
                        <th>Name</th>
                        <th>Password</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                       if (customers != null && !customers.isEmpty()) {
                           for (Customer customer : customers) { %>
                    <tr>
                        <td><%= customer.getCustomerId() %></td>
                        <td><%= customer.getPhone() %></td>
                        <td><%= customer.getCustomerName() %></td>
                        <td><%= customer.getPassword() %></td>
                        <td><%= customer.getEmail() %></td>
                        <td><%= customer.getAddress() %></td>
                        <td>
                            <button onclick="openPopup('<%= customer.getCustomerId() %>', '<%= customer.getPhone() %>', '<%= customer.getCustomerName() %>', '<%= customer.getPassword() %>', '<%= customer.getEmail() %>', '<%= customer.getAddress() %>')">Edit</button>
                            <form id="deleteForm-<%= customer.getCustomerId() %>" action="user" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="customerID" value="<%= customer.getCustomerId() %>">
                                <button type="button" class="delete-btn" onclick="confirmDelete('<%= customer.getCustomerId() %>')">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="7">Không có người dùng nào.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    
    <div id="popup" class="popup">
        <form action="user" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="customerID" name="customerID">
            <input type="text" id="phone" name="phone" placeholder="Phone">
            <input type="text" id="name" name="name" placeholder="Name">
            <input type="text" id="password" name="password" placeholder="Password">
            <input type="text" id="email" name="email" placeholder="Email">
            <input type="text" id="address" name="address" placeholder="Address">
            <button type="submit">Save</button>
            <button type="button" class="close-btn" onclick="closePopup()">Close</button>
        </form>
    </div>
<div id="addPopup" class="popup">
        <form action="user" method="post">
            <input type="hidden" name="action" value="add">
            <input type="text" name="phone" placeholder="Phone" required>
            <input type="text" name="name" placeholder="Name" required>
            <input type="text" name="password" placeholder="Password" required>
            <input type="text" name="email" placeholder="Email" required>
            <input type="text" name="address" placeholder="Address" required>
            <button type="submit">Add</button>
            <button type="button" class="close-btn" onclick="closeAddPopup()">Close</button>
        </form>
    </div>
    
    <script>
        function openAddPopup() {
            document.getElementById("addPopup").style.display = "block";
        }
        function closeAddPopup() {
            document.getElementById("addPopup").style.display = "none";
        }
    </script>
    <script>
        function confirmDelete(customerID) {
            if (confirm('Are you sure you want to delete this user?')) {
                document.getElementById('deleteForm-' + customerID).submit();
            }
        }
    </script>
    
</body>
</html>
