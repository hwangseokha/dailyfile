<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    request.setCharacterEncoding("utf-8");

    String userid = request.getParameter("user_id");
    String username = request.getParameter("user_name");
    String userpwd = request.getParameter("user_password");
    String date = request.getParameter("register_time");
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/firstDB","seokha","1234");
        
        String sql = "INSERT INTO user (id, name, password, date) VALUES (?, ?, ?, ?)";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, userid);
        query.setString(2, username);
        query.setString(3, userpwd);
        query.setString(4, date);
        
        int result = query.executeUpdate();
        query.close();
        connect.close();
        
        if( result == 1){
            response.sendRedirect("loginpage.html");
        }
        else{
            response.sendRedirect("register.html");
        }
    }
    catch(Exception e){
        out.println(e);
    }
%>
