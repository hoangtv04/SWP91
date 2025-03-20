<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Movie Details</title>
        <link rel="stylesheet" type="text/css" href="css/movieDetails.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            // Sticky navigation bar
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
            <h1>Movie Detail</h1>
        </header>

        <nav id="main-nav">
            <a href="index.jsp">Home</a>
            <a href="movies.jsp">Movies</a>
            <a href="contact.jsp">Contact</a>
        </nav>

        <div class="container">
            <c:if test="${not empty movie}">
                <div class="movie-details">
                    <h1>${movie.title}</h1>
                    <div class="movie-info">
                        <img src="images/${movie.movieID}.jpg" alt="${movie.title} Poster" class="movie-poster">
                        <div class="movie-meta">
                            <p><strong>Genre:</strong> ${movie.genre}</p>
                            <p><strong>Duration:</strong> ${movie.duration} minutes</p>
                            <p><strong>Release Date:</strong> ${movie.releaseDate}</p>
                            <p><strong>Rating:</strong> ${averageRating} / 5</p>
                            <p><strong>Description:</strong> ${movie.description}</p>

                            <form action="selectShowtime" method="get">
                                <input type="hidden" name="movieId" value="${movie.movieID}">
                                <button type="submit" class="select-showtime-button">Select Showtime</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="add-comment">
                    <h2>Add Your Comment</h2>
                    <form id="comment-form" action="addComment" method="post">
                        <input type="hidden" name="movieId" value="${movie.movieID}">
                        <input type="hidden" name="customerId" value="1"> <!-- Giá trị mặc định cho customerId -->
                        <label for="rating">Rating:</label>
                        <div class="rating-container">
                            <div class="rating">
                                <input type="radio" id="star5" name="rating" value="5" required />
                                <label for="star5" title="5 stars"></label>
                                <input type="radio" id="star4" name="rating" value="4" />
                                <label for="star4" title="4 stars"></label>
                                <input type="radio" id="star3" name="rating" value="3" />
                                <label for="star3" title="3 stars"></label>
                                <input type="radio" id="star2" name="rating" value="2" />
                                <label for="star2" title="2 stars"></label>
                                <input type="radio" id="star1" name="rating" value="1" />
                                <label for="star1" title="1 star"></label>
                            </div>
                        </div>
                        <label for="comment">Comment:</label>
                        <textarea name="comment" id="comment" rows="4" cols="50" required></textarea>
                        <button type="submit">Submit</button>
                    </form>
                </div>
                
            </c:if>
            <c:if test="${empty movie}">
                <p>Movie not found.</p>
            </c:if>
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
    </body>

</html>