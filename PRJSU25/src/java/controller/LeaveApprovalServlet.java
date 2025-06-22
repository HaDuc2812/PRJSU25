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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author HA DUC
 */
public class LeaveApprovalServlet extends HttpServlet {

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
            out.println("<title>Servlet LeaveApprovalServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LeaveApprovalServlet at " + request.getContextPath() + "</h1>");
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
    ;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Step 1: Parse the request ID and action
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");

        // Step 2: Get session and check user_id
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            // If session is invalid or expired, redirect to login
            response.sendRedirect("Login.jsp");
            return;
        }

        int adminId = ((Integer) session.getAttribute("user_id")).intValue();

        // Step 3: Approve or reject leave
        DAO d = new DAO();
        if ("approve".equalsIgnoreCase(action)) {
            boolean update = d.approveLeaveRequest(requestId, adminId);
            // (Optional) You can set a success message to display later
        } else if ("reject".equalsIgnoreCase(action)) {
            d.rejectLeaveRequest(requestId, adminId);
        }

        // Step 4: Redirect back to admin dashboard
        response.sendRedirect("Admin.jsp");
        System.out.println("DEBUG: action = " + action);
        System.out.println("DEBUG: requestId = " + requestId);
        System.out.println("DEBUG: adminId = " + adminId);

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
