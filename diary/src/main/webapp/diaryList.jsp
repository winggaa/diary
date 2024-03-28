<%@page import="jakarta.websocket.Extension.Parameter"%>
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
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	/*
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	} */
	
	int startRow = (currentPage - 1)*rowPerPage;// 1~ 10 /// 11 ~ 20 // 21 ~ 30 // 31 ~ 40 // 에서 맨앞. 1 , 11 , 21 , 31
	
	
	String searchWord = "";
	if(request.getParameter("searchWord") != null) {
		searchWord = (request.getParameter("searchWord"));
	}
	
	String sql2 = "select diary_date diaryDate, title FROM diary WHERE title LIKE ? ORDER BY diary_date DESC LIMIT ?, ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,"%"+searchWord+"%");
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	
	rs2 = stmt2.executeQuery();
	
	String sql3 = "select count(*) cnt from diary where title like ?";
	ResultSet rs3 = null;
	PreparedStatement stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1, "%"+searchWord+"%");
	rs3 = stmt3.executeQuery();
	int totalRow = 0;
	if(rs3.next()){
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<style type="text/css">
	a:link 		{color:black; 	text-decoration:none;}
	a:active 	{color:black; 	text-decoration:none;}
	a:visited 	{color:black; 	text-decoration:none;}
	a:hover 	{color:black; 	text-decoration:none;}
	</style>
	
	
	
</head>
<body style=background-image:url(/diary/img/img4.jpg);background-repeat:no-repeat;background-attachment:fixed;background-size:100%100%; class="opacity-100" >
	<div class="container">
		<div class="row">
			<div class="col-3"></div>
			<div class="col mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
				<h1>일기 목록</h1>
					<form method="get" action="/diary/diaryList.jsp">
					
					<nav class="navbar navbar-expand-lg bg-body-tertiary">
						<div class="container-fluid">
						 <div class="collapse navbar-collapse" id="navbarSupportedContent">
						 <ul class="navbar-nav me-auto mb-2 mb-lg-0">
					        <li class="nav-item">
					          <a class="nav-link active" aria-current="page" href="/diary/diary.jsp">diary</a>
					        </li>
					        <li class="nav-item">
					          <a class="nav-link" href="/diary/diaryList.jsp">reset</a>
					        </li>
						 
						  <li class="nav-item">
					       <a class="nav-link disabled" aria-disabled="true" href="/diary/diaryList.jsp">disabled</a>
					      </li>
					      
					     <li class="nav-item dropdown">
					          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					            메뉴
					          </a>
				          <ul class="dropdown-menu">
				            <li><a class="dropdown-item" href="/diary/logout.jsp">로그아웃</a></li>
				            <li><a class="dropdown-item" href="/diary/addDiaryForm.jsp">글생성</a></li>	
				            <li><a class="dropdown-item" href="#">다른 설정값 들어올수있음</a></li>
				          </ul>
				        </li>
						 
						 </ul>
						   <form class="d-flex" role="search" action="/diary/diaryList.jsp" method="get">
					       <input class="form-control me-2" type="search" placeholder="Search" name="searchWord">
					        <button class="btn btn-outline-success" type="submit">Search</button>
					      	</form>
						 
						 </div>
						</div>
					</nav>
					
					
					
					
					<!-- 검색창 부분 -->
		<!--  <div style="text-align:right;">
				<input type="text" name="searchWord">
				<button type="submit">검색</button>
			</div>
					-->
			
			</form>
				<!-- 날짜 + 제목 리스트 생성 -->
				<table class="table table-hover table-bordered">
					<tr>
						<th class="table-dark">날짜</th>
						<th class="table-dark">제목</th>
					</tr>
					<%
						while(rs2.next()){
					%>
					<tr>
				<td><a href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>"><%=rs2.getString("diaryDate")%></a></td>
				<td><%=rs2.getString("title")%></td>
					</tr>
					<%
						}
					%>
				</table>
				
				<!--  페이징  -->
				<div>
					<a href="/diary/diaryList.jsp?currentPage=<%=currentPage-1%>">이전</a>
						<a href="/diary/diaryList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				</div>

				</div> <!-- col -->
			<div class="col-3"></div> 
		</div> <!-- row -->
	</div> <!-- container-->
</body>
</html>