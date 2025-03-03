<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reset Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .reset-password-container {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            box-sizing: border-box;
        }
        .reset-password-container h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .reset-password-container label {
            display: block;
            margin-bottom: 5px;
        }
        .reset-password-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .reset-password-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-sizing: border-box;
        }
        .reset-password-container input[type="submit"]:hover {
            background: #0056b3;
        }
        .reset-password-container button {
            width: 100%;
            padding: 10px;
            background: #6c757d;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-sizing: border-box;
            margin-top: 10px;
        }
        .reset-password-container button:hover {
            background: #5a6268;
        }
        .success-message {
            color: green;
            text-align: center;
        }
        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="reset-password-container">
        <h1>Reset Password</h1>
        <form action="resetPassword" method="post">
            <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
            <label for="new-password">New Password:</label>
            <input type="password" id="new-password" name="newPassword" required>
            <input type="submit" value="Reset Password">
        </form>
        <% String message = (String) request.getAttribute("message"); if (message != null) { %>
            <p class="<%= request.getAttribute("messageType") %>"><%= message %></p>
        <% } %>
        <button onclick="window.location.href='Login.jsp'">Back to Login</button>
    </div>
</body>
</html>
