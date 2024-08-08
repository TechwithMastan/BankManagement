package generatePdf;

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

import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@WebServlet("/GeneratePDFServlet")
public class GeneratePDFServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("account_no");

        String jdbcUrl = "jdbc:mysql://localhost:3306/bank_application_db";
        String dbUser = "root";
        String dbPassword = "Shaikma@2408";

        Connection conn = null;
        PreparedStatement transactionStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            String transactionQuery = "SELECT transaction_type, amount, transaction_date FROM transactions WHERE account_no = ? ORDER BY transaction_date DESC LIMIT 10";
            transactionStmt = conn.prepareStatement(transactionQuery);
            transactionStmt.setString(1, accountNo);
            rs = transactionStmt.executeQuery();

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=transactions.pdf");

            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());

            document.open();
            document.add(new Paragraph("Last 10 Transactions for Account No: " + accountNo));
            document.add(new Paragraph(" ")); // Empty line

            PdfPTable table = new PdfPTable(3);
            table.addCell("Transaction Type");
            table.addCell("Amount");
            table.addCell("Transaction Date");

            while (rs.next()) {
                table.addCell(rs.getString("transaction_type"));
                table.addCell(String.valueOf(rs.getDouble("amount")));
                table.addCell(rs.getString("transaction_date"));
            }

            document.add(table);
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Error generating PDF: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (transactionStmt != null) transactionStmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
