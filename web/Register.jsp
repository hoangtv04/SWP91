<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
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
        .register-container {
            width: 100%;
            max-width: 400px;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        /* Tiêu đề */
        .register-container h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
            font-size: 28px;
        }

        /* Nhãn và input */
        .register-container label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #555;
        }

        .register-container input[type="text"],
        .register-container input[type="password"],
        .register-container input[type="email"],
        .register-container input[type="tel"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 16px;
        }

        /* Nút đăng ký */
        .register-container input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .register-container input[type="submit"]:hover {
            background-color: #0056b3;
        }

        /* Nút quay lại */
        .register-container .back-to-login {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #007bff;
            text-decoration: none;
            font-size: 16px;
        }

        .register-container .back-to-login:hover {
            text-decoration: underline;
        }

        /* Thông báo */
        .success-message {
            text-align: center;
            color: green;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .error-message {
            text-align: center;
            color: red;
            font-size: 16px;
            margin-bottom: 15px;
        }
    </style>
    <script>
        function validateForm(event) {
            event.preventDefault();

            const password = document.getElementById('password').value;
            const email = document.getElementById('email').value;
            const phone = document.getElementById('phone').value;
            const address = document.getElementById('address').value;
            const successMessage = document.getElementById('success-message');
            const errorMessage = document.getElementById('error-message');

            
            successMessage.textContent = '';
            errorMessage.textContent = '';

            
            if (password.length > 12) {
                errorMessage.textContent = 'Password cannot exceed 12 characters.';
                return false;
            }

            
            const emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
            if (!emailRegex.test(email)) {
                errorMessage.textContent = 'Email must end with @gmail.com';
                return false;
            }

            
            const phoneRegex = /^[0-9]{10}$/;
            if (!phoneRegex.test(phone)) {
                errorMessage.textContent = 'Phone number must be 10 digits.';
                return false;
            }

            
            if (address.trim() === '') {
                errorMessage.textContent = 'Address cannot be left blank.';
                return false;
            }

            
            successMessage.textContent = 'Registration successful!';
            return true;
        }
    </script>
</head>
<body>
    <div class="register-container">
        <h1>Register</h1>
        <form action="RegisterServlet" method="post" onsubmit="return validateForm(event)">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">Phone Number:</label>
            <input type="tel" id="phone" name="phone" required>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>

            <div id="success-message" class="success-message">
                <%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : "" %>
            </div>
            <div id="error-message" class="error-message">
                <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
            </div>

            <input type="submit" value="Register">
        </form>
        <a href="Login.jsp" class="back-to-login">Back to Login</a>
    </div>
</body>
</html>