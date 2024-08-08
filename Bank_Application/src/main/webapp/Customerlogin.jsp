<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionCheck = request.getSession(false);
    if (sessionCheck != null && sessionCheck.getAttribute("account_no") != null) {
        response.sendRedirect("dashboard.jsp");
        return; // Stop further execution
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
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
    height: 560px;
    width: 300px;
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
     <img src="images/1.jpg" alt="Bank Symbol" class="bank-symbol" onclick="location.href='Home.jsp'">
    <div class="choose">
        <h2 class="active" onclick="location.href='Customerlogin.jsp'">Customer login</h2>
        
    </div>
    <form action="CustomerLoginServlet" method="post">
        <div class="input-group">
            <span class="labels">Account No</span>
            <input type="tel" id="account_no" name="account_no" class="text"   required>
        </div>
        <div class="input-group">
            <span class="labels">Password</span>
            <input type="password" id="temp_password" name="temp_password" class="text" required>
        </div>
        <div class="input-group">
            <input type="checkbox" id="checkbox-1-1" class="custom-checkbox">
            <label for="checkbox-1-1">Keep me Signed in</label>
        </div>
        <button type="submit" class="button">Sign In</button>
        <hr>
        <a href="#" class="forgot">Forgot Password?</a>
    </form>
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
            out.println("<p style='color:red;'>" + errorMessage + "</p>");
        }
    %>
</div>

</body>
</html>
