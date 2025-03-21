<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map, java.text.SimpleDateFormat" %>
<%@ page import="model.Movie" %>
<%@page import="model.Admin"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Manage Movies</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .header {
                background-color: #2980b9;
                color: white;
                padding: 10px 0;
                text-align: center;
                position: relative;
            }
            .logout-btn {
                position: absolute;
                top: 10px;
                right: 20px;
                background-color: #333;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
            }
            .logout-btn:hover {
                background-color: #ddd;
                color: black;
            }
            .navbar {
                overflow: hidden;
                background-color: #333;
                display: flex;
                justify-content: center;
            }
            .navbar a {
                float: left;
                display: block;
                color: white;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
            }
            .navbar a:hover {
                background-color: #ddd;
                color: black;
            }
            .container {
                padding: 20px;
            }
            .table-container {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #2980b9;
                color: white;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            .add-btn {
                display: block;
                width: 200px;
                margin: 20px auto;
                padding: 10px;
                background-color: #e74c3c;
                color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 5px;
            }
            .add-btn:hover {
                background-color: #c0392b;
            }
            .popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
                border: 3px solid #2980b9;
                width: 400px;
            }

            .popup h3 {
                text-align: center;
                margin-bottom: 15px;
            }

            .popup form {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .popup label {
                font-weight: bold;
            }

            .popup select,
            .popup input,
            .popup textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .popup .button-group {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
            }

            .popup .button-group button {
                width: 48%;
                padding: 8px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .popup .button-group button[type="submit"] {
                background-color: #2980b9;
                color: white;
            }

            .popup .button-group button[type="submit"]:hover {
                background-color: #1c5a85;
            }

            .popup .button-group button.close-btn {
                background-color: #e74c3c;
                color: white;
            }

            .popup .button-group button.close-btn:hover {
                background-color: #c0392b;
            }
            .header p {
                text-align: left;
                margin-left: 20px;
            }
            .header p {
                text-align: left;
                margin-left: 20px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Admin Dashboard - Manage Movies</h1>
            <p>Xin chào, <%= admin.getName() %>!</p>
            <a href="logout" class="logout-btn">Đăng xuất</a>
        </div>
        <div class="navbar">
            <a href="AdminDashboard">Home</a>
            <a href="user">Manage Users</a>
            <a href="Movies">Manage Movies</a>
            <a href="Showtime">Manage Showtimes</a>
            <a href="manageBookings.jsp">Manage Bookings</a>
            <a href="reviews">Manage Reviews</a>
            <a href="voucher">Manage Vouchers</a>
        </div>

            <div class="container">
                <div class="search-container">
                    <input type="text" id="searchInput" placeholder="Tìm kiếm..." onkeyup="filterMovies()">
                    <button class="add-btn" onclick="openAddMoviePopup()">Thêm</button>
                </div>
                <div class="table-container">
                    <h2 class="text-center">Danh sách phim</h2>
                    <table id="moviesTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên</th>
                                <th>Thể loại</th>
                                <th>Thời lượng (phút)</th>
                                <th>Ngày khởi chiếu</th>
                                <th>Mô tả</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="movieTableBody">
                            <% List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                               Map<Integer, String> movieMap = (Map<Integer, String>) request.getAttribute("movieMap");
                               SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                               if (movies != null && !movies.isEmpty()) {
                                   for (Movie movie : movies) { %>
                            <tr>
                                <td><%= movie.getMovieID() %></td>
                                <td><%= movie.getTitle() %></td>
                                <td><%= movie.getGenre() %></td>
                                <td><%= movie.getDuration() %></td>
                                <td><%= sdf.format(movie.getReleaseDate()) %></td>
                                <td>
                                    <span class="short-desc"><%= movie.getDescription().substring(0, Math.min(50, movie.getDescription().length())) %></span>
                                    <% if (movie.getDescription().length() > 50) { %>
                                        <span class="more-desc" style="display:none;"><%= movie.getDescription().substring(50) %></span>
                                        <a href="javascript:void(0);" class="see-more" onclick="toggleDescription(this)">...xem thêm</a>
                                    <% } %>
                                </td>
                                <td class="<%= movie.getStatus().equals("Đang chiếu") ? "status-dang-chieu" : "status-ngung-chieu" %>"><%= movie.getStatus() %></td>
                                <td>
                                    
                                    <!-- Nút Sửa -->
                                    <button type="button" class="update-btn" onclick="openUpdateMoviePopup(
                                                    '<%= movie.getMovieID() %>',
                                                    '<%= movie.getTitle() %>',
                                                    '<%= movie.getGenre() %>',
                                                    '<%= movie.getDuration() %>',
                                                    '<%= sdf.format(movie.getReleaseDate()) %>',
                                                    '<%= movie.getDescription() %>',
                                                    '<%= movie.getStatus() %>'
                                                    )">Sửa</button>

                                    <!-- Nút Xóa -->
                                    <form action="Movies" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="movieID" value="<%= movie.getMovieID() %>">
                                        <button type="submit" class="delete-btn">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                            <% } } else { %>
                            <tr>
                                <td colspan="7">Không có phim nào.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <div class="pagination" id="pagination"></div>
                </div>
            </div>

            <!-- Popup Thêm Phim -->
            <div id="addMoviePopup" class="popup">
                <h3>Thêm Phim</h3>
                <form action="Movies" method="post">
                    <input type="hidden" name="action" value="add">

                    <label for="title">Title:</label>
                    <input type="text" name="title" required>

                    <label for="genre">Genre:</label>
                    <input type="text" name="genre" required>

                    <label for="duration">Duration (minutes):</label>
                    <input type="number" name="duration" required>

                    <label for="releaseDate">Release Date:</label>
                    <input type="date" name="releaseDate" required>

                    <label for="description">Description:</label>
                    <textarea name="description" required></textarea>

                    <label for="status">Status:</label>
                    <select name="status" required>
                        <option value="Đang chiếu">Đang chiếu</option>
                        <option value="Ngừng chiếu">Ngừng chiếu</option>
                    </select>

                    <button type="submit">Add Movie</button>
                    <button type="button" class="close-btn" onclick="closeAddMoviePopup()">Close</button>
                </form>
            </div>

            <!-- Popup Cập Nhật Phim -->
            <div id="updateMoviePopup" class="popup">
                <h3>Cập Nhật Phim</h3>
                <form action="Movies" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="updateMovieID" name="movieID">

                    <label for="updateTitle">Title:</label>
                    <input type="text" id="updateTitle" name="title" required>

                    <label for="updateGenre">Genre:</label>
                    <input type="text" id="updateGenre" name="genre" required>

                    <label for="updateDuration">Duration (minutes):</label>
                    <input type="number" id="updateDuration" name="duration" required>

                    <label for="updateReleaseDate">Release Date:</label>
                    <input type="date" id="updateReleaseDate" name="releaseDate" required>

                    <label for="updateDescription">Description:</label>
                    <textarea id="updateDescription" name="description" required></textarea>

                    <label for="updateStatus">Status:</label>
                    <select id="updateStatus" name="status" required>
                        <option value="Đang chiếu">Đang chiếu</option>
                        <option value="Ngừng chiếu">Ngừng chiếu</option>
                    </select>

                    <div class="button-group"></div>
                        <button type="submit">Update Movie</button>
                        <button type="button" class="close-btn" onclick="closeUpdateMoviePopup()">Close</button>
                    </div>
                </form>
            </div>

            <script>
                function openAddMoviePopup() {
                    document.getElementById("addMoviePopup").style.display = "block";
                }
                function closeAddMoviePopup() {
                    document.getElementById("addMoviePopup").style.display = "none";
                }
                function openUpdateMoviePopup(id, title, genre, duration, releaseDate, description, status) {
                    document.getElementById("updateMovieID").value = id;
                    document.getElementById("updateTitle").value = title;
                    document.getElementById("updateGenre").value = genre;
                    document.getElementById("updateDuration").value = duration;
                    document.getElementById("updateReleaseDate").value = releaseDate;
                    document.getElementById("updateDescription").value = description;
                    var statusElement = document.getElementById("updateStatus");
                    statusElement.value = status;
                    // Remove the color classes
                    statusElement.classList.remove("status-dang-chieu", "status-ngung-chieu");
                    document.getElementById("updateMoviePopup").style.display = "block";
                }

                function closeUpdateMoviePopup() {
                    document.getElementById("updateMoviePopup").style.display = "none";
                }

                function toggleDescription(element) {
                    var shortDesc = element.previousElementSibling.previousElementSibling;
                    var moreDesc = element.previousElementSibling;
                    if (moreDesc.style.display === "none") {
                        moreDesc.style.display = "inline";
                        element.textContent = " ẩn bớt";
                    } else {
                        moreDesc.style.display = "none";
                        element.textContent = "...xem thêm";
                    }
                }
                
                //tìm kiếm phim
                function filterMovies() {
                    var input, filter, table, tr, td, i, txtValue;
                    input = document.getElementById("searchInput");
                    filter = input.value.toLowerCase();
                    table = document.getElementById("moviesTable");
                    tr = table.getElementsByTagName("tr");
                    for (i = 1; i < tr.length; i++) {
                        td = tr[i].getElementsByTagName("td")[1];
                        if (td) {
                            txtValue = td.textContent || td.innerText;
                            if (txtValue.toLowerCase().indexOf(filter) > -1) {
                                tr[i].style.display = "";
                            } else {
                                tr[i].style.display = "none";
                            }
                        }
                    }
                }

                // Pagination
                const rowsPerPage = 10;
                const rows = document.querySelectorAll('#movieTableBody tr');
                const rowsCount = rows.length;
                const pageCount = Math.ceil(rowsCount / rowsPerPage);
                const pagination = document.getElementById('pagination');
                let currentPage = 1;

                function displayPage(page) {
                    const start = (page - 1) * rowsPerPage;
                    const end = start + rowsPerPage;
                    rows.forEach((row, index) => {
                        row.style.display = (index >= start && index < end) ? '' : 'none';
                    });
                }

                function setupPagination() {
                    const prevLink = document.createElement('a');
                    prevLink.textContent = '«';
                    prevLink.href = 'javascript:void(0);';
                    prevLink.onclick = () => {
                        if (currentPage > 1) {
                            currentPage--;
                            displayPage(currentPage);
                            updatePagination();
                        }
                    };
                    pagination.appendChild(prevLink);

                    for (let i = 1; i <= pageCount; i++) {
                        const pageLink = document.createElement('a');
                        pageLink.textContent = i;
                        pageLink.href = 'javascript:void(0);';
                        pageLink.onclick = () => {
                            currentPage = i;
                            displayPage(i);
                            updatePagination();
                        };
                        pagination.appendChild(pageLink);
                    }

                    const nextLink = document.createElement('a');
                    nextLink.textContent = '»';
                    nextLink.href = 'javascript:void(0);';
                    nextLink.onclick = () => {
                        if (currentPage < pageCount) {
                            currentPage++;
                            displayPage(currentPage);
                            updatePagination();
                        }
                    };
                    pagination.appendChild(nextLink);

                    updatePagination();
                }

                function updatePagination() {
                    const links = pagination.querySelectorAll('a');
                    links.forEach(link => link.style.display = 'none');
                    links[0].style.display = '';
                    links[links.length - 1].style.display = '';

                    if (currentPage > 1) {
                        links[currentPage - 1].style.display = '';
                    }
                    links[currentPage].style.display = '';
                    if (currentPage < pageCount) {
                        links[currentPage + 1].style.display = '';
                    }

                    if (currentPage < pageCount - 1) {
                        links[links.length - 2].style.display = '';
                        links[links.length - 2].textContent = '...';
                    } else {
                        links[links.length - 2].textContent = pageCount;
                    }

                    links.forEach(link => link.classList.remove('active'));
                    links[currentPage].classList.add('active');
                }

                displayPage(1);
                setupPagination();
            </script>
    </body>
</html>
