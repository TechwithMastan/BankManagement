package passwordChange;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PasswordChangeServlet")
public class PasswordChangeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account_no = request.getParameter("account_no");
        String current_password = request.getParameter("current_password");
        String new_password = request.getParameter("new_password");
        String confirm_password = request.getParameter("confirm_password");

        // JDBC connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/bank_application_db";
        String dbUser = "root";
        String dbPassword = "Shaikma@2408";

        String sql = "UPDATE customer SET password = ? WHERE account_no = ? AND password = ?";

        if (new_password.equals(confirm_password)) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                     PreparedStatement stmt = conn.prepareStatement(sql)) {

                    stmt.setString(1, new_password);
                    stmt.setString(2, account_no);
                    stmt.setString(3, current_password);

                    int rowsUpdated = stmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        // Password updated successfully
                        response.sendRedirect("dashboard.jsp");
                    } else {
                        // Incorrect current password
                        String errorMessage = "Current password is incorrect. Please try again.";
                        request.setAttribute("errorMessage", errorMessage);
                        request.getRequestDispatcher("passwordChange.jsp").forward(request, response);
                    }

                } catch (SQLException ex) {
                    ex.printStackTrace();
                    throw new ServletException("Database access error", ex);
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                throw new ServletException("MySQL JDBC Driver not found", e);
            }
        } else {
            // Passwords do not match
            String errorMessage = "New passwords do not match. Please try again.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("passwordChange.jsp").forward(request, response);
        }
    }
}
