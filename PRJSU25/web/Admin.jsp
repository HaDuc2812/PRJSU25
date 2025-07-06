<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Account" %>
<%
    Account currentAccount = (Account) session.getAttribute("account");
    String role = (String) session.getAttribute("role");
    if (currentAccount == null || role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                display: flex;
                height: 100vh;
            }
            .sidebar {
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
            .main-content {
                flex: 1;
                padding: 30px;
                background-color: #ecf0f1;
            }
        </style>
    </head>
    <body>
        <jsp:include page="SideBar.jsp"></jsp:include>
        <div class="main-content">
            <h1>Welcome, <%= currentAccount.getU_name() %></h1>
            <p>Select an option from the sidebar to manage the system.</p>
        </div>
    </body>
</html>
