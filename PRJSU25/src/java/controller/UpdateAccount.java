/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author HA DUC
 */
public class UpdateAccount extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAccount at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Parse account ID
            int id = Integer.parseInt(request.getParameter("id"));

            // Create account object and selectively set fields if present
            Account acc = new Account();
            acc.setUsers_id(id);

            String uName = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String status = request.getParameter("status");
            String deptIdStr = request.getParameter("departmentId");

            if (uName != null && !uName.isBlank()) {
                acc.setU_name(uName);
            }
            if (email != null && !email.isBlank()) {
                acc.setEmail(email);
            }
            if (password != null && !password.isBlank()) {
                acc.setPassword(password);
            }
            if (role != null && !role.isBlank()) {
                acc.setRole(role);
            }
            if (status != null && !status.isBlank()) {
                acc.setStatus(status);
            }
            System.out.println("Submitted status = " + status);

            if (deptIdStr != null && !deptIdStr.isBlank()) {
                try {
                    acc.setDepartmentId(Integer.parseInt(deptIdStr));
                } catch (NumberFormatException ignored) {
                }
            }

            // Update in DB
            DAO dao = new DAO();
            dao.updateAccount(acc);

        } catch (NumberFormatException e) {
            System.err.println("Invalid account ID.");
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect after update
        response.sendRedirect(request.getContextPath() + "/manageAccount");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
