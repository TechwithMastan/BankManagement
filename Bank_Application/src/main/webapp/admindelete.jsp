<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Customer Details</title>
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

        /* Main Section */
        main {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        .edit-form {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .edit-form h2 {
            margin-bottom: 20px;
        }

        .edit-form label {
            display: block;
            margin-bottom: 10px;
        }

        .edit-form input[type="text"],
        .edit-form input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        /* Footer Section */
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
            return confirm("Are you sure you want to delete this customer?");
        }
    </script>
</head>
<body>

<header>
    <div class="logo" onclick="location.href='admin.jsp'">
        <img src="images/home1.gif" alt="Bank Logo">
    </div>
    <nav>
        <ul>
            <!-- Removed Register a Customer link -->
        </ul>
        <a href="logout.jsp" class="logout-button">Logout</a>
    </nav>
</header>

<main>
    <div class="edit-form">
        <h2>Edit Customer Details</h2>
        <% 
        // Retrieve parameters from URL
        String full_name = request.getParameter("full_name");
        String address = request.getParameter("address");
        String mobile_no = request.getParameter("mobile_no");
        String email_id = request.getParameter("email_id");
        String account_type = request.getParameter("account_type");
        String dob = request.getParameter("dob");
        String id_proof = request.getParameter("id_proof");
        String account_no = request.getParameter("account_no");
        %>

    <form action="DeleteCustomerDataServlet" method="post">
    
    <label for="full_name">Full Name:</label>
    <input type="text" id="full_name" name="full_name" value="<%= full_name %>" readonly>

    <label for="address">Address:</label>
    <input type="text" id="address" name="address" value="<%= address %>" readonly>

    <label for="mobile_no">Mobile Number:</label>
    <input type="text" id="mobile_no" name="mobile_no" value="<%= mobile_no %>" readonly>

    <label for="email_id">Email ID:</label>
    <input type="text" id="email_id" name="email_id" value="<%= email_id %>" readonly>

    <label for="account_type">Account Type:</label>
    <input type="text" id="account_type" name="account_type" value="<%= account_type %>" readonly>

    <label for="dob">Date of Birth:</label>
    <input type="date" id="dob" name="dob" value="<%= dob %>" readonly>

    <label for="id_proof">ID Proof:</label>
    <input type="text" id="id_proof" name="id_proof" value="<%= id_proof %>" readonly>

    <input type="hidden" name="account_no" value="<%= account_no %>">
    
    <button type="submit" onclick="return confirmDelete()">Confirm Delete</button>
</form>

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
