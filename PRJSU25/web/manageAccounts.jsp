<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Account" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Account currentAccount = (Account) session.getAttribute("account");
    String role = (String) session.getAttribute("role");
    if (currentAccount == null || role == null || !"admin".equals(role)) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Accounts</title>
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
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ccc;
            }
            th {
                background-color: #2980b9;
                color: white;
            }
            a.button {
                padding: 5px 10px;
                background-color: #27ae60;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                margin-right: 5px;
            }
            a.button.delete {
                background-color: #c0392b;
            }
        </style>
    </head>
    <script>
        function openEditModal(id, name, email, role, status, dept) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-name').value = name;
            document.getElementById('edit-email').value = email;
            document.getElementById('edit-role').value = role;
            document.getElementById('edit-status').value = status;
            document.getElementById('edit-dept').value = dept;

            document.getElementById('editModal').style.display = 'block';
            document.getElementById('modalOverlay').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('editModal').style.display = 'none';
            document.getElementById('modalOverlay').style.display = 'none';
        }
        function openCreateModal() {
            document.getElementById('createForm').reset();
            document.getElementById('createModal').style.display = 'block';
            document.getElementById('modalOverlay').style.display = 'block';
        }
    </script>
    <body>
        <jsp:include page="SideBar.jsp"></jsp:include>
            <div class="main-content">
                <h1>Manage Accounts</h1>
                <button onclick="openCreateModal()" class="button" style="margin-bottom: 20px;">Create Account</button><br/>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Departments</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="acc" items="${accountList}">
                        <tr>
                            <td><c:out value="${acc.users_id}"/></td>
                            <td><c:out value="${acc.u_name}"/></td>
                            <td><c:out value="${acc.email}"/></td>
                            <td><c:out value="${acc.role}"/></td>
                            <td><c:out value="${acc.status}"/></td>
                            <td><c:out value="${acc.departmentName}"/></td>
                            <td>
                                <a href="javascript:void(0);"
                                   class="button"
                                   onclick="openEditModal('${acc.users_id}', '${acc.u_name}', '${acc.email}', '${acc.role}', '${acc.status}', '${acc.departmentId}')">
                                    Edit
                                </a>

                                <a href="${pageContext.request.contextPath}/deleteAccount?id=${acc.users_id}"
                                   class="button delete"
                                   onclick="return confirm('Are you sure you want to delete this account?');">
                                    Delete
                                </a>                            
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>

            </table>
        </div>
        <!-- Edit Form Modal -->
        <div id="editModal" style="display:none; position:fixed; top:20%; left:30%; width:40%; background:#fff; border:1px solid #ccc; padding:20px; z-index:1000;">
            <h3>Edit Account</h3>
            <form method="post" action="${pageContext.request.contextPath}/updateAcc">
                <input type="hidden" name="id" id="edit-id">
                <label>Name:</label><br>
                <input type="text" name="name" id="edit-name"><br>
                <label>Email:</label><br>
                <input type="email" name="email" id="edit-email"><br>
                <label>Role:</label><br>
                <input type="text" name="role" id="edit-role"><br>
                <label>Status:</label><br>
                <input type="text" name="status" id="edit-status"><br>
                <label>Department ID:</label><br>
                <input type="text" name="departmentId" id="edit-dept"><br><br>
                <button type="submit">Update</button>
                <button type="button" onclick="closeModal()">Cancel</button>
            </form>
        </div>
        <div id="modalOverlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:#00000066; z-index:999;" onclick="closeModal()"></div>
        <!-- Create Account Modal -->
        <div id="createModal" style="display:none; position:fixed; top:25%; left:30%; width:40%; background:#fff; border:1px solid #ccc; padding:20px; z-index:1000;">
            <h3>Create Account</h3>
            <form id="createForm" method="post" action="${pageContext.request.contextPath}/createAcc">
                <label>Name:</label><br>
                <input type="text" name="name" required><br>
                <label>Email:</label><br>
                <input type="email" name="email" required><br>
                <label>Password:</label><br>
                <input type="password" name="password" required><br>
                <label>Role:</label><br>
                <input type="text" name="role" required><br>
                <label>Status:</label><br>
                <input type="text" name="status" required><br>
                <label>Department ID:</label><br>
                <input type="text" name="departmentId" required><br><br>
                <button type="submit">Create</button>
                <button type="button" onclick="closeModal()">Cancel</button>
            </form>
        </div>
    </body>
</html>
