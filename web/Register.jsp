<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <style>
            /* CSS tương tự Login.jsp */
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

            .register-container {
                width: 100%;
                max-width: 400px;
                background: rgba(255, 255, 255, 0.95);
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
            }

            .register-container h1 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
                font-size: 28px;
            }

            .register-container label {
                display: block;
                margin-bottom: 10px;
                font-weight: bold;
                color: #555;
            }

            .register-container input[type="text"],
            .register-container input[type="password"],
            .register-container input[type="email"] {
                width: 100%;
                padding: 12px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
                box-sizing: border-box;
                font-size: 16px;
            }

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

            .error-message {
                color: red;
                text-align: center;
                margin-top: 15px;
                margin-bottom: 15px;
                font-size: 16px;
                font-weight: bold;
            }
        </style>
        <script>
            function validateForm() {
                // Clear previous error messages
                const formMessage = document.getElementById("form-message");
                formMessage.innerHTML = "";

                const phone = document.getElementById("phone").value;
                const email = document.getElementById("email").value;
                const password = document.getElementById("password").value;

                let isValid = true;
                let errorMessages = "";

                // Validate phone number
                const phoneRegex = /^[0-9]{10}$/;
                if (!phoneRegex.test(phone)) {
                    errorMessages += "Phone number must be 10 digits.<br>";
                    isValid = false;
                }

                // Validate email domain
                const emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
                if (!emailRegex.test(email)) {
                    errorMessages += "Email must end with @gmail.com.<br>";
                    isValid = false;
                }

                // Validate password length
                if (password.length > 12) {
                    errorMessages += "Password must not exceed 12 characters.<br>";
                    isValid = false;
                }

                // Display error messages or success message
                if (isValid) {
                    const successMessage = "Registration successful!";
                    formMessage.innerHTML = successMessage;
                    formMessage.style.color = "green";

                    // Store the success message in localStorage
                    localStorage.setItem("registrationMessage", successMessage);
                } else {
                    formMessage.innerHTML = errorMessages;
                    formMessage.style.color = "red";

                    // Clear any existing success message in localStorage
                    localStorage.removeItem("registrationMessage");
                }

                return isValid;
            }

            // Load the success message from localStorage on page load
            window.onload = function () {
                const formMessage = document.getElementById("form-message");
                const savedMessage = localStorage.getItem("registrationMessage");
                if (savedMessage) {
                    formMessage.innerHTML = savedMessage;
                    formMessage.style.color = "green";
                }
            };

            function clearRegistrationMessage() {
                localStorage.removeItem("registrationMessage");
            }
        </script>
    </head>
    <body>
        <div class="register-container">
            <h1>Register</h1>
            <form action="register" method="post" onsubmit="return validateForm();">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" required>

                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>

                <!-- General message container for all validation errors -->
                <div id="form-message" class="error-message"></div>

                <input type="submit" value="Register">
            </form>

            <!-- Add Back to Login button -->
            <div style="text-align: center; margin-top: 20px;">
                <a href="login" onclick="clearRegistrationMessage()" style="text-decoration: none; color: #007bff; font-size: 16px;">Back to Login</a>
            </div>
        </div>
    </body>
</html>