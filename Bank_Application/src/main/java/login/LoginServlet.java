package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String keepSignedIn = request.getParameter("checkbox-1-1");

        String jdbcUrl = "jdbc:mysql://localhost:3306/bank_application_db";
        String dbUser = "root";
        String dbPassword = "Shaikma@2408";

        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, username);
                stmt.setString(2, password);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Valid credentials, create or retrieve session
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);

                    if ("on".equals(keepSignedIn)) {
                        // Keep signed in for 7 days
                        session.setMaxInactiveInterval(60 * 60 * 24 * 7); // 7 days
                    } else {
                        // Default session timeout
                        session.setMaxInactiveInterval(30 * 60); // 30 minutes
                    }

                    // Check if session exists and username is set
                    if (session.getAttribute("username") != null) {
                        response.sendRedirect("admin.jsp");
                        return; // Redirect and exit method
                    }
                }

                // Invalid credentials
                String errorMessage = "Invalid username or password. Please try again.";
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("login.jsp").forward(request, response);

            } catch (SQLException ex) {
                ex.printStackTrace();
                throw new ServletException("Database access error", ex);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("MySQL JDBC Driver not found", e);
        }
    }
}
