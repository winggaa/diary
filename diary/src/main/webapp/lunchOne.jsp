<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%


%>


<%

		// 로그인 (인증)
	
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

<%	//페이징 코드
int currentPage = 1;
int rowPerPage = 5;

if(request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

String sql4 = "select count(*) from lunch";


PreparedStatement stmt4 = null;
ResultSet rs4 = null;
stmt4 = conn.prepareStatement(sql4);
rs4 = stmt4.executeQuery();
int totalRow = 0;
if(rs4.next()) {
	totalRow = rs4.getInt("count(*)");
}
System.out.println(totalRow + " <-- totalRow");

int lastPage = totalRow / rowPerPage;
if(totalRow%rowPerPage != 0) {
	lastPage = lastPage + 1;
}
%>

<%

String sql5 ="select * from lunch order by lunch_date desc limit ?, ?";
PreparedStatement stmt5 = null;
ResultSet rs5 = null;
stmt5 = conn.prepareStatement(sql5);
stmt5.setInt(1, (currentPage-1)*rowPerPage);
stmt5.setInt(2, rowPerPage);
rs5 = stmt5.executeQuery();
%>

<%

String sql3 ="select * from lunch order by lunch_date desc limit 0 , 10";
PreparedStatement stmt3 = null;
ResultSet rs3 = null;
stmt3 = conn.prepareStatement(sql3);
rs3 = stmt3.executeQuery();




String checkVoteDate = request.getParameter("checkVoteDate");
String food = request.getParameter("food");
// null 값을 공백으로 바꿈.
if(checkVoteDate == null){
	checkVoteDate = "";
}
String ck = request.getParameter("ck");
if (ck == null) {
	ck = "";
}
String msg = "";

	if(ck.equals("T")){
		msg = "투표가능한 날입니다.";
	} else if(ck.equals("F")){
		msg = "투표불가능한 날입니다.";
	}
                                            

//System.out.println(food +"food");
if (food !=null && checkVoteDate != null){
String sql2 = "INSERT INTO `diary`.`lunch` (`lunch_date`, `menu`, `update_date`, `create_date`) VALUES (?, ?, now(), now());";
PreparedStatement stmt2 = null;
ResultSet rs2 = null;
stmt2 = conn.prepareStatement(sql2);
stmt2.setString(1, checkVoteDate);
stmt2.setString(2, food);
System.out.println(stmt2);
rs2 = stmt2.executeQuery();
response.sendRedirect("/diary/lunchOne.jsp");

}
%>

<%
String sql6 = "select menu, count(*) cnt from lunch  group by menu";
PreparedStatement stmt6 = null;
ResultSet rs6 = null;
stmt6 = conn.prepareStatement(sql6);
rs6 = stmt6.executeQuery();
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
		<ul class="nav">
		  <li class="nav-item">
		    <a class="nav-link active" aria-current="page" href="/diary/diary.jsp">diary</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="/diary/diaryList.jsp">board</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="/diary/logout.jsp">logout</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link disabled" aria-disabled="true">Disabled</a>
		  </li>
		</ul>
		<div class="col-3 mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
		<h1>statsLunch</h1>
	<%
	int maxHeight = 600;
	double totalCnt = 0;
	while(rs6.next()){
		totalCnt = totalCnt + rs6.getInt("cnt");
		
	}
	rs6.beforeFirst();
	%>
	<div>
		전체 투표수 : <%=(int)totalCnt %>
	</div>

	<table style="width: 300px">
		<tr>
		
			<% 
			String[] c = {"#FF0000", "#000000", "#FFE400", "#1DDB16", "#0054FF"};
			int i = 0;
			while(rs6.next()){
				int h = (int)(maxHeight * (rs6.getInt("cnt")/totalCnt));	
			%>
		
			<td style="vertical-align:bottom;">
				<div style= "color: white;height:<%=h%>px; background-color:<%=c[i]%>;text-align: center">
				<%=rs6.getInt("cnt")%>
				</div>
			</td>
		<%
			i = i+1;
			System.out.println(i +"<-- i");
			} rs6.beforeFirst();
		%>
			</tr>
			<tr>
			<%
				while(rs6.next()){
			%>
			<td><%=rs6.getString("menu") %></td>
			<%		
				}
			%>
			</tr>
	</table>		
		</div>
		<div class="col-3 mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
		<h1 style="text-align:center;">점심투표</h1>
		
		<form method="get" action="./lunchOne.jsp">
			<div class="mb-1"><input type="radio" value="양식" name="food">양식</div>
			
			<div class="mb-1"><input type="radio" value="중식" name="food">중식</div>

			<div class="mb-1"><input type="radio" value="일식" name="food">일식</div>
			
			<div class="mb-1"><input type="radio" value="한식" name="food">한식</div>
			
			
			<input type="hidden" value="<%=checkVoteDate%>" name="checkVoteDate">
			<button type="submit" class="mb-2">투표</button>
		</form>
		<form method="post" action="/diary/checkDateAction.jsp">
		<div style="text-align:center;" class="mt-5">
			<input type="date" name="checkVoteDate" value="<%=checkVoteDate%>" class=" mb-2">		
		</div>
		<div class="d-grid gap-2 mx-auto "><button type="submit" class="btn btn-primary" >날짜중복확인</button></div>
			<span><%=msg%></span>
		</form>
				
		</div>
			
			<div class="col-5 mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
	<%while(rs5.next()){
	
		%>
			
			<table class="table table-hover">
			<tr>
				
				<td ><%=rs5.getString("menu")%></td>
				<td ><a href="/diary/lunchOneForm.jsp?checkVoteDate=<%=rs5.getString("lunch_date")%>"><%=rs5.getString("lunch_date")%></a></td>
						<td style="text-align:right"><a href="/diary/deleteLunch.jsp?checkVoteDate=<%=rs5.getString("lunch_date")%>" ><button type="button" class="btn-close" aria-label="Close"></button></a></td>
				
				
			</tr>
			<%} %>
			</table>
							
				<nav aria-label="Page navigation example">
  					<ul class="pagination justify-content-center">

						<%
							if(currentPage > 1) {
						%>
								<li class="page-item">
									<a class ="page-link" href="./lunchOne.jsp?currentPage=1" >처음페이지</a>
								</li>
								<li class="page-item">
									<a class ="page-link" href="./lunchOne.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
								</li>
						<%		
							} else {
						%>
								<li class="page-item disabled">
									<a class ="page-link " href="./lunchOne.jsp?currentPage=1">처음페이지</a>
								</li>
								<li class="page-item disabled">
									<a class ="page-link" href="./lunchOne.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
								</li>
						<%		
							}
						
							if(currentPage < lastPage) {
						%>
								<li class="page-item">
									<a class ="page-link" href="./lunchOne.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
								</li>
								<li class="page-item">
									<a class ="page-link" href="./lunchOne.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
								</li>
						<%		
							}
						%>
					</ul>
				</nav>
										
			</div>
			
		</div>
	</div>	
</body>
</html>

<%

/*
-- 오늘 점심을 투표했는지 보기
SELECT lunch_date lunchDate, menu FROM lunch
WHERE lunch_date = CURDATE();
-- 오늘 점심 투표하기
INSERT INTO lunch(lunch_date,menu,update_date,create_date)
VALUES(CURDATE(), ?, NOW(), NOW());
-- 삭제
DELETE FROM lunch WHERE lunch_date = ?
-- 통계데이터 
SELECT menu,COUNT(*) 
FROM lunch
WHERE YEAR(lunch_date) = ?
GROUP BY menu
ORDER BY COUNT(*) DESC;



*/
%>