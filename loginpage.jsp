<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>


<%
    
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("sendId");
    String pw = request.getParameter("sendPw");
    Boolean flag = false;
    Cookie cookie = new Cookie("userid",id);

    Connection connect = null;
    PreparedStatement query = null;
    ResultSet result = null;

    try{    
        String dbid="";
        String dbname="";
        String dbpassword="";
        String sql = "SELECT * FROM user WHERE id=?";

        Class.forName("com.mysql.jdbc.Driver");
    
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/firstDB","seokha","1234");

        query = connect.prepareStatement(sql);
        query.setString(1, id);

        result = query.executeQuery();
        if(result.next()){
            dbid = result.getString(1);    
            dbname = result.getString(2);
            dbpassword = result.getString(3);

            if(dbpassword.equals(pw)){
            
                session.setAttribute("user_id", dbid);
                session.setAttribute("user_name", dbname);
                session.setAttribute("user_password", dbpassword);

                flag = true;
            }
        }
             
    }catch(Exception e){
        e.printStackTrace();
        response.sendRedirect("loginpage.html");
    }
%>
    <script>
        if(<%=flag%> == true) {
            location.href="mainpage.jsp"
        }
        else {
            alert("아이디 또는 비밀번호가 틀렸습니다");
            location.href="loginpage.html"
        }
    </script>
