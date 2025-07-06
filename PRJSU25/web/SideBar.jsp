<%-- 
    Document   : SideBar
    Created on : Jul 6, 2025, 3:40:14 PM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        sidebar {
                width: 250px;
                background-color: #2c3e50;
                color: white;
                padding-top: 20px;
            }
            .sidebar h2 {
                text-align: center;
                margin-bottom: 30px;
            }
            .sidebar a {
                display: block;
                padding: 15px 20px;
                color: white;
                text-decoration: none;
            }
            .sidebar a:hover {
                background-color: #34495e;
            }
    </style>
     <div class="sidebar">
            <h2>Admin Panel</h2>
            <a href="${pageContext.request.contextPath}/manageAccount">Manage Accounts</a>
            <a href="viewReports.jsp">View Reports</a>
            <a href="settings.jsp">Settings</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
</html>
