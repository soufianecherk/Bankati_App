package ma.bankati.web.controllers.creditController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.bankati.dao.creditDao.IDemandeCreditDao;

import java.io.IOException;

@WebServlet(name = "CreditAdminController", urlPatterns = {"/credit-requests"})
public class CreditAdminController extends HttpServlet {

    private IDemandeCreditDao demandeCreditDao;

    @Override
    public void init() throws ServletException {
        Object dao = getServletContext().getAttribute("creditDao");
        if (dao instanceof IDemandeCreditDao) {
            this.demandeCreditDao = (IDemandeCreditDao) dao;
        } else {
            throw new ServletException("creditDao non disponible ou de type incorrect dans le ServletContext.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            long id = Long.parseLong(req.getParameter("id"));
            switch (action) {
                case "accepter" -> demandeCreditDao.approuver(id);
                case "refuser" -> demandeCreditDao.refuser(id);
                default -> {
                    // action inconnue
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/admin/credit-requests");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("demandes", demandeCreditDao.listerToutes());
        req.getRequestDispatcher("/admin/credit-requests.jsp").forward(req, resp);
    }
}