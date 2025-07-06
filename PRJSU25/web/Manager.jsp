<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="model.Account" %>
<%
    Account acc = (Account) session.getAttribute("account");
    if (acc == null || !"manager".equalsIgnoreCase((String) session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manager Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
        }

        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            height: 100vh;
            padding: 20px 0;
            color: white;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .sidebar a {
            display: block;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            transition: background 0.3s;
        }

        .sidebar a:hover {
            background-color: #34495e;
        }

        .content {
            flex: 1;
            padding: 20px;
        }

        .header {
            font-size: 24px;
            margin-bottom: 20px;
        }

    </style>
</head>
<body>
    <div class="sidebar">
        <h2>Manager</h2>
        <a href="ApproveRequest.jsp">✅ Approve Requests</a>
        <a href="ViewRequest.jsp">📄 View All Requests</a>
    </div>

    <div class="content">
        <div class="header">Welcome, <%= acc.getU_name() %>!</div>
        <p>Select a feature from the sidebar to get started.</p>
    </div>
</body>
</html>
