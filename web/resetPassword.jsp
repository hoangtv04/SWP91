<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reset Password</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: url('images background/quaybanve.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .reset-password-container {
            background: rgba(255, 255, 255, 0.9); /* Add transparency */
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
        .reset-password-container input[type="password"],
        .reset-password-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .reset-password-container input[type="submit"] {
            background: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
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
    <script>
function validatePasswords(event) {
            const newPassword = document.getElementById('new-password').value;
            const confirmNewPassword = document.getElementById('confirm-new-password').value;
            const errorMessage = document.getElementById('error-message');

            if (newPassword !== confirmNewPassword) {
                event.preventDefault();
                errorMessage.textContent = 'Passwords do not match. Please try again.';
                return false;
            }

            errorMessage.textContent = '';
            return true;
        }
    </script>
</head>
<body>
    <div class="reset-password-container">
        <h1>Reset Password</h1>
      <form action="resetPassword" method="post" onsubmit="return validatePasswords(event)">
            <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
            
            <label for="new-password">New Password:</label>
            <input type="password" id="new-password" name="newPassword" required>
            <label for="confirm-new-password">Confirm New Password:</label>
            <input type="password" id="confirm-new-password" name="confirmNewPassword" required>
            
            <div id="error-message" class="error-message"></div>
            <input type="submit" value="Reset Password">
        </form>
        <% String message = (String) request.getAttribute("message"); if (message != null) { %>
            <p class="<%= request.getAttribute("messageType") %>"><%= message %></p>
        <% } %>
        <button onclick="window.location.href='login'">Back to Login</button>
    </div>
</body>
</html>
