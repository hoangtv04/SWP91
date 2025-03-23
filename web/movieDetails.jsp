<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Movie Details</title>
            <link rel="stylesheet" type="text/css" href="css/movieDetails.css">
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                window.addEventListener('scroll', function () {
                    var nav = document.getElementById('main-nav');
                    if (window.scrollY > 0) {
                        nav.classList.add('sticky');
                    } else {
                        nav.classList.remove('sticky');
                    }
                });

                $(document).ready(function() {
                    $('.edit-button').click(function(e) {
                        e.preventDefault();
                        var reviewId = $(this).data('review-id');
                        var comment = $(this).closest('li').find('.comment-text').text();
                        var rating = $(this).closest('li').find('.rating-text').text();
                        var editForm = `
                            <form class="edit-comment-form" data-review-id="${reviewId}">
                                <label for="edit-rating">Rating:</label>
                                <input type="number" name="rating" value="${rating}" min="1" max="5">
                                <label for="edit-comment">Comment:</label>
                                <textarea name="comment">${comment}</textarea>
                                <button type="submit">Update</button>
                                <button type="button" class="cancel-edit">Cancel</button>
                            </form>
                        `;
                        $(this).closest('li').html(editForm);
                    });

                    $(document).on('submit', '.edit-comment-form', function(e) {
                        e.preventDefault();
                        var reviewId = $(this).data('review-id');
                        var rating = $(this).find('input[name="rating"]').val();
                        var comment = $(this).find('textarea[name="comment"]').val();
                        $.ajax({
                            url: 'editComment',
                            method: 'POST',
                            data: {
                                reviewId: reviewId,
                                rating: rating,
                                comment: comment
                            },
                            success: function(response) {
                                // Update the review item with the new data
                                var updatedReview = `
                                    <p><strong>Customer:</strong> ${response.customerName}</p>
                                    <p><strong>Rating:</strong> <span class="rating-text">${response.review.rating}</span></p>
                                    <p><strong>Comment:</strong> <span class="comment-text">${response.review.comment}</span></p>
                                    <button class="edit-button" data-review-id="${response.review.reviewID}">Edit</button>
                                    <button class="delete-button" data-review-id="${response.review.reviewID}">Delete</button>
                                `;
                                $(`li[data-review-id="${reviewId}"]`).html(updatedReview);
                            }
                        });
                    });

                    $(document).on('click', '.cancel-edit', function() {
                        location.reload();
                    });

                    $('.delete-button').click(function(e) {
                        e.preventDefault();
                        var reviewId = $(this).data('review-id');
                        $.ajax({
                            url: 'deleteComment',
                            method: 'POST',
                            data: {
                                reviewId: reviewId
                            },
                            success: function(response) {
                                if (response.success) {
                                    $(`li[data-review-id="${reviewId}"]`).remove();
                                }
                            }
                        });
                    });
                });
            </script>
        </head>

        <body>
            <header class="header">
                <h1>Movie Detail</h1>
            </header>

            <nav id="main-nav">
                <a href="movie">Home</a>
                <a href="movie">Movies</a>
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
                        <form action="addComment" method="post">
                            <input type="hidden" name="movieId" value="${movie.movieID}">
                            <label for="rating">Rating:</label>
                            <div class="rating-container">
                                <div class="rating">
                                    <input type="radio" id="star5" name="rating" value="5" /><label for="star5"
                                        title="5 stars"></label>
                                    <input type="radio" id="star4" name="rating" value="4" /><label for="star4"
                                        title="4 stars"></label>
                                    <input type="radio" id="star3" name="rating" value="3" /><label for="star3"
                                        title="3 stars"></label>
                                    <input type="radio" id="star2" name="rating" value="2" /><label for="star2"
                                        title="2 stars"></label>
                                    <input type="radio" id="star1" name="rating" value="1" /><label for="star1"
                                        title="1 star"></label>
                                </div>
                            </div>
                            <label for="comment">Comment:</label>
                            <textarea name="comment" id="comment" rows="4" cols="50"></textarea>
                            <button type="submit">Submit</button>
                        </form>
                    </div>
                    <div class="movie-reviews">
                        <ul>
                            <c:forEach var="review" items="${reviews}">
                                <li data-review-id="${review.reviewID}">
                                    <p><strong>Customer:</strong> ${customerNames[review.customerID]}</p>
                                    <p><strong>Rating:</strong> <span class="rating-text">${review.rating}</span></p>
                                    <p><span class="comment-text">${review.comment}</span></p>
                                    <button class="edit-button" data-review-id="${review.reviewID}">Edit</button>
                                    <button class="delete-button" data-review-id="${review.reviewID}">Delete</button>
                                </li>
                            </c:forEach>
                        </ul>
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