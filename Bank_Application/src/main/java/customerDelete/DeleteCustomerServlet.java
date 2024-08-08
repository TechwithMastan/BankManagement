package customerDelete;

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

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account_no = request.getParameter("account_no");

        // JDBC connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/bank_application_db";
        String dbUser = "root";
        String dbPassword = "Shaikma@2408";

        String checkBalanceSQL = "SELECT initial_balance FROM customer WHERE account_no = ?";
        String deleteCustomerSQL = "DELETE FROM customer WHERE account_no = ?";
        String deleteTransactionSQL = "DELETE FROM transactions WHERE account_no = ?";

        Connection conn = null;
        PreparedStatement checkBalanceStmt = null;
        PreparedStatement deleteCustomerStmt = null;
        PreparedStatement deleteTransactionStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            conn.setAutoCommit(false); // Set auto-commit to false for transaction

            // Check balance before deletion
            checkBalanceStmt = conn.prepareStatement(checkBalanceSQL);
            checkBalanceStmt.setString(1, account_no);
            rs = checkBalanceStmt.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("initial_balance");

                if (balance == 0) {
                    // Delete customer record
                    deleteCustomerStmt = conn.prepareStatement(deleteCustomerSQL);
                    deleteCustomerStmt.setString(1, account_no);
                    int rowsDeletedCustomer = deleteCustomerStmt.executeUpdate();

                    // Delete related transaction records
                    deleteTransactionStmt = conn.prepareStatement(deleteTransactionSQL);
                    deleteTransactionStmt.setString(1, account_no);
                    int rowsDeletedTransactions = deleteTransactionStmt.executeUpdate();

                    if (rowsDeletedCustomer > 0 && rowsDeletedTransactions > 0) {
                        conn.commit(); // Commit transaction if successful
                        
                        // End session
                        HttpSession session = request.getSession(false);
                        if (session != null) {
                            session.invalidate(); // Invalidate session
                        }
                        
                        response.sendRedirect("Home.jsp"); // Redirect to Home.jsp after deletion
                    } else {
                        conn.rollback(); // Rollback transaction if deletion failed
                        response.sendRedirect("error.jsp"); // Redirect to an error page
                    }
                } else {
                    // Display error message if balance is not zero
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().println("<script>alert('Cannot delete account. Balance must be zero.');</script>");
                    response.getWriter().println("<script>window.location='dashboard.jsp';</script>");
                }
            } else {
                // Handle case where account_no does not exist
                response.sendRedirect("error.jsp"); // Redirect to an error page
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkBalanceStmt != null) checkBalanceStmt.close();
                if (deleteCustomerStmt != null) deleteCustomerStmt.close();
                if (deleteTransactionStmt != null) deleteTransactionStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
