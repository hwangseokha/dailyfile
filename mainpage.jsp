<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%
    String userid = (String)session.getAttribute("user_id");
    String username = (String)session.getAttribute("user_name");  
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="mainpage.css">
</head>
<body>  
    <header id="topBox">
        <div id="LogoBox">Logo</div>    
        <div id="userinfoBox">
            <div class="userinfo">아이디 : <%=userid%></div>
            <div class="userinfo">이름 : <%=username%></div>
        <div>
    </header>
    <div id="addBox">
        <form action="updateschedule.jsp" name="updateschedule" method="post" onsubmit="return checkvalue()">
            <table>
                <tr>
                    <td><input type="date" name="sendDay"  value="날짜"></td>
                    <td><input type="time" name="sendTime" value="시간"></td>
                    <td><input type="text" name="sendContent" value="내용"></td>
                    <td><input type="submit" id="addschedule" value="추가"></td>
                </tr>
            </table>
        </form>
    <div>
    <%
    try{
        Class.forName("com.mysql.jdbc.Driver");
            
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/firstDB","seokha","1234");
        
        String sql="SELECT * from schedule WHERE id=? order by day, time;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, userid);
        
        ResultSet result = query.executeQuery();
        while(result.next()){
            result.getString("num");
            result.getString("day");
            result.getString("time");
            result.getString("content");
        %>
        <form action="modifyschedule.jsp" method="post">
            <table>
                <tr>
                    <td><input type="hidden"  name="sendnum" value="<%=result.getInt("num")%>"></td>
                    <td><input type="date" name="modifyday" value="<%=result.getString("day")%>"></td>
                    <td><input type="time" name="modifytime" value="<%=result.getString("time")%>"></td>
                    <td><input type="text" name="modifycontent" value="<%=result.getString("content")%>"></td>
                    <td><input type="submit" id="addschedule" value="수정"></td>
                    <td><button type="submit" formaction="deleteschedule.jsp">삭제</button></td>
                </tr>
            </table>
        </form>
    <%
        }
    }
    catch( Exception e) {
        e.printStackTrace();
    } 
    %>
    <div id="logout-box">
        <a href="logout.jsp"> 로그아웃</a>
    </div>
    <script>
    function modfiy(){
        //입력가능으로 하게바꾸고 value 이  장으로 변경//
    }
    function checkvalue(){
        if(!document.updateschedule.sendDay.value){
            alert("날짜를 골라주세요")
            return false;
        }
        if(!document.updateschedule.sendTime.value){
            alert("시간을 골라주세요")
            return false;
        }
        if(!document.updateschedule.sendContent.value){
            alert("내용을 입력하세요")
            return false;
        }
    }
    function deleteschedule() {
          if(confirm("일정을 삭제하시겠습니까?")) {
              location.href="deleteschedule.jsp"
          }
          else return;
      }
    </script>
</body>
</html> 