<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contact Us</title>
        <link rel="stylesheet" type="text/css" href="css/contact.css">
        <script>
            // Hàm quay lại trang trước đó
            function goBack() {
                window.history.back();
            }
        </script>
    </head>

    <body>
        <header class="header">
            
            <h1>Contact Us</h1>
        </header>

        <nav id="main-nav">
            <a href="movie">Home</a>
            <a href="contact.jsp" class="active">Contact</a>
        </nav>

        <div class="container">
            <div class="contact-details">
                
                <h1>Company Information</h1>
                <div class="contact-info">
                    <p><strong>Company Name:</strong> XYZ Technologies</p>
                    <p><strong>Business Registration Number:</strong> 0101234567</p>
                    <p><strong>First Registration Date:</strong> January 1, 2015</p>
                    <p><strong>Registered at:</strong> Department of Planning and Investment, Ho Chi Minh City</p>
                    <p><strong>Head Office Address:</strong> Floor 2, No. 123, Nguyen Trai Street, Ward 5, District 3, Ho Chi Minh City</p>
                    <p><strong>Hotline:</strong> 1800 123 456 / 0901 234 567</p>
                    <p><strong>Email:</strong> contact@xyztechnologies.vn</p>
                </div>

                <h2>Business Partnership</h2>
                <div class="business-contact">
                    <p><strong>Hotline:</strong> 1800 987 654</p>
                    <p><strong>Email:</strong> partnership@xyzgroup.vn</p><br><br>
            <button class="back-button" onclick="goBack()">Back</button>

                </div>

            </div>

        </div>

        <footer class="footer">

        </footer>
    </body>

</html>