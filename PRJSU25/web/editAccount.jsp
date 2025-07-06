<%@ page import="model.Account" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Account acc = (Account) request.getAttribute("acc");
%>
<html>
    <head>
        <title>Edit Account</title>
    </head>
    <body>
        <% if (acc != null) { %>
        <h2>Edit Account</h2>
        <form method="post" action="${pageContext.request.contextPath}/updateAccount">
            <input type="hidden" name="id" value="<%= acc.getUsers_id() %>" />
            <label>Name:</label>
            <input type="text" name="name" value="<%= acc.getU_name() %>" /><br/>
            <label>Email:</label>
            <input type="email" name="email" value="<%= acc.getEmail() %>" /><br/>
            <label>Role:</label>
            <input type="text" name="role" value="<%= acc.getRole() %>" /><br/>
            <label>Status:</label>
            <input type="text" name="status" value="<%= acc.getStatus() %>" /><br/>
            <label>Department ID:</label>
            <input type="text" name="departmentId" value="<%= acc.getDepartmentId() %>" /><br/>
            <button type="submit">Update</button>
        </form>
        <% } else { %>
        <p style="color:red;">Account data not found. Please return to <a href="Manager.jsp">Manager</a>.</p>
        <% } %>
    </body>
</html>
