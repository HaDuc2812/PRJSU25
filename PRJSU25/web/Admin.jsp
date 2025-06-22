<%-- 
    Document   : Admin
    Created on : Jun 12, 2025, 8:19:28 AM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.LeaveRequest" %>
<%@page import="dal.DAO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
   <%
   
    if (session == null || session.getAttribute("role") == null || !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp");
        return;
    }

    out.println("DEBUG role = " + session.getAttribute("role"));
    out.println("DEBUG user_id = " + session.getAttribute("user_id"));

    DAO d = new DAO();
    List<LeaveRequest> list = d.getAllLeaveRequest();
%>

    <!-- Admin page content -->
    <head><title> Leave Requests</title></head>
    <table border="1">
        <tr>
            <th>Users</th>
            <th>Type</th>
            <th>Start date</th>
            <th>End date</th>
            <th>Reason</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <%
            for(LeaveRequest r : list){
            if("pending".equals(r.getStatus())){
        %>
        <tr>
            <td><%= r.getUserId() %></td>
            <td><%= r.getLeaveTypeId() %></td>
            <td><%= r.getStartDate() %></td>
            <td><%= r.getEndDate() %></td>
            <td><%= r.getReason() %></td>
            <td><%= r.getStatus() %></td>
            <td>
                <form action="leaveapproval" method="post">
                    <input type="hidden" name="requestId" value="<%= r.getId() %>"/>
                    <button name="action" value="approve">Approve</button>
                    <button name="action" value="reject">Reject</button>
                </form>
            </td>
        </tr>
        <%
            }
        }
        %>
    </table>



</html>
