<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionCheck = request.getSession(false);
    if (sessionCheck != null && sessionCheck.getAttribute("username") != null) {
        response.sendRedirect("admin.jsp");
        return; // Stop further execution
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="login">
    <img src="images/1.jpg" alt="Bank Symbol" class="bank-symbol" onclick="location.href='Home.jsp'">
    <div class="choose">
        <h2 class="active" onclick="location.href='login.jsp'">Admin login</h2>
        
    </div>
    <form action="LoginServlet" method="post">
        <div class="input-group">
            <span class="labels">User name</span>
            <input type="text" id="username" name="username" class="text" required>
        </div>
        <div class="input-group">
            <span class="labels">Password</span>
            <input type="password" id="password" name="password" class="text" required>
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
