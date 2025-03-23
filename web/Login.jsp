<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        /* Đặt ảnh nền */
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
        }

        /* Container chính */
        .login-container {
            width: 100%;
            max-width: 400px; /* Tăng chiều rộng tối đa */
            background: rgba(255, 255, 255, 0.95); /* Tăng độ mờ để nổi bật hơn */
            padding: 30px; /* Tăng padding để tạo không gian */
            border-radius: 12px; /* Tăng độ bo tròn */
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3); /* Tăng độ đổ bóng */
        }

        /* Tiêu đề */
        .login-container h1 {
            text-align: center;
            margin-bottom: 20px; /* Tăng khoảng cách dưới */
            color: #333;
            font-size: 28px; /* Tăng kích thước font */
        }

        /* Nhãn và input */
        .login-container label {
            display: block;
            margin-bottom: 10px; /* Tăng khoảng cách dưới */
            font-weight: bold;
            color: #555;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 12px; /* Tăng padding */
            margin-bottom: 20px; /* Tăng khoảng cách dưới */
            border: 1px solid #ccc;
            border-radius: 6px; /* Tăng độ bo tròn */
            box-sizing: border-box;
            font-size: 16px; /* Tăng kích thước font */
        }

        /* Nút đăng nhập */
        .login-container input[type="submit"] {
            width: 100%;
            padding: 12px; /* Tăng padding */
            background-color: #007bff;
            border: none;
            border-radius: 6px; /* Tăng độ bo tròn */
            color: white;
            font-size: 18px; /* Tăng kích thước font */
            cursor: pointer;
            transition: background-color 0.3s ease; /* Thêm hiệu ứng hover */
        }

        .login-container input[type="submit"]:hover {
            background-color: #0056b3;
        }

       
        .login-container .forgot-password {
            display: block;
            text-align: center;
            margin-top: 10px; 
            color: #007bff;
            text-decoration: none;
            font-size: 18px;
        }

        .login-container .forgot-password:hover {
            text-decoration: underline;
        }

        
        .login-container .register-link {
            text-align: center;
            margin-top: 15px;
            font-size: 20px;
            color: #555;
        }

        .login-container .register-link a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .login-container .register-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 15px;
            margin-bottom: 15px;
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form action="login" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <input type="submit" value="Login">
        </form>
         <% 
            HttpSession sessions = request.getSession(false);
            if (sessions != null && sessions.getAttribute("loginErrorMessage") != null) { 
        %>
            <div class="error-message">
                <%= session.getAttribute("loginErrorMessage") %>
            </div>
            <% session.removeAttribute("loginErrorMessage"); %>
        <% } %>
        <a href="forgotpassword" class="forgot-password">Forgot Password?</a>
        <div class="register-link">
            Don't have an account? <a href="register">Register</a>
        </div>
    </div>
</body>
</html>