<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Check for a valid session
    HttpSession sessionCheck = request.getSession(false);
    if (sessionCheck == null || sessionCheck.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Stop further execution
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        /* Global Styles */
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
            background-image: linear-gradient(to right, #333 0%, #2575fc 100%);
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
            img {
                height: 50px;
            }
        }


        /* Main Section */
        main {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        .admin-dashboard {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f0f0f0;
        }

        td:last-child {
            text-align: center;
        }

        .edit-btn, .delete-btn {
            display: inline-block;
            padding: 5px 10px;
            border: 1px solid #333;
            border-radius: 3px;
            background-color: #fff;
            color: #333;
            text-decoration: none;
            transition: background-color 0.3s ease, color 0.3s ease;
            margin-right: 5px;
        }

        .edit-btn:hover, .delete-btn:hover {
            background-color: #333;
            color: #fff;
        }

        /* Footer Section */
        footer {
            padding: 20px 0;
            background-color: #333;
            color: #fff;
            text-align: center;
            width: 100%;
            position: fixed;
            bottom: 0;
            left: 0;
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
</head>
<body>

<header>
    <div class="logo">
        <img src="images/home1.gif" alt="Bank Logo">
    </div>
    <nav>
        <ul>
            <li><a href="signup.jsp">Register a Customer</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
        <div class="nav-toggle">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </nav>
</header>

<main>
    <div class="admin-dashboard">
        <h2>Customer Data</h2>
        <table>
            <thead>
                <tr>
                    <th>Full Name</th>
                    <th>Address</th>
                    <th>Mobile Number</th>
                    <th>Email ID</th>
                    <th>Account Type</th>
                    <th>Date of Birth</th>
                    <th>ID Proof</th>
                    <th>Account Number</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Java code to fetch and display customer data -->
                <% 
                // Define your database connection details
                String jdbcUrl = "jdbc:mysql://localhost:3306/bank_application_db";
                String dbUser = "root";
                String dbPassword = "Shaikma@2408";
                
                try {
                    // Load and register JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Establish connection
                    Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                    
                    // Query to fetch customer data
                    String sql = "SELECT full_name, address, mobile_no, email_id, account_type, dob, id_proof, account_no " +
                                 "FROM customer ";
                    
                    // Create statement
                    Statement stmt = conn.createStatement();
                    
                    // Execute query
                    ResultSet rs = stmt.executeQuery(sql);
                    
                    // Iterate over result set and display data
                    while (rs.next()) {
                        String full_name = rs.getString("full_name");
                        String address = rs.getString("address");
                        String mobile_no = rs.getString("mobile_no");
                        String email_id = rs.getString("email_id");
                        String account_type = rs.getString("account_type");
                        Date dob = rs.getDate("dob");
                        String id_proof = rs.getString("id_proof");
                        String account_no = rs.getString("account_no");
                %>
                        <tr>
                            <td><%= full_name %></td>
                            <td><%= address %></td>
                            <td><%= mobile_no %></td>
                            <td><%= email_id %></td>
                            <td><%= account_type %></td>
                            <td><%= dob %></td>
                            <td><%= id_proof %></td>
                            <td><%= account_no %></td>
                            <td>
                                <a href="adminedit.jsp?full_name=<%= full_name %>&address=<%= address %>&mobile_no=<%= mobile_no %>&email_id=<%= email_id %>&account_type=<%= account_type %>&dob=<%= dob %>&id_proof=<%= id_proof %>&account_no=<%= account_no %>" class="edit-btn">Edit</a>
                                <a href="admindelete.jsp?full_name=<%= full_name %>&address=<%= address %>&mobile_no=<%= mobile_no %>&email_id=<%= email_id %>&account_type=<%= account_type %>&dob=<%= dob %>&id_proof=<%= id_proof %>&account_no=<%= account_no %>" class="edit-btn">Delete</a>
                            </td>
                        </tr>
                <% 
                    }
                    
                    // Close resources
                    rs.close();
                    stmt.close();
                    conn.close();
                    
                } catch (SQLException | ClassNotFoundException ex) {
                    ex.printStackTrace();
                    // Handle exceptions
                }
                %>
            </tbody>
        </table>
    </div>
</main>

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
