package Customerlogin;

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

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account_no = request.getParameter("account_no");
        String temp_password = request.getParameter("temp_password");
        String keepSignedIn = request.getParameter("checkbox-1-1");

        // JDBC connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/bank_application_db";
        String dbUser = "root";
        String dbPassword = "Shaikma@2408";

        String sql = "SELECT * FROM customer WHERE account_no = ? AND password = ?";

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, account_no);
                stmt.setString(2, temp_password);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // User found, create session and set timeout
                        HttpSession session = request.getSession();
                        session.setAttribute("account_no", account_no);

                        if ("on".equals(keepSignedIn)) {
                            // Set session to never expire (or a very long time)
                            session.setMaxInactiveInterval(60 * 60 * 24 * 7); // 7 days
                        } else {
                            // Set session timeout to default (or a reasonable time)
                            session.setMaxInactiveInterval(30 * 60); // 30 minutes
                        }

                        // Forward to dashboard.jsp with account_no as request attribute
                        request.setAttribute("account_no", account_no);
                        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
                    } else {
                        // User not found, show error message on login page
                        String errorMessage = "Invalid account no or password. Please try again.";
                        request.setAttribute("errorMessage", errorMessage);
                        request.getRequestDispatcher("Customerlogin.jsp").forward(request, response);
                    }
                }

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
