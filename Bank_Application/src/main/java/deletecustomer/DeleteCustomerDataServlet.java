package deletecustomer;

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

@WebServlet("/DeleteCustomerDataServlet")
public class DeleteCustomerDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve account_no from the request
        String account_no = request.getParameter("account_no");

        // Database connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/bank_application_db";
        String dbUser = "root";
        String dbPassword = "Shaikma@2408";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load and register JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to delete the customer
            String sql = "DELETE FROM customer WHERE account_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account_no);

            // Execute the delete operation
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Redirect to the admin dashboard with a success message
                response.sendRedirect("admin.jsp?message=Customer+deleted+successfully");
            } else {
                // Redirect to the admin dashboard with an error message
                response.sendRedirect("admin.jsp?message=Error+deleting+customer");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Redirect to the admin dashboard with an error message
            response.sendRedirect("admin.jsp?message=Error+deleting+customer");
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

