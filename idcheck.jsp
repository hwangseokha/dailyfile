<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>


<%
    
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("sendId");

    Connection connect = null;
    PreparedStatement query = null;
    ResultSet result = null;
    Boolean flag= false;

    try{    
        Class.forName("com.mysql.jdbc.Driver");
    
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/firstDB","seokha","1234");

        String sql = "SELECT * FROM user WHERE id=?";
        query = connect.prepareStatement(sql);
        query.setString(1, id);

        result = query.executeQuery();
        
        flag = true;
    }catch(Exception e){
        e.printStackTrace();
        response.sendRedirect("loginpage.html");
    }
%>
<script>
        if(<%=flag%> == true) {
            alert(" 사용불가능한 아이디입니다 ");
            location.href="register.jsp"
        }
        else {
            alert(" 사용가능한 아이디입니다");
            location.href="register.jsp"
        }
    </script>