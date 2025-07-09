<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Account" %>
<%@ page import="model.LeaveRequest" %>
<%@ page import="dal.DAO" %>

<%
    Account manager = (Account) session.getAttribute("account");
    String role = (String) session.getAttribute("role");

    if (manager == null || role == null || !"manager".equalsIgnoreCase(role)) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int departmentId = manager.getDepartmentId();
    DAO dao = new DAO();
    List<LeaveRequest> list = dao.getLeaveRequestsByDepartmentId(departmentId);
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Department Leave Requests</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ccc;
            }
            th {
                background: #2980b9;
                color: white;
            }
            .back-button {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <h2>Leave Requests in Your Department</h2>

        <%
            if (list == null || list.isEmpty()) {
        %>
        <p>No leave requests found.</p>
        <%
            } else {
        %>
        <table>
            <tr>
                <th>User Name</th>
                <th>Leave Type</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Reason</th>
                <th>Status</th>
            </tr>
            <%
                for (LeaveRequest r : list) {
                    String userName = dao.getUsernameById(r.getUserId());
                    String leaveTypeName = dao.getLeaveTypeNamebyId(r.getLeaveTypeId());        %>
            <tr>
                <td><%= userName != null ? userName : "Unknown" %></td>
                <td><%= leaveTypeName != null ? leaveTypeName : "Unknown" %></td>
                <td><%= r.getStartDate() %></td>
                <td><%= r.getEndDate() %></td>
                <td><%= r.getReason() %></td>
                <td><%= r.getStatus() %></td>
            </tr>
            <%
                }
            %>
        </table>
        <% } %>

        <div class="back-button">
            <form action="Manager.jsp">
                <button type="submit">Back to Dashboard</button>
            </form>
        </div>
    </body>
</html>
