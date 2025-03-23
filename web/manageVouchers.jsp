<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.Voucher" %>
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
        <title>Manage Vouchers</title>
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
            .header p {
                text-align: left;
                margin-left: 20px;
            }
        </style>
        <script>
            function openAddPopup() {
                document.getElementById("addPopup").style.display = "block";
            }
            function closeAddPopup() {
                document.getElementById("addPopup").style.display = "none";
            }
            function openEditPopup(id, code, discount, expiry, admin) {
                document.getElementById("voucherID").value = id;
                document.getElementById("code").value = code;
                document.getElementById("discount").value = discount;
                document.getElementById("expiry").value = expiry;
                document.getElementById("admin").value = admin;
                document.getElementById("editPopup").style.display = "block";
            }
            function closeEditPopup() {
                document.getElementById("editPopup").style.display = "none";
            }
        </script>
    </head>
    <body>

        <div class="header">
            <h1>Manage Vouchers</h1>
            <p>Xin chào, <%= admin.getName() %>!</p>
            <a href="logout" class="logout-btn">Đăng xuất</a>

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
            <div class="table-container">
                <h2>Voucher List</h2>
                <button onclick="openAddPopup()">Add Voucher</button>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Code</th>
                            <th>Discount</th>
                            <th>Expiry Date</th>
                            <th>Admin ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Voucher> vouchers = (List<Voucher>) request.getAttribute("vouchers");
                           if (vouchers != null && !vouchers.isEmpty()) {
                               for (Voucher v : vouchers) { %>
                        <tr>
                            <td><%= v.getVoucherID() %></td>
                            <td><%= v.getCode() %></td>
                            <td><%= v.getDiscountAmount() %></td>
                            <td><%= v.getExpiryDate() %></td>
                            <td><%= v.getAdminID() %></td>
                            <td>
                                <button onclick="openEditPopup('<%= v.getVoucherID() %>', '<%= v.getCode() %>', '<%= v.getDiscountAmount() %>', '<%= v.getExpiryDate() %>', '<%= v.getAdminID() %>')">Edit</button>
                                <form action="voucher" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="voucherID" value="<%= v.getVoucherID() %>">
                                    <button type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="6">No vouchers available.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="addPopup" class="popup">
            <form action="voucher" method="post">
                <input type="hidden" name="action" value="add">
                <input type="text" name="code" placeholder="Code" required>
                <input type="number" name="discount" placeholder="Discount Amount" required>
                <input type="date" name="expiry" required>
                <input type="hidden" name="admin" value="<%= admin.getAdminId() %>">
                <button type="submit">Add</button>
                <button type="button" onclick="closeAddPopup()">Close</button>
            </form>
        </div>

        <div id="editPopup" class="popup">
            <form action="voucher" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="voucherID" name="voucherID">
                <input type="text" id="code" name="code" placeholder="Code" required>
                <input type="number" id="discount" name="discount" placeholder="Discount Amount" required>
                <input type="date" id="expiry" name="expiry" required>
                <input type="hidden" id="admin" name="admin" value="<%= admin.getAdminId() %>">
                <button type="submit">Save</button>
                <button type="button" onclick="closeEditPopup()">Close</button>
            </form>
        </div>
    </body>
</html>
