<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    request.setCharacterEncoding("utf-8");

    String num = request.getParameter("sendnum");
    String userid = (String)session.getAttribute("user_id");

    Boolean flag= false;

    try{
        Class.forName("com.mysql.jdbc.Driver");
            
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/firstDB","seokha","1234");

        String sql="SELECT * from schedule WHERE id=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, userid);
        ResultSet result = query.executeQuery();
        
        if(result.next()){
            
            sql = "DELETE FROM schedule WHERE num=?;";
            
            query = connect.prepareStatement(sql);
            query.setString(1, num);

            query.executeUpdate();
            flag = true;
        }
    }
    catch( Exception e) {
        e.printStackTrace();
    }  
%>
    <script>
        if(<%=flag%> == true) {
            alert(" 삭제되었습니다 ");
            location.href="mainpage.jsp"
        }
        else {
            alert("에러");
            location.href="mainpage.jsp"
        }
    </script>