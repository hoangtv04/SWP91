<%-- Document : Login Created on : Mar 1, 2025, 11:11:46 PM Author : tovie --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('images background//quaybanve.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
        }

        .login-container,
        .register-container {
            background: rgba(255, 255, 255, 0.9);
            /* Semi-transparent white background */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            box-sizing: border-box;
            display: none;
            /* Initially hidden */
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .login-container h1,
        .register-container h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .login-container label,
        .register-container label {
            display: block;
            margin-bottom: 5px;
        }

        .login-container input[type="text"],
        .login-container input[type="password"],
        .register-container input[type="text"],
        .register-container input[type="password"],
        .register-container input[type="email"],
        .register-container input[type="tel"],
        .register-container input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .login-container input[type="submit"],
        .register-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-sizing: border-box;
        }

        .login-container input[type="submit"]:hover,
        .register-container input[type="submit"]:hover {
            background: #0056b3;
        }

        .error-message {
            color: red;
            text-align: center;
        }

        .success-message {
            color: green;
            text-align: center;
        }

        .button-container {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .button-container button {
            background: rgba(0, 0, 0, 0.5);
            /* Match background color */
            color: #fff;
            /* Stand out text color */
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            margin-left: 10px;
        }

        .button-container button:hover {
            background: rgba(0, 0, 0, 0.7);
            /* Darker on hover */
        }

        .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            background: transparent;
            border: none;
            font-size: 20px;
            cursor: pointer;
        }

        .close-button:hover {
            color: #ff0000;
        }

        .forgot-password {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function showForm(formType) {
            var loginContainer = document.querySelector('.login-container');
            var registerContainer = document.querySelector('.register-container');
            var buttonContainer = document.querySelector('.button-container');

            if (formType === 'login') {
                loginContainer.style.display = 'block';
                registerContainer.style.display = 'none';
            } else if (formType === 'register') {
                loginContainer.style.display = 'none';
                registerContainer.style.display = 'block';
            }

            buttonContainer.style.display = 'none';
        }

        function hideForm() {
            var loginContainer = document.querySelector('.login-container');
            var registerContainer = document.querySelector('.register-container');
            var buttonContainer = document.querySelector('.button-container');

            loginContainer.style.display = 'none';
            registerContainer.style.display = 'none';
            buttonContainer.style.display = 'block';
        }

        window.onload = function () {
            var errorMessage = '<%= session.getAttribute("loginErrorMessage") %>';
            var successMessage = '<%= request.getAttribute("successMessage") %>';
            var showLoginForm = '<%= request.getAttribute("showLoginForm") %>';
            if (errorMessage) {
                showForm('login');
                session.removeAttribute("loginErrorMessage");
            } else if (successMessage) {
                showForm('login');
            } else if (showLoginForm) {
                showForm('login');
            }
        }
    </script>
</head>

<body>
    <div class="button-container">
        <button class="login-button" onclick="showForm('login')">Login</button>
        <button class="register-button" onclick="showForm('register')">Register</button>
    </div>
    <div class="login-container">
        <button class="close-button" onclick="hideForm()">×</button>
        <h1>Login</h1>
        <form action="login" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <input type="submit" value="Login">
        </form>
        <a href="#" class="forgot-password">Forgot Password?</a>
        <% String loginErrorMessage = (String) session.getAttribute("loginErrorMessage"); if (loginErrorMessage != null) { %>
            <p class="error-message">
                <%= loginErrorMessage %>
            </p>
            <%
                session.removeAttribute("loginErrorMessage");
            %>
        <% } %>
        <% String loginSuccessMessage = (String) request.getAttribute("successMessage"); if (loginSuccessMessage != null) { %>
            <p class="success-message"><%= loginSuccessMessage %></p>
        <% } %>
    </div>
    <div class="register-container">
        <button class="close-button" onclick="hideForm()">×</button>
        <h1>Register</h1>
        <form action="register" method="post">
            <label for="reg-username">Username:</label>
            <input type="text" id="reg-username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required>

            <label for="reg-password">Password:</label>
            <input type="password" id="reg-password" name="password" required>

            <label for="reg-email">Email:</label>
            <input type="email" id="reg-email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>

            <label for="reg-phone">Phone Number:</label>
            <input type="tel" id="reg-phone" name="phone" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>" required maxlength="15">

            <label for="reg-address">Address:</label>
            <input type="text" id="reg-address" name="address" value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>" required maxlength="255">

            <input type="submit" value="Register">
        </form>
        <% String registerErrorMessage = (String) request.getAttribute("registerErrorMessage"); if (registerErrorMessage != null) { %>
            <p class="error-message"><%= registerErrorMessage %></p>
        <% } %>
    </div>
</body>

</html>