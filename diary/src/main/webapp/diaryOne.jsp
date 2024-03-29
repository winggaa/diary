<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.util.*" %>

<%

		// 로그인 (인증)
		// diary.login.my_session = 'OFF' --> redirect("loginForm.jsp")// 대문자로 설정해놨음
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String loginMember = (String)(session.getAttribute("loginMember"));
	
if(loginMember == null 	){
		
		String errMsg= URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 겟방식으로 보낼수 있음.
		return; // 코드 진행을 끝내는 문법 ex)== 메서드 끝낼때 return 사용
	}
	
	
%>

<%
String diaryDate = request.getParameter("diaryDate");
System.out.println(diaryDate);
String sql2 = "select * from diary where diary_date = ?";
PreparedStatement stmt2 = null;
ResultSet rs2 = null;
stmt2 = conn.prepareStatement(sql2);
stmt2.setString(1,diaryDate);
System.out.println(stmt2);
rs2 = stmt2.executeQuery();

%>
<%while(rs2.next())
{
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body style=background-image:url(/diary/img/img4.jpg);background-repeat:no-repeat;background-attachment:fixed;background-size:100%100%; class="opacity-100" >
<div class="container">
	<div class="row">
	
 	<div class="mt-5 col-3 bg-white border shadow bg-body-tertiary rounded">
		<h2 class="mt-3" style="text-align:center;"><%=diaryDate%></h2>
		
		<div class="accordion" >
			  <div class="accordion-item">
				<h2 class="accordion-header">
				<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        		수정일
      			</button>
			 	</h2>
			 	<div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
      			<div class="accordion-body">
        		<strong><%=rs2.getString("update_date") %></strong>
      			</div>
    			</div>
			  </div>	
			  
		<div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		        작성일
		      </button>
		    </h2>
		    <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
		      <div class="accordion-body">
		        <strong><%=rs2.getString("create_date") %></strong>
		      </div>
		    </div>
		  </div>
		
		</div> <!-- 아코디언 div 마지막 -->
		
		<ul class="nav flex-column mt-5">
		  <li class="nav-item">
		    <a class="nav-link active" aria-current="page" href="/diary/updateDiaryForm.jsp?diaryDate=<%=diaryDate%>">수정</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="/diary/deleteDiaryAction.jsp?diaryDate=<%=diaryDate%>">삭제</a>
		  </li>
  		</ul>
		
	</div>
	 
		
		
	<div class="mt-5 col-8 bg-white border shadow bg-body-tertiary rounded" >
			<div class="d-flex justify-content-end mt-3">
				<a href="./diary.jsp"><button type="button" class="btn-close" aria-label="Close"></button></a>
				</div>
			
		<div class="input-group mb-3 mt-3">
				  	<input type="text" class="form-control " placeholder="날짜" name="diaryDate" value="<%=diaryDate%>" readonly="readonly">
  					<span class="input-group-text"></span>
  					<input type="text" class="form-control " placeholder="제목" name="title" value="<%=rs2.getString("title")%>" readonly="readonly">
					</div>
     				
		<div>
			<select name="weather" class="form-select">
				<option value="<%=rs2.getString("weather")%>"><%=rs2.getString("weather")%></option>
			</select>
		</div>
		 	
				<div class="form-floating">
  		<textarea class="form-control mb-3 mt-5 mr-2 " name="content" style="height: 300px" readonly="readonly"></textarea>
  		<label for="floatingTextarea1"><%=rs2.getString("content")%></label>
				</div>
			</div>
		</div>
	</div>
	<%
}
%>
</body>
</html>