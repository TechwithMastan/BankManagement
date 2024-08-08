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
    <title>Sign Up Page</title>
    <style>
    @charset "UTF-8";

body {
    background-color: #e0e0e0;
    color: #fff;
    font-size: 14px;
    letter-spacing: 1px;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    overflow: hidden;
}
.bank-symbol {
    width: 80px; /* Adjust size as needed */
    height: auto;
    margin-bottom: 20px; /* Adjust margin to create space between symbol and h2 */
}

.login {
    position: relative;
    height: 90%;
    width: 500px;
    padding: 60px 60px;
    color: #fff;
    background-image: radial-gradient(circle at 10% 20%, rgb(98, 114, 128) 0%, rgb(52, 63, 51) 90.1%);
    background-size: cover;
    box-shadow: 0px 30px 60px -5px #000;
    border-radius: 8px;
    text-align: center;
}
.choose{
	padding:0;
}

form {
    padding-top: 20px;
}
h2:hover{
	color:black;
	cursor:pointer;
}

h2 {
    font-size: 22px;
    text-transform: uppercase;
    letter-spacing: 2px;
    display: inline-block;
    

}

h2:first-child {
    padding-left: 0;
}

span.labels {
    text-transform: uppercase;
    font-size: 12px;
    opacity: 0.4;
    display: block;
    margin-top: 10px;
    transition: opacity 0.5s ease;
}

.text {
    border: none;
    width: calc(100% - 22px);
    padding: 10px;
    font-size: 16px;
    border-radius: 20px;
    background: rgba(255, 255, 255, 0.1);
    border: 2px solid rgba(255, 255, 255, 0);
    color: #fff;
    transition: all 0.5s ease;
    margin-top: 5px;
}

.text:focus {
    outline: 0;
    border: 2px solid rgba(255, 255, 255, 0.5);
    background: transparent;
}

.text:focus + span.labels {
    opacity: 0.6;
}

.custom-checkbox {
    -webkit-appearance: none;
    background-color: rgba(255, 255, 255, 0.1);
    padding: 8px;
    border-radius: 2px;
    display: inline-block;
    position: relative;
    top: 6px;
    margin-right: 5px;
}

.custom-checkbox:checked {
    background-color: #1161ed;
}

.custom-checkbox:checked:after {
    content: '\2714';
    font-size: 10px;
    position: absolute;
    top: 1px;
    left: 4px;
    color: #fff;
}

.custom-checkbox:focus {
    outline: none;
}

.button {
    background-color: #1161ed;
    color: #fff;
    width: 100%;
    padding: 12px;
    font-size: 16px;
    border-radius: 20px;
    border: none;
    cursor: pointer;
    margin-top: 20px;
    transition: background-color 0.3s ease;
}

.button:hover {
    background-color: #4082f5;
}

.button:focus {
    outline: none;
}

hr {
    border: 1px solid rgba(255, 255, 255, 0.1);
    margin: 20px 0;
}

a.forgot {
    text-align: center;
    display: block;
    text-decoration: none;
    color: rgba(255, 255, 255, 0.2);
    font-size: 12px;
    transition: color 0.3s ease;
}

a.forgot:hover {
    color: #fff;
}
    
    </style>
</head>
<body>
<div class="login">
    <img src="images/1.jpg" alt="Bank Symbol" class="bank-symbol" onclick="location.href='admin.jsp'">
    <div class="choose">
        <h2 class="active" onclick="location.href='signup.jsp'">Register a User</h2>
    </div>
    <form action="SignupServlet" method="post">
        <div class="input-group">
            <span class="labels">Full Name</span>
            <input type="text" id="full_name" name="full_name" class="text" required>
        </div>
        <div class="input-group">
            <span class="labels">Address</span>
            <input type="text" id="address" name="address" class="text" required>
        </div>
        <div class="input-group">
            <span class="labels">Mobile No</span>
            <input type="text" id="mobile_no" name="mobile_no" class="text" required>
        </div>
        <div class="input-group">
            <span class="labels">Email ID</span>
            <input type="email" id="email_id" name="email_id" class="text" required>
        </div>
        <div class="input-group">
            <span class="labels">Account Type</span>
            <select id="account_type" name="account_type" class="text" required>
                <option value="Current">Current</option>
                <option value="Savings">Savings</option>
            </select>
        </div>
        <div class="input-group">
            <span class="labels">Initial Balance</span>
            <input type="number" id="initial_balance" name="initial_balance" class="text" required min="1000">
        </div>
        <div class="input-group">
            <span class="labels">Date of Birth</span>
            <input type="date" id="dob" name="dob" class="text" required>
        </div>
        <div class="input-group">
            <span class="labels">ID Proof</span>
            <input type="text" id="id_proof" name="id_proof" class="text" required>
        </div>
        
        <button type="submit" class="button">Sign Up</button>
        <hr>
        
    </form>
</div>
</body>
</html>