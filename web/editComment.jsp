<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Comment</title>
        <link rel="stylesheet" type="text/css" href="css/movieDetails.css">
    </head>
    <body>
        <div class="container">
            <h2>Edit Your Comment</h2>
            <form action="editComment" method="post">
                <input type="hidden" name="reviewId" value="${review.reviewID}">
                <label for="rating">Rating:</label>
                <select name="rating" id="rating">
                    <option value="1" ${review.rating == 1 ? 'selected' : ''}>1</option>
                    <option value="2" ${review.rating == 2 ? 'selected' : ''}>2</option>
                    <option value="3" ${review.rating == 3 ? 'selected' : ''}>3</option>
                    <option value="4" ${review.rating == 4 ? 'selected' : ''}>4</option>
                    <option value="5" ${review.rating == 5 ? 'selected' : ''}>5</option>
                </select>
                <label for="comment">Comment:</label>
                <textarea name="comment" id="comment" rows="4" cols="50">${review.comment}</textarea>
                <button type="submit">Update</button>
            </form>
        </div>
    </body>
</html>