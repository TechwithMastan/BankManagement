<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Retrieve the existing session
    HttpSession sessionCheck = request.getSession(false);
    if (sessionCheck != null) {
        sessionCheck.invalidate(); // Invalidate the session
    }
    
    // Redirect to login page
    response.sendRedirect("Customerlogin.jsp");
%>
