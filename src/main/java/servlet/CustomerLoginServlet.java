package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Perform validation (e.g., check username and password against the database)
        // For demonstration, let's assume validation is successful.

        if (username != null && !username.isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("Username", username);
            response.sendRedirect("Welcome.jsp");
        } else {
            response.sendRedirect("customerlogin.jsp");
        }
    }
}