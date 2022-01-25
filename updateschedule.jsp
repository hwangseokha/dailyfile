<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    request.setCharacterEncoding("utf-8");

    String userid = (String)session.getAttribute("user_id");
    Boolean flag= false;
    String day = request.getParameter("sendDay");
    String time = request.getParameter("sendTime");
    String content = request.getParameter("sendContent");
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
            
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/firstDB","seokha","1234");

        int num=0;
        String sql="SELECT max(num) from schedule Where id=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, userid);
        ResultSet result = query.executeQuery();
        if(result.next()){
            num = result.getInt("max(num)")+1;
        }

        sql = "INSERT INTO schedule (id, num, day, time, content) VALUES (?, ?, ?, ?, ?) ";
        query = connect.prepareStatement(sql);
        query.setString(1, userid);
        query.setInt(2, num);
        query.setString(3, day);
        query.setString(4, time);
        query.setString(5, content);

        query.executeUpdate();
        flag = true;
    }
    catch( Exception e) {
        e.printStackTrace();
    }  
%>
    <script>
        if(<%=flag%> == true) {
            alert(" 추가되었습니다 ");
            location.href="mainpage.jsp"
        }
        else {
            alert("에러");
            location.href="mainpage.jsp"
        }
    </script>