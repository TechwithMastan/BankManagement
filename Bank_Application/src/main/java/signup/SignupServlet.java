package signup;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String full_name = request.getParameter("full_name");
        String address = request.getParameter("address");
        String mobile_no = request.getParameter("mobile_no");
        String email_id = request.getParameter("email_id");
        String account_type = request.getParameter("account_type");
        String initial_balance = request.getParameter("initial_balance");
        String dob = request.getParameter("dob");
        String id_proof = request.getParameter("id_proof");

        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_application_db", "root", "Shaikma@2408");

            connection.setAutoCommit(false); // start transaction

            // Generate account number and temporary password
            long accountNumber = generateAccountNumber();
            String tempPassword = generateTempPassword();

            // Insert into customer table with account_no and temp_password
            String customerSql = "INSERT INTO customer (full_name, address, mobile_no, email_id, account_type, initial_balance, dob, id_proof, account_no, password) VALUES (?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement customerStatement = connection.prepareStatement(customerSql, Statement.RETURN_GENERATED_KEYS);
            customerStatement.setString(1, full_name);
            customerStatement.setString(2, address);
            customerStatement.setString(3, mobile_no);
            customerStatement.setString(4, email_id);
            customerStatement.setString(5, account_type);
            customerStatement.setString(6, initial_balance);
            customerStatement.setString(7, dob);
            customerStatement.setString(8, id_proof);
            customerStatement.setLong(9, accountNumber);
            customerStatement.setString(10, tempPassword);

            customerStatement.executeUpdate();

            connection.commit(); // commit transaction

            response.sendRedirect("admin.jsp");
        } catch (ClassNotFoundException e) {
            out.println("Error: " + e.getMessage());
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    out.println("Error rolling back transaction: " + ex.getMessage());
                }
            }
            out.println("Error: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close(); // close connection
                } catch (SQLException e) {
                    out.println("Error closing connection: " + e.getMessage());
                }
            }
            out.close();
        }
    }

    private long generateAccountNumber() {
        return (long) (Math.random() * 9_000_000_000_000L) + 1_000_000_000_000L;
    }

    private String generateTempPassword() {
        return Long.toHexString((long) (Math.random() * 1000000000));
    }
}
