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
        
    </head>
    <body>
        <header class="header">
            <h1>Confirm Booking</h1>
        </header>

        <nav id="main-nav">
            <a href="index.jsp">Home</a>
            <a href="movies.jsp">Movies</a>
            <a href="contact.jsp">Contact</a>
        </nav>

        <div class="container">
            <div class="content">
                <div class="qr-code">
                    <h3>Scan to Pay</h3>
                    <img src="<%= qrCodeUrl %>" alt="QR Code for Payment">
                </div>
                
                <h2>Movie: <%= movieName %></h2>
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
                
                <p><strong>Total Price:</strong> $<%= totalPrice %></p>
                
                <div class="confirm-booking-button-container">
                    <button type="submit" class="confirm-booking-button">Done</button>

                </div>
            </div>
        </div>
        <script>
            document.querySelector('.confirm-booking-button').addEventListener('click', function(event) {
                event.preventDefault();
                alert('Booking Success');
                window.location.href = 'movie';
            });
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