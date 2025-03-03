<%-- 
    Document   : CustomerHome
    Created on : Mar 1, 2025, 11:18:29 PM
    Author     : tovie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Movie"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Movies</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .container {
                margin-top: 20px;
            }
            .row {
                margin-bottom: 20px; /* Add margin to the bottom of each row */
            }
            .movie-item {
                margin-bottom: 20px; /* Add margin to the bottom of each movie item */
                border: 2px solid #fff; /* White border */
                border-radius: 5px;
                padding: 10px;
                background-color: #fff;
                transition: transform 0.3s ease; /* Transition for the entire movie item */
                position: relative; /* Add relative positioning */
            }
            .movie-item:hover {
                transform: scale(1.05); /* Scale the entire movie item on hover */
            }
            .movie-item h2 {
                font-size: 20px;
                font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                color: #333;
                transition: text-decoration 0.3s ease; /* Transition for the underline effect */
            }
            .movie-item h2:hover {
                text-decoration: underline; /* Underline the movie title on hover */
            }
            .movie-item p {
                margin: 5px 0;
                font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                color: #666;
            }
            .movie-item a {
                display: inline-block;
                margin-top: 10px;
                padding: 10px 15px;
                background: #007bff;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
            }
            .movie-item a:hover {
                background: #0056b3;
            }
            .movie-item img {
                width: 100%;
                height: 500px;
                object-fit: cover;
                border-radius: 5px;
                transition: transform 0.3s ease; 
            }
            .carousel-item img {
                height: 550px; 
            }
            .carousel-indicators li {
                width: 12px;
                height: 12px;
                border-radius: 50%;
                background-color: #ffff;
            }
            .carousel-indicators .active {
                background-color: #ffff;
            }
            .carousel-control-prev-icon,
            .carousel-control-next-icon {
                background-size: 100%, 100%;
                width: 50px;
                height: 50px;
            }
            .carousel-control-prev,
            .carousel-control-next {
                width: 5%;
            }
            .navbar-nav {
                margin: 0 auto; /* Center the navbar items */
            }
            .nav-item {
                padding: 0 15px; /* Add padding to the navbar items */
            }
            .nav-link {
                font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                font-size: 16px;
                color: #333;
                transition: color 0.3s ease; /* Transition for the color change */
            }
            .nav-link:hover {
                color: #007bff; /* Change color on hover */
            }
            .footer {
                background-color: #636367c6;
                padding: 40px 0; /* Increase padding */
                text-align: center;
                border-top: 1px solid #fafafa;
                margin-top: 20px;
                font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                font-size: 20px; /* Increase font size */
                color: #f9f9f9;
            }
            .footer p {
                margin: 0;
            }
            .see-more-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                color: #fff;
                display: flex;
                justify-content: center;
                align-items: center;
                opacity: 0;
                transition: opacity 0.3s ease;
                border-radius: 5px;
            }
            .movie-item:hover .see-more-overlay {
                opacity: 1;
            }
        </style>
    </head>
    <body>
        <!-- Navbar Section -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto"> <!-- Align the navbar items to the right -->
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Movies</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact</a>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">Logout</button>
                </form>
            </div>
        </nav>

        <!-- Banner Section -->
        <div id="bannerCarousel" class="carousel slide" data-ride="carousel" data-interval="2000">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#bannerCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#bannerCarousel" data-slide-to="1"></li>
                <li data-target="#bannerCarousel" data-slide-to="2"></li>
                <li data-target="#bannerCarousel" data-slide-to="3"></li>
                <li data-target="#bannerCarousel" data-slide-to="4"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="images banner/banner1.jpg" class="d-block w-100" alt="Banner 1">
                </div>
                <div class="carousel-item">
                    <img src="images banner/banner2.jpg" class="d-block w-100" alt="Banner 2">
                </div>
                <div class="carousel-item">
                    <img src="images banner/banner3.jpg" class="d-block w-100" alt="Banner 3">
                </div>
                <div class="carousel-item">
                    <img src="images banner/banner4.jpg" class="d-block w-100" alt="Banner 4">
                </div>
                <div class="carousel-item">
                    <img src="images banner/banner5.jpg" class="d-block w-100" alt="Banner 5">
                </div>
            </div>
            <a class="carousel-control-prev" href="#bannerCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#bannerCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <div class="container">
            <%
                List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                if (movies != null && !movies.isEmpty()) {
                    int index = 1;
                    for (int i = 0; i < movies.size(); i++) {
                        if (i % 3 == 0) {
            %>
            <div class="row">
            <%
                        }
            %>
                <div class="col-md-4 movie-item">
                    <div class="card h-100 d-flex flex-column">
                        <img src="images poster/phim<%= index %>.jpg" class="card-img-top" alt="<%= movies.get(i).getTitle() %>">
                        <div class="see-more-overlay">
                            <a href="movieDetails?movieId=<%= movies.get(i).getMovieID() %>" class="btn btn-primary">See More</a>
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h2 class="card-title text-center"><%= movies.get(i).getTitle() %></h2>
                            <p class="card-text text-center"><strong>Release Date:</strong> <%= movies.get(i).getReleaseDate() %></p>
                        </div>
                    </div>
                </div>
            <%
                        index++;
                        if ((i + 1) % 3 == 0 || i == movies.size() - 1) {
            %>
            </div>
            <%
                        }
                    }
                } else {
            %>
            <div class="row">
                <p class="col-12">No movies available.</p>
            </div>
            <%
                }
            %>
        </div>

        <!-- Footer Section -->
        <div class="footer">
            <p>Demo Footer Information: This is a demo website for showing movies. All content is for demonstration purposes only.</p>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>

