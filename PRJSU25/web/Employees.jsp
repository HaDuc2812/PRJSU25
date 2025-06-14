<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="model.LeaveRequest" %>
<%@ page import="java.util.List" %>
<%@ page import="dal.DAO" %>
<%@ page import="model.Users" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Employee Dashboard</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                display: flex;
            }

            .sidebar {
                width: 200px;
                background-color: #f0f0f0;
                padding: 20px;
                height: 100vh;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            }

            .sidebar button {
                display: block;
                width: 100%;
                margin-bottom: 10px;
                padding: 10px;
                cursor: pointer;
            }

            .content {
                padding: 20px;
                flex-grow: 1;
                background-color: #fff8f4;
            }

            .box {
                border: 1px solid #888;
                background-color: #ffe7d8;
                padding: 20px;
                max-width: 800px;
            }

            textarea {
                width: 100%;
                height: 80px;
            }

            .hidden {
                display: none;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table, th, td {
                border: 1px solid #888;
            }

            th, td {
                padding: 8px;
                text-align: center;
            }
        </style>
        <script>
            function showSection(id) {
                // Hide all sections
                document.getElementById("formSection").classList.add("hidden");
                document.getElementById("viewSection").classList.add("hidden");

                // Show the selected section
                document.getElementById(id).classList.remove("hidden");
            }
        </script>
    </head>
    <body>

        <div class="sidebar">
            <button onclick="showSection('formSection')">Tạo đơn nghỉ phép</button>
            <button onclick="showSection('viewSection')">Xem đơn</button>
        </div>

        <div class="content">
            <!-- Form Section -->
            <div id="formSection" class="box">
                <h2>Đơn xin nghỉ phép</h2>

                <% Users user = (Users) session.getAttribute("user");
           if (user != null) { %>
                <p>Xin chào, <strong><%= user.getU_name() %></strong></p>
                <% } else { %>
                <p>Bạn chưa đăng nhập.</p>
                <a href="Login.jsp">Đăng nhập</a>
                <% } %>

                <form action="leave" method="post">
                    <label for="leaveType">Loại nghỉ phép:</label>
                    <select name="leaveTypeId" id="leaveType" required>
                        <option value="1">Nghỉ phép năm</option>
                        <option value="2">Nghỉ ốm</option>
                        <option value="3">Nghỉ thai sản</option>
                        <option value="4">Lý do khác</option>
                    </select><br><br>

                    Từ ngày: <input type="date" name="startDate" required><br><br>
                    Tới ngày: <input type="date" name="endDate" required><br><br>
                    Lý do:<br>
                    <textarea name="reason" required></textarea><br><br>

                    <button type="submit">Gửi</button>
                </form>

                <% String msg = (String) request.getAttribute("message");
           if (msg != null) { %>
                <p style="color: green;"><%= msg %></p>
                <% } %>
            </div>

            <!-- View Leave Requests Section -->
            <div id="viewSection" class="box hidden">
                <h3>Danh sách đơn nghỉ phép</h3>
                <%
                    if (user != null) {
                        DAO dao = new DAO();
                        List<LeaveRequest> list = dao.getLeaveRequestByUserId(user.getUsers_id());
                        if (list != null && !list.isEmpty()) {
                %>
                <table>
                    <tr>
                        <th>Loại nghỉ</th>
                        <th>Từ ngày</th>
                        <th>Đến ngày</th>
                        <th>Lý do</th>
                        <th>Trạng thái</th>
                        <th>Thời gian gửi</th>
                    </tr>
                    <% for (LeaveRequest lr : list) { %>
                    <tr>
                        <td><%= lr.getLeaveTypeId() %></td>
                        <td><%= lr.getStartDate() %></td>
                        <td><%= lr.getEndDate() %></td>
                        <td><%= lr.getReason() %></td>
                        <td><%= lr.getStatus() %></td>
                        <td><%= lr.getRequestedAt() %></td>
                    </tr>
                    <% } %>
                </table>
                <% } else { %>
                <p>Không có đơn nghỉ phép nào.</p>
                <% } } else { %>
                <p>Vui lòng đăng nhập để xem đơn nghỉ phép.</p>
                <% } %>
            </div>
        </div>
    </body>
</html>
