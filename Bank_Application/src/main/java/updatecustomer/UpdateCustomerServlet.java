package updatecustomer;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String full_name = request.getParameter("full_name");
        String address = request.getParameter("address");
        String mobile_no = request.getParameter("mobile_no");
        String email_id = request.getParameter("email_id");
        String account_type = request.getParameter("account_type");
        String dob = request.getParameter("dob");
        String id_proof = request.getParameter("id_proof");
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
            System.out.println("Connected to database successfully.");

            // SQL query to update customer details
            String updateCustomerQuery = "UPDATE customer SET full_name=?, address=?, mobile_no=?, email_id=?, account_type=?, dob=?, id_proof=? WHERE account_no = ?";

            // Create PreparedStatement
            pstmt = conn.prepareStatement(updateCustomerQuery);

            // Set parameters
            pstmt.setString(1, full_name);
            pstmt.setString(2, address);
            pstmt.setString(3, mobile_no);
            pstmt.setString(4, email_id);
            pstmt.setString(5, account_type);
            pstmt.setString(6, dob);
            pstmt.setString(7, id_proof);
            pstmt.setString(8, account_no);

            // Execute update
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Update successful
                response.sendRedirect("admin.jsp"); // Redirect to admin dashboard or appropriate page
            } else {
                // Update failed
                response.getWriter().println("Failed to update customer details.");
            }

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
            // Handle any exceptions
            response.getWriter().println("Error: " + ex.getMessage());
        } finally {
            // Close resources
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
