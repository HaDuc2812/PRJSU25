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
import model.Users;

/**
 *
 * @author HA DUC
 */
public class LoginServlet extends HttpServlet {

    DAO d = new DAO();

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
        response.sendRedirect("Login.jsp");
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

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        DAO dao = new DAO();
        Users user = dao.login(username, password);

        if (user == null) {
            request.setAttribute("mess", "Invalid username or password.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        String role = user.getRole();
        if (role == null) {
            request.setAttribute("mess", "Your account does not have a role assigned.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        // Save to session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // Normalize and redirect
        role = role.trim().toLowerCase();

        switch (role) {
            case "admin":
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/Admin.jsp");
                break;
            case "manager":
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/Manager.jsp");
                break;
            case "employee":
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/Employees.jsp");
                break;
            default:
                request.setAttribute("mess", "Unknown role: " + role);
                request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
        
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
