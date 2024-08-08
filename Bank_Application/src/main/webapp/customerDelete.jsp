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
    <title>Delete Customer</title>
    <style>
    
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f9f9f9;
            background-image: radial-gradient(circle at 10% 20%, rgb(98, 114, 128) 0%, rgb(52, 63, 51) 90.1%);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        h1, h2, h3, h4, h5, h6 {
            font-weight: bold;
            color: #212121;
        }

        p {
            margin-bottom: 20px;
        }

        button {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #3e8e41;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #3e8e41;
        }

        /* Header Section */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        nav {
            display: flex;
            align-items: center;
        }

        nav ul {
            display: flex;
            list-style: none;
        }

        nav li {
            margin-right: 20px;
        }

        .nav-toggle {
            display: none;
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo img {
            height: 50px;
            cursor: pointer;
        }

        .logout-button {
            margin-left: auto;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
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
        .button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
        }
        .button:hover {
            background-color: #ff6666;
        }
        footer {
            padding: 20px 0;
            background-color: #333;
            color: #fff;
            text-align: center;
            margin-top: auto;
        }

        footer p {
            margin-bottom: 20px;
        }

        footer ul {
            list-style: none;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        footer li {
            margin: 0 10px;
        }

        footer a {
            color: #fff;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        footer a:hover {
            color: #3e8e41;
        }
    </style>
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete your account?");
        }
    </script>
</head>
<body>
<header>
    <div class="logo" onclick="location.href='dashboard.jsp'">
        <img src="images/home1.gif" alt="Bank Logo">
    </div>
    <nav>
        <ul>
            <!-- Removed Register a Customer link -->
        </ul>
        <a href="logout.jsp" class="logout-button">Logout</a>
    </nav>
</header>

    <div class="container">
        <h1>Delete Customer</h1>
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
                        String sql = "SELECT * FROM customer WHERE account_no = ?";
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
            <form action="DeleteCustomerServlet" method="post">
                <input type="hidden" name="account_no" value="<%= rs.getString("account_no") %>">
                <button type="submit"  onclick="return confirmDelete()" class="button">Delete Account</button>
            </form>
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
    </div>
    
    <footer>
    <p>&copy; 2024 Mastan Bank Application. All rights reserved.</p>
    <ul>
        <li><a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
        <li><a href="#" target="_blank"><i class="fab fa-twitter"></i></a></li>
        <li><a href="#" target="_blank"><i class="fab fa-instagram"></i></a></li>
    </ul>
</footer>
</body>
</html>
