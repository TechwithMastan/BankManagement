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
    <title>Password Change</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
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
        form {
            margin-top: 20px;
        }
        .input-group {
            margin-bottom: 10px;
        }
        .labels {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .text {
            width: calc(100% - 22px);
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        .button:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Password Change</h1>
        <form action="PasswordChangeServlet" method="post">
            <div class="input-group">
                <label for="account_no" class="labels">Account Number</label>
                <input type="text" id="account_no" name="account_no" class="text" value="<%= request.getParameter("account_no") %>" readonly>
            </div>
            <div class="input-group">
                <label for="current_password" class="labels">Current Password</label>
                <input type="password" id="current_password" name="current_password" class="text" required>
            </div>
            <div class="input-group">
                <label for="new_password" class="labels">New Password</label>
                <input type="password" id="new_password" name="new_password" class="text" required>
            </div>
            <div class="input-group">
                <label for="confirm_password" class="labels">Confirm New Password</label>
                <input type="password" id="confirm_password" name="confirm_password" class="text" required>
            </div>
            <button type="submit" class="button">Change Password</button>
        </form>
        <%-- Display error message if exists --%>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <p class="error-message"><%= errorMessage %></p>
        <%
            }
        %>
    </div>
</body>
</html>
