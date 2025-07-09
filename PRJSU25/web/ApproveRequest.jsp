<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.LeaveRequest" %>
<%@page import="dal.DAO" %>
<%@page import="java.util.List" %>
<%@page import="model.Account" %>

<%
    if (session == null || session.getAttribute("role") == null || !"manager".equalsIgnoreCase((String) session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Account manager = (Account) session.getAttribute("account");
    if (manager == null) {
        out.println("<h3 style='color:red;'>Session error: manager account not found in session.</h3>");
        return;
    }

    int departmentId = manager.getDepartmentId();
    DAO dao = new DAO();
    List<LeaveRequest> list = dao.getPendingLeaveRequestsByDepartmentId(departmentId);

    boolean hasPending = false;
    for (LeaveRequest r : list) {
        if ("pending".equalsIgnoreCase(r.getStatus())) {
            hasPending = true;
            break;
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                background-color: #f2f2f2;
            }

            .container {
                display: flex;
            }

            .sidebar {
                width: 220px;
                background-color: #2c3e50;
                color: white;
                padding: 20px;
                min-height: 100vh;
            }

            .sidebar h3 {
                margin-top: 0;
            }

            .sidebar ul {
                list-style-type: none;
                padding: 0;
            }

            .sidebar ul li {
                margin: 15px 0;
            }

            .sidebar ul li a {
                color: white;
                text-decoration: none;
                font-weight: bold;
            }

            .sidebar ul li a:hover {
                text-decoration: underline;
            }

            .main-content {
                flex-grow: 1;
                padding: 30px;
                background-color: #ffffff;
            }

            h2 {
                color: #2c3e50;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: #fafafa;
            }

            table th, table td {
                border: 1px solid #ccc;
                padding: 12px;
                text-align: center;
            }

            table th {
                background-color: #34495e;
                color: white;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .btn {
                padding: 6px 12px;
                margin: 2px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                color: white;
            }

            .btn-approve {
                background-color: #27ae60;
            }

            .btn-reject {
                background-color: #e74c3c;
            }

            .btn-back {
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 4px;
            }

            .btn-back:hover {
                background-color: #2980b9;
            }
        </style>
        <meta charset="UTF-8">
        <title>Approve Leave Requests</title>
    </head>
    <body>

        <h1>Approve Leave Requests (Department ID: <%= departmentId %>)</h1>

        <% if (!hasPending) { %>
        <p>No leave requests in queue.</p>
        <form action="Manager.jsp">
            <button type="submit">Return to Dashboard</button>
        </form>
        <% } else { %>
        <table border="1" cellpadding="8" cellspacing="0">
            <tr>
                <th>User ID</th>
                <th>Leave Type</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <%
                for (LeaveRequest r : list) {
                    if ("pending".equalsIgnoreCase(r.getStatus())) {
            %>
            <tr>
                <td><%= r.getUserId() %></td>
                <td><%= r.getLeaveTypeId() %></td>
                <td><%= r.getStartDate() %></td>
                <td><%= r.getEndDate() %></td>
                <td><%= r.getReason() %></td>
                <td><%= r.getStatus() %></td>
                <td>
                    <form action="leaveapproval" method="post" style="display:inline;">
                        <input type="hidden" name="requestId" value="<%= r.getId() %>" />
                        <button type="submit" name="action" value="approve">Approve</button>
                        <button type="submit" name="action" value="reject">Reject</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
        <% } %>
    </body>
</html>
