<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Seat" %>

<%
    // Retrieve the selected seats and other attributes from the request
    List<Seat> selectedSeats = (List<Seat>) request.getAttribute("selectedSeats");
    String movieName = (String) request.getAttribute("movieName");
    String cinemaName = (String) request.getAttribute("cinemaName");
    String screenName = (String) request.getAttribute("screenName");

    // Calculate the total price
    double totalPrice = 0;
    if (selectedSeats != null) {
        for (Seat seat : selectedSeats) {
            totalPrice += seat.getPrice();
        }
    }

    // Generate QR code URL (for demonstration purposes, using a placeholder URL)
    String qrCodeUrl = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=Total%20Price:%20" + totalPrice;
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/confirmBooking.css">
        <title>Confirm Booking</title>
        <script>
            window.addEventListener('scroll', function () {
                var nav = document.getElementById('main-nav');
                if (window.scrollY > 0) {
                    nav.classList.add('sticky');
                } else {
                    nav.classList.remove('sticky');
                }
            });
        </script>
    </head>
    <body>
        <header class="header">
            <h1>Confirm Booking</h1>
        </header>

        <nav id="main-nav">
            <a href="index.jsp">Home</a>
            <a href="movie">Movies</a>
            <a href="contact.jsp">Contact</a>
        </nav>

        <div class="container">

            <div class="title-movie"> 
                <h2><%= movieName %></h2>
            </div>

            <div class="qr-code">
                <h3>Scan to Pay</h3>
                <img src="<%= qrCodeUrl %>" alt="QR Code for Payment">
            </div>

            <p><strong>Cinema:</strong> <%= cinemaName %></p>
            <p><strong>Screen:</strong> <%= screenName %></p>
            <p><strong>Seats:</strong>
                <%
                    if (selectedSeats != null) {
                        for (Seat seat : selectedSeats) {
                %>
            <p><%= seat.getSeatNumber() %> : <%= seat.getSeatType() %> : $<%= seat.getPrice() %></p>
            <%
                    }
                }
            %>
            <br>
            <p><strong>Total Price:</strong> $<%= totalPrice %></p>

            <div class="confirm-booking-button-container">

                <button type="submit" class="confirm-booking-button" onclick="confirmBooking(event)">Done</button>
            </div>

        </div>

        <script>
            function confirmBooking(event) {
                event.preventDefault(); // Ngăn chặn hành động mặc định của form
                alert("Booking Success");
                window.location.href = "http://localhost:9999/SWP391_SP25/movie"; // Redirect to the movie selection page
            }
        </script>

        <footer class="footer">
            <div class="contact-container">
                <div class="contact-info">
                    <h2>LIÊN HỆ</h2>
                    <p>
                        CÔNG TY CỔ PHẦN XYZ TECHNOLOGIES<br><br>
                        Giấy chứng nhận ĐKKD số: 0101234567 - Đăng ký lần đầu ngày 01/01/2015 tại Sở Kế hoạch và Đầu
                        tư Thành phố Hồ Chí Minh<br><br>
                        Địa chỉ trụ sở: Tầng 2, số 123, đường Nguyễn Trãi, phường 5, quận 3, thành phố Hồ Chí
                        Minh<br><br>
                        Hotline: 1800 123 456 / 0901 234 567<br><br>
                        Email: contact@xyztechnologies.vn
                    </p>
                </div>
                <div class="business-contact">
                    <h2>HỢP TÁC KINH DOANH:</h2>
                    <p>
                        Hotline: 1800 987 654<br><br>
                        Email: partnership@xyzgroup.vn
                    </p>
                </div>
            </div>
        </footer>
    </body>
</html>