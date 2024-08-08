package transactionservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String transactionAction = request.getParameter("transactionAction");
        String accountNo = request.getParameter("account_no");
        double amount = Double.parseDouble(request.getParameter("amount"));

        String jdbcUrl = "jdbc:mysql://localhost:3306/bank_application_db";
        String dbUser = "root";
        String dbPassword = "Shaikma@2408";

        Connection conn = null;
        PreparedStatement balanceStmt = null;
        PreparedStatement updateBalanceStmt = null;
        PreparedStatement transactionStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            String balanceQuery = "SELECT initial_balance FROM customer WHERE account_no = ?";
            balanceStmt = conn.prepareStatement(balanceQuery);
            balanceStmt.setString(1, accountNo);
            rs = balanceStmt.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("initial_balance");
                double newBalance;

                if (transactionAction.equals("deposit")) {
                    newBalance = currentBalance + amount;
                } else if (transactionAction.equals("withdraw")) {
                    newBalance = currentBalance - amount;
                    if (newBalance < 0) {
                        // Send a script to the client to show a pop-up error message
                        response.setContentType("text/html");
                        response.getWriter().println("<html><body>");
                        response.getWriter().println("<script type='text/javascript'>");
                        response.getWriter().println("alert('Insufficient balance!');");
                        response.getWriter().println("window.location.href = 'dashboard.jsp';"); // Adjust this as needed
                        response.getWriter().println("</script>");
                        response.getWriter().println("</body></html>");
                        return;
                    }
                } else {
                    response.getWriter().println("Invalid transaction action!");
                    return;
                }

                String updateBalanceQuery = "UPDATE customer SET initial_balance = ? WHERE account_no = ?";
                updateBalanceStmt = conn.prepareStatement(updateBalanceQuery);
                updateBalanceStmt.setDouble(1, newBalance);
                updateBalanceStmt.setString(2, accountNo);
                updateBalanceStmt.executeUpdate();

                String transactionQuery = "INSERT INTO transactions (account_no, transaction_type, amount) VALUES (?, ?, ?)";
                transactionStmt = conn.prepareStatement(transactionQuery);
                transactionStmt.setString(1, accountNo);
                transactionStmt.setString(2, transactionAction);
                transactionStmt.setDouble(3, amount);
                transactionStmt.executeUpdate();

                response.sendRedirect("dashboard.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error processing transaction: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (balanceStmt != null) balanceStmt.close();
                if (updateBalanceStmt != null) updateBalanceStmt.close();
                if (transactionStmt != null) transactionStmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
