<%-- Document : Members Created on : Mar 24, 2025, 9:00:02 AM Author : tovie --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Members - Group6</title>
            <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
            <style>
                body {
                    background: url('image member/member.jpg') no-repeat center center fixed;
                    background-size: cover;
                }

                table.table {
                    border-collapse: collapse;
                    width: 100%;
                    border: 2px solid rgba(255, 255, 255, 0.7);
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                    background-color: rgba(0, 0, 0, 0.5);
                }

                table.table th,
                table.table td {
                    border: 1px solid rgba(255, 255, 255, 0.5);
                    padding: 12px;
                    color: #fff;
                }

                table.table th {
                    background-color: rgba(0, 0, 0, 0.7);
                    text-align: center;
                }

                table.table tr:nth-child(even) {
                    background-color: rgba(0, 0, 0, 0.6);
                }

                table.table tr:hover {
                    background-color: rgba(0, 0, 0, 0.8);
                }


                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                table.table tbody tr {
                    opacity: 0;
                    animation: fadeIn 0.8s forwards;
                }

                table.table tbody tr:nth-child(1) {
                    animation-delay: 0.2s;
                }

                table.table tbody tr:nth-child(2) {
                    animation-delay: 0.4s;
                }

                table.table tbody tr:nth-child(3) {
                    animation-delay: 0.6s;
                }

                table.table tbody tr:nth-child(4) {
                    animation-delay: 0.8s;
                }
            </style>
        </head>

        <body>
            <div style="position: fixed; top: 10px; left: 10px; z-index: 1000;">
                <a href="movie" class="btn btn-secondary">&larr; Back</a>
            </div>
            <div class="container my-5">
                <h2 class="text-center mb-4 text-white">Group6 Members</h2>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Member Name</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Tô Việt Hoàng-SE1874-JS</td>
                        </tr>
                        <tr>
                            <td>Bùi Minh Long-SE1874-JS</td>
                        </tr>
                        <tr>
                            <td>Trần Trung Hiếu-SE1874-JS</td>
                        </tr>
                        <tr>
                            <td>Nguyễn Trọng Quý-SE1874-JS</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        </body>

        </html>