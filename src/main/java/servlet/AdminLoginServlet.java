package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminDao;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDao adminDAO;

    public void init() {
        setAdminDAO(new AdminDao());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean valid = adminDAO.validate(username, password);

        if (valid) {
            response.sendRedirect("adminloginsuccess.jsp");
        } else {
            response.sendRedirect("adminloginfailure.jsp");
        }
    }

	public AdminDao getAdminDAO() {
		return adminDAO;
	}

	public void setAdminDAO(AdminDao adminDAO) {
		this.adminDAO = adminDAO;
	}
}
