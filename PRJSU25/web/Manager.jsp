<%-- 
    Document   : Manager
    Created on : Jun 12, 2025, 8:19:19 AM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
    String role = (String) session.getAttribute("role");
    if (role == null || !"manager".equals(role)) {
        response.sendRedirect("Homepage.jsp");  // or Login.jsp
        return;
    }
    %>
    <!-- Admin page content -->
    <h2>Welcome, Admin!</h2>

</html>
