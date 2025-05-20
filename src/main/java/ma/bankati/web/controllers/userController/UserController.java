package ma.bankati.web.controllers.userController;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;
import ma.bankati.dao.userDao.IUserDao;
import ma.bankati.dao.userDao.jdbcDb.UserDaoJdbc;
import ma.bankati.model.users.ERole;
import ma.bankati.model.users.User;


public class UserController {

    private final IUserDao userDao;

    public UserController() {
        this.userDao = new UserDaoJdbc();
    }

    public void showAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = userDao.findAll();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
    }

    public void editForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        User user = userDao.findById(id);
        req.setAttribute("user", user);
        showAll(req, resp);
    }

    public void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        userDao.deleteById(id);
        resp.sendRedirect(req.getContextPath() + "/users");
    }

    public void saveOrUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        Long id = (idStr == null || idStr.isEmpty()) ? null : Long.parseLong(idStr);

        User user = User.builder()
                .id(id)
                .firstName(req.getParameter("firstName"))
                .lastName(req.getParameter("lastName"))
                .username(req.getParameter("username"))
                .password(req.getParameter("password"))
                .role(ERole.valueOf(req.getParameter("role")))
                .build();

        if (id == null) {
            userDao.save(user);
        } else {
            userDao.update(user);
        }

        resp.sendRedirect(req.getContextPath() + "/users");
    }
}