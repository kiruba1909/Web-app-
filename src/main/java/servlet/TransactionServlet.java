package servlet;



import dao.withdrawDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/transactionHistory")
public class TransactionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accno = req.getParameter("accno");
        ResultSet rs = (ResultSet) withdrawDao.getTransactionHistory(accno);

        req.setAttribute("transactionHistory", rs);
        req.getRequestDispatcher("/transactionHistory.jsp").forward(req, resp);
    }
}
