<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.LeaveRequest" %>
<%@page import="model.Users" %>
<%@page import="dal.DAO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
<%
    if (session == null || session.getAttribute("role") == null || !"manager".equalsIgnoreCase((String) session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Users manager = (Users) session.getAttribute("user");
    int managerDid = manager.getDepartmentId(); // or getDid() depending on your model

    DAO dao = new DAO();
    List<LeaveRequest> list = dao.getLeaveRequestsByDepartmentId(managerDid);
%>

<head>
    <title>All Department Requests</title>
</head>
<body>
    <h2>Leave Requests in Your Department</h2>

    <%
        if (list == null || list.isEmpty()) {
    %>
    <p><strong>No leave requests found in your department.</strong></p>
    <%
        } else {
    %>
    <table border="1" cellpadding="8" cellspacing="0">
        <tr>
            <th>User ID</th>
            <th>Leave Type</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Reason</th>
            <th>Status</th>
        </tr>
        <%
            for (LeaveRequest r : list) {
        %>
        <tr>
            <td><%= r.getUserId() %></td>
            <td><%= r.getLeaveTypeId() %></td>
            <td><%= r.getStartDate() %></td>
            <td><%= r.getEndDate() %></td>
            <td><%= r.getReason() %></td>
            <td><%= r.getStatus() %></td>
        </tr>
        <%
            }
        %>
    </table>
    <%
        }
    %>

    <br/>
    <form action="manager.jsp">
        <button type="submit">Back to Dashboard</button>
    </form>
</body>
</html>
