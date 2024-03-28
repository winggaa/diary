<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.util.*" %>


<%
//인증 분기 코드 == login on
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();	
	
	String mySession = null;
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	if(mySession.equals("OFF")){
		String errMsg= URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 겟방식으로 보낼수 있음.
		return; // 코드 진행을 끝내는 문법 ex)== 메서드 끝낼때 return 사용
	} 
%>

<%
	String diaryDate = request.getParameter("diaryDate");
	System.out.println(diaryDate + "<<one or list 에서 받아온 날짜값");
	String sql2 = "select * from diary where diary_date = ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,diaryDate);
	System.out.println(stmt2);
	rs2 = stmt2.executeQuery();
	
	while(rs2.next()){
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<title>addDiaryForm</title>
</head>
<body style=background-image:url(/diary/img/img4.jpg);background-repeat:no-repeat;background-attachment:fixed;background-size:100%100%; class="opacity-100" >

	<div class="container">
	<div class="row">
	
	<!--  왼쪽 부분 -->
	<div class="mt-5 col-3 bg-white border shadow bg-body-tertiary rounded" style="text-align:center;">

	<h1 class="mt-2">일기수정</h1>
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
		
		
		
	</div> <!-- col-3 div -->
	
	<!--  오른족 부분 -->
	<div class="mt-5 col-8 bg-white border shadow bg-body-tertiary rounded" >
	<!-- X 뒤로가기 버튼 -->
	<div class="d-flex justify-content-end mt-3">
				<a href="/diary/diaryOne.jsp?diaryDate=<%=diaryDate%>"><button type="button" class="btn-close" aria-label="Close"></button></a>
				</div>
				
		<!--  updateDiaryAction 으로 보낼 수정내용 부분-->		
	<form method="post" action="/diary/updateDiaryAction.jsp">	
		<div class="mt-5">
					<div class="input-group mb-3">
				  	<input type="text" class="form-control" name="diaryDate" value="<%=diaryDate%>" readonly="readonly">
  					<span class="input-group-text"></span>
  					<input type="text" class="form-control" placeholder="제목" name="title" value="<%=rs2.getString("title")%>">
					</div>
		</div>
		
		
		<div>
			<select name="weather" class="form-select mb-2">
				<option value="맑음">맑음</option>
				<option value="흐림">흐림</option>
				<option value="비">비</option>
				<option value="눈">눈</option>
			</select>
		</div>
	
		<div class="form-floating">
  		<textarea class="form-control" name="content" style="height: 300px"></textarea>
  		<label for="floatingTextarea2">내용</label>
		</div>

		
		<div class="mt-3 mb-3" >
			<button type="submit">작성하기</button>
		</div>
	</form>
	<div class="col-1"></div>
		</div>
	</div> <!--  row -->
	</div> <!-- container -->
	
	<%
	} // rs2.next()닫기
	%>
</body>
</html>