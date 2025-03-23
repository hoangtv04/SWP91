<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Showtime" %>
<%@ page import="model.Cinema" %>
<%@ page import="model.Screen" %>

<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="jakarta.servlet.RequestDispatcher" %>

<%
    // Retrieve the list of showtimes, cinemas, screens, and seats from the request
    List<Showtime> showtimes = (List<Showtime>) request.getAttribute("showtimes");
    List<Cinema> cinemas = (List<Cinema>) request.getAttribute("cinemas");
    List<Screen> screens = (List<Screen>) request.getAttribute("screens");
    
    String movieTitle = (String) request.getAttribute("movieTitle");
    int movieId = Integer.parseInt(request.getParameter("movieId"));
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/selectShowtime.css">
        <title>Select Showtime</title>
        <script>
            window.addEventListener('scroll', function () {
                var nav = document.getElementById('main-nav');
                if (window.scrollY > 0) {
                    nav.classList.add('sticky');
                } else {
                    nav.classList.remove('sticky');
                }
            });

            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('cinema').addEventListener('change', function () {
                    fetchScreens();
                    document.getElementById('screen').disabled = false;
                    document.getElementById('showtime').disabled = true;
                    document.getElementById('seat').disabled = true;
                    document.getElementById('screen').innerHTML = '<option value="">--Select Screen--</option>';
                    document.getElementById('showtime').innerHTML = '<option value="">--Select Start Time--</option>';
                    document.getElementById('endtime').value = '';

                });

                document.getElementById('screen').addEventListener('change', function () {
                    fetchShowtimes();
                    document.getElementById('showtime').disabled = false;
                    document.getElementById('seat').disabled = true;
                    document.getElementById('showtime').innerHTML = '<option value="">--Select Start Time--</option>';
                    document.getElementById('endtime').value = '';

                });

                document.getElementById('showtime').addEventListener('change', function () {
                    var selectedOption = this.options[this.selectedIndex];
                    var endTime = selectedOption.getAttribute('data-endtime');
                    document.getElementById('endtime').value = endTime;
                    document.getElementById('seat').disabled = false;
                });
            });

            function fetchScreens() {
                var cinemaId = document.getElementById('cinema').value;
                var movieId = '<%= movieId %>';
                if (cinemaId) {
                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', 'selectShowtime', true);
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            var response = JSON.parse(xhr.responseText);
                            var screenSelect = document.getElementById('screen');
                            screenSelect.innerHTML = '<option value="">--Select Screen--</option>';
                            response.forEach(function (screen) {
                                var option = document.createElement('option');
                                option.value = screen.screenID;
                                option.textContent = screen.screenName;
                                screenSelect.appendChild(option);
                            });
                        }
                    };
                    xhr.send('cinemaId=' + cinemaId + '&movieId=' + movieId);
                } else {
                    document.getElementById('screen').innerHTML = '<option value="">--Select Screen--</option>';
                }
            }

            function fetchShowtimes() {
                var cinemaId = document.getElementById('cinema').value;
                var screenId = document.getElementById('screen').value;
                var movieId = '<%= movieId %>';
                if (cinemaId && screenId) {
                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', 'selectShowtime', true);
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            var response = JSON.parse(xhr.responseText);
                            var showtimeSelect = document.getElementById('showtime');
                            showtimeSelect.innerHTML = '<option value="">--Select Start Time--</option>';
                            response.forEach(function (showtime) {
                                var option = document.createElement('option');
                                option.value = showtime.showtimeID;
                                option.setAttribute('data-endtime', showtime.endTime);
                                option.textContent = showtime.startTime;
                                showtimeSelect.appendChild(option);
                            });
                        }
                    };
                    xhr.send('cinemaId=' + cinemaId + '&screenId=' + screenId + '&movieId=' + movieId);
                } else {
                    document.getElementById('showtime').innerHTML = '<option value="">--Select Start Time--</option>';
                }
            }
        </script>
        
    </head>
    <body>
        <header class="header">
            <h1>Select Showtime</h1>
        </header>

        <nav id="main-nav">
            <a href="movie">Home</a>
            <a href="contact.jsp">Contact</a>
        </nav>

        <div class="container">
            <h2><%= movieTitle %></h2>
            <form action="selectSeat" method="post">
                <input type="hidden" name="movieId" value="<%= movieId %>">
                <input type="hidden" name="movieName" value="<%= movieTitle %>">
                <input type="hidden" name="cinemaName" id="cinemaName">
                <input type="hidden" name="screenName" id="screenName">
                

                <label for="cinema">Cinema:</label>
                <select id="cinema" name="cinemaId" required>
                    <option value="">--Select Cinema--</option>
                    <%
                        if (cinemas != null) {
                            for (Cinema cinema : cinemas) {
                    %>
                    <option value="<%= cinema.getCinemaID() %>">
                        <%= cinema.getCinemaName() %> - <%= cinema.getLocation() %>
                    </option>
                    <%
                            }
                        }
                    %>
                </select>

                <label for="screen">Screen:</label>
                <select id="screen" name="screenId" required disabled>
                    <option value="">--Select Screen--</option>
                    <!-- Screen options will be populated dynamically based on selected cinema and movie -->
                </select>

                <div class="time-container">
                    <table>
                        <tr>
                            <td><label for="showtime">Start Time:</label></td>
                            <td style="padding-left: 10px"><label for="endtime">End Time:</label></td>
                        </tr>
                        <tr>
                            <td style="padding-right: 10px"><select id="showtime" name="showtimeId" required disabled>
                                    <option value="">--Select Start Time--</option>                   
                                </select></td>
                            <td style="padding-left: 10px">
                                <input type="text" id="endtime" name="endtime" readonly>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="confirm-booking-button-container">
                    <button class="back-button" onclick="window.history.back(); return false;">Back</button>
                    <button type="submit" class="confirm-booking-button">Select Seat</button>
                </div>
            </form>
        </div>
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
        <script>
            document.getElementById('cinema').addEventListener('change', function () {
                var selectedCinema = this.options[this.selectedIndex].text;
                document.getElementById('cinemaName').value = selectedCinema;
            });

            document.getElementById('screen').addEventListener('change', function () {
                var selectedScreen = this.options[this.selectedIndex].text;
                document.getElementById('screenName').value = selectedScreen;
            });
        </script>
    </body>
</html>

