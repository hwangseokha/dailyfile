<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>

<%
    request.setCharacterEncoding("utf-8");

    String userid = (String)session.getAttribute("user_id");
    Boolean flag= false;
    String num = request.getParameter("sendnum");
    String day = request.getParameter("modifyday");
    String time = request.getParameter("modifytime");
    String content = request.getParameter("modifycontent");

try{
    Class.forName("com.mysql.jdbc.Driver");
            
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/firstDB","seokha","1234");

    String sql="SELECT * from schedule WHERE id=?;";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, userid);
    ResultSet result = query.executeQuery();

    if(result.next()){

        sql = "UPDATE schedule SET day=?, time=?, content=? where num=?;";
        query = connect.prepareStatement(sql);
        query.setString(1, day);
        query.setString(2, time);
        query.setString(3, content);
        query.setString(4, num);

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
            alert(" 수정되었습니다 ");
            location.href="mainpage.jsp"
        }
        else {
            alert("에러");
            location.href="mainpage.jsp"
        }
    </script>