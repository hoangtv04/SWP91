<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.Customer"%>
<%
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
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
            <a href="movie">Home</a>
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
                        <input type="hidden" name="CustomerID" value="<%= customer.getCustomerId() %>">
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
                        <button type="submit">Post</button>
                    </form>
                </div>

                <div class="movie-reviews">

                    <c:if test="${not empty reviews}">
                        <ul id="review-list">
                            <c:forEach var="review" items="${reviews}">
                                <li class="review-item" id="review-item-${review.reviewID}">
                                    <p class="custumer-name">${customerNames[review.customerID]}</p>
                                    <p><strong>Rating:</strong> <span id="rating-display-${review.reviewID}">${review.rating}</span> / 5</p>
                                    <p id="comment-display-${review.reviewID}">${review.comment}</p>
                                    <p><strong>Date:</strong> ${review.reviewDate}</p>

                                    <!-- Nút Edit -->
                                    <button class="edit-button" onclick="enableEdit('${review.reviewID}')">Edit</button>

                                    <!-- Form chỉnh sửa -->
                                    <form class="edit-form" action="editComment" method="post" id="edit-form-${review.reviewID}" style="display: none;">
                                        <input type="hidden" name="reviewId" value="${review.reviewID}">
                                        <input type="hidden" name="movieId" value="${movie.movieID}">
                                        <label for="rating-${review.reviewID}">Rating:</label>
                                        <input type="number" id="rating-${review.reviewID}" name="rating" value="${review.rating}" min="1" max="5" required>
                                        <label for="comment-${review.reviewID}">Comment:</label>
                                        <textarea id="comment-${review.reviewID}" name="comment" rows="4" required>${review.comment}</textarea>
                                        <button type="submit" class="save-button">Save</button>
                                        <button type="button" class="cancel-edit" onclick="cancelEdit('${review.reviewID}')">Cancel</button>
                                    </form>

                                    <!-- Nút Delete -->
                                    <form action="deleteComment" method="post">
                                        <input type="hidden" name="reviewId" value="${review.reviewID}">
                                        <input type="hidden" name="movieId" value="${movie.movieID}">
                                        <button type="submit" class="delete-button">Delete</button>
                                    </form>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${empty reviews}">
                        <p>No reviews yet. Be the first to leave a comment!</p>
                    </c:if>
                </div>

                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        // Xử lý sự kiện khi nhấn nút "Edit"
                        document.querySelectorAll(".edit-button").forEach(button => {
                            button.addEventListener("click", function (event) {
                                let reviewItem = event.target.closest(".review-item"); // Lấy phần tử cha chứa review
                                let editForm = reviewItem.querySelector(".edit-form"); // Lấy form chỉnh sửa
                                let ratingDisplay = reviewItem.querySelector(`#rating-display-${reviewItem.id.split('-')[2]}`);
                                let commentDisplay = reviewItem.querySelector(`#comment-display-${reviewItem.id.split('-')[2]}`);
                                let editButton = reviewItem.querySelector(".edit-button");
                
                                if (editForm) {
                                    // Hiển thị form chỉnh sửa
                                    editForm.style.display = "block";
                
                                    // Ẩn phần hiển thị rating và comment
                                    if (ratingDisplay) ratingDisplay.style.display = "none";
                                    if (commentDisplay) commentDisplay.style.display = "none";
                
                                    // Ẩn nút "Edit"
                                    editButton.style.display = "none";
                                }
                            });
                        });
                
                        // Xử lý sự kiện khi nhấn nút "Cancel"
                        document.querySelectorAll(".cancel-edit").forEach(button => {
                            button.addEventListener("click", function (event) {
                                let reviewItem = event.target.closest(".review-item"); // Lấy phần tử cha chứa review
                                let editForm = reviewItem.querySelector(".edit-form"); // Lấy form chỉnh sửa
                                let ratingDisplay = reviewItem.querySelector(`#rating-display-${reviewItem.id.split('-')[2]}`);
                                let commentDisplay = reviewItem.querySelector(`#comment-display-${reviewItem.id.split('-')[2]}`);
                                let editButton = reviewItem.querySelector(".edit-button");
                
                                if (editForm) {
                                    // Ẩn form chỉnh sửa
                                    editForm.style.display = "none";
                
                                    // Hiển thị lại phần rating và comment
                                    if (ratingDisplay) ratingDisplay.style.display = "inline";
                                    if (commentDisplay) commentDisplay.style.display = "block";
                
                                    // Hiển thị lại nút "Edit"
                                    editButton.style.display = "inline-block";
                                }
                            });
                        });
                    });
                </script>
                <script>

                    function deleteComment(reviewId, movieId) {
                        if (confirm("Are you sure you want to delete this comment?")) {
                            // Gửi yêu cầu xóa comment qua fetch API
                            fetch('deleteComment', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: `reviewId=${reviewId}`
                            })
                                    .then(response => {
                                        if (response.ok) {
                                            // Xóa comment khỏi giao diện
                                            const reviewItem = document.getElementById(`review-item-${reviewId}`);
                                            if (reviewItem) {
                                                reviewItem.remove();
                                            }
                                        } else {
                                            alert("Failed to delete the comment. Please try again.");
                                        }
                                    })
                                    .catch(error => {
                                        console.error("Error deleting comment:", error);
                                        alert("An error occurred. Please try again.");
                                    });
                        }
                    }
                </script>
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