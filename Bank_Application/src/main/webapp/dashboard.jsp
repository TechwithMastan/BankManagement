<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Check for a valid session
    HttpSession sessionCheck = request.getSession(false);
    if (sessionCheck == null || sessionCheck.getAttribute("account_no") == null) {
        response.sendRedirect("Customerlogin.jsp");
        return; // Stop further execution
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: linear-gradient(to right, #333 0%, #2575fc 100%);
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-image: radial-gradient(circle at 10% 20%, rgb(98, 114, 128) 0%, rgb(52, 63, 51) 90.1%);
            color: white;
            padding: 10px 20px;
        }
        .header h1 {
            margin: 0;
        }
        .header .logo {
            display: flex;
            align-items: center;
        }
        .header .logo img {
            height: 50px;
            cursor: pointer;
        }
        .header .actions {
            display: flex;
            align-items: center;
        }
        .header .actions button {
            margin-left: 10px;
            background-image: radial-gradient(circle at 10% 20%, rgb(98, 114, 128) 0%, rgb(52, 63, 51) 90.1%);
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            color: white;
        }
        .header .actions button:hover {
            background-color: #4082f5;
        }
        .customer-details {
            margin-top: 20px;
        }
        .customer-details table {
            width: 100%;
            border-collapse: collapse;
        }
        .customer-details table, .customer-details th, .customer-details td {
            border: 1px solid #ddd;
        }
        .customer-details th, .customer-details td {
            padding: 8px;
            text-align: left;
        }
        .buttons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .buttons button {
            padding: 10px 20px;
            background-image: radial-gradient(circle at 10% 20%, rgb(98, 114, 128) 0%, rgb(52, 63, 51) 90.1%);
            color: white;
            border: none;
            cursor: pointer;
        }
        .buttons button:hover {
            background-color: #45a049;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 40%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script>
        function openModal(action) {
            document.getElementById('modalTitle').innerText = action === 'deposit' ? 'Deposit Amount' : 'Withdraw Amount';
            document.getElementById('transactionAction').value = action;
            document.getElementById('myModal').style.display = "block";
        }

        function closeModal() {
            document.getElementById('myModal').style.display = "none";
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo">
                <img src="images/home1.gif" alt="Bank Logo" onclick="location.href='Home.jsp'">
            </div>
            <div class="actions">
                <button onclick="changePassword('<%= request.getSession().getAttribute("account_no") %>')">Change Password</button>
                <button onclick="location.href='customerLogout.jsp'">Logout</button>
                <button onclick="deleteAccount(<%= request.getSession().getAttribute("account_no") %>)">Delete Account</button>
                <form id="deleteForm" action="customerDelete.jsp" method="post" style="display: none;">
                    <input type="hidden" id="accountNo" name="accountNo">
                </form>
                <script>
                    function changePassword(accountNo) {
                        window.location.href = 'passwordChange.jsp?account_no=' + accountNo;
                    }
                    
                    function deleteAccount(accountNo) {
                        document.getElementById('accountNo').value = accountNo;
                        document.getElementById('deleteForm').submit();
                    }
                </script>
            </div>
        </div>
        <div class="customer-details">
            <% 
                String accountNo = (String) request.getSession().getAttribute("account_no");
                if (accountNo != null) {
                    String jdbcUrl = "jdbc:mysql://localhost:3306/bank_application_db";
                    String dbUser = "root";
                    String dbPassword = "Shaikma@2408";
                    
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                        String sql = "SELECT full_name, address, mobile_no, email_id, account_type, initial_balance, dob, id_proof, account_no FROM customer WHERE account_no = ?";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        stmt.setString(1, accountNo);
                        ResultSet rs = stmt.executeQuery();

                        if (rs.next()) {
            %>
            <table>
                <tr><th>Full Name</th><td><%= rs.getString("full_name") %></td></tr>
                <tr><th>Address</th><td><%= rs.getString("address") %></td></tr>
                <tr><th>Mobile No</th><td><%= rs.getString("mobile_no") %></td></tr>
                <tr><th>Email ID</th><td><%= rs.getString("email_id") %></td></tr>
                <tr><th>Account Type</th><td><%= rs.getString("account_type") %></td></tr>
                <tr><th>Balance</th><td><%= rs.getString("initial_balance") %></td></tr>
                <tr><th>Date of Birth</th><td><%= rs.getString("dob") %></td></tr>
                <tr><th>ID Proof</th><td><%= rs.getString("id_proof") %></td></tr>
                <tr><th>Account No</th><td><%= rs.getString("account_no") %></td></tr>
            </table>
            <% 
                        } else {
                            out.println("<p>No customer details found for account number: " + accountNo + "</p>");
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<p>Error retrieving customer details: " + e.getMessage() + "</p>");
                        e.printStackTrace();
                    }
                } else {
                    out.println("<p>Account number is not available.</p>");
                }
            %>
        </div>
        <div class="buttons">
            <button onclick="openModal('deposit')">Deposit</button>
            <form action="GeneratePDFServlet" method="get">
        <input type="hidden" name="account_no" value="<%= session.getAttribute("account_no") %>">
        <button type="submit">Transaction history</button>
    </form>
            <button onclick="openModal('withdraw')">Withdraw</button>
        </div>
    </div>

    <!-- The Modal -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2 id="modalTitle">Transaction</h2>
            <form action="TransactionServlet" method="post">
                <label for="amount">Amount:</label>
                <input type="number" id="amount" name="amount" required>
                <input type="hidden" id="transactionAction" name="transactionAction">
                <input type="hidden" name="account_no" value="<%= accountNo %>">
                <button type="submit">Submit</button>
            </form>
        </div>
    </div>
</body>
</html>
