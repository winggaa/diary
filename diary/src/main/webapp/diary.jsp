<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.util.*" %>
<%

		// 로그인 (인증)
		// diary.login.my_session = 'OFF' --> redirect("loginForm.jsp")// 대문자로 설정해놨음
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
<!--  캘린더 코드 부분 -->
<%
	//1. 요청 분석
	// 출력하고자하는 달력의 년과 월값 받아오기.
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	
	Calendar target = Calendar.getInstance();
	
	if(targetYear != null && targetMonth != null){
		target.set(Calendar.YEAR, Integer.parseInt(targetYear));
		target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	} 
	
		// 시작공백의 개수를 구하려면 -> 1일의 요일이 필요 -> 타겟 날짜를 1일로변경 
	target.set(Calendar.DATE,1);
	
	// 달력 타이틀로 출력할	변수
	int tYear = target.get(Calendar.YEAR);
	int tMonth = target.get(Calendar.MONTH);
		
	int yoNum = target.get(Calendar.DAY_OF_WEEK); // 일:1, 월:2, .....토:7
	System.out.println(yoNum);
	// 시작공백의 개수: 일요일 공백이 없음 월요일은 1칸, 화요일은 2칸 ~~~` 
	int startBlank = yoNum -1;
	int lastDate = target.getActualMaximum(Calendar.DATE);
	
	int lastBlank = 42-(lastDate+startBlank);
	int countDiv = startBlank + lastDate + lastBlank; 	
	 
	 
	// tYear와 tMonth 에 해당되는 diary 목록 추출
	String sql2 = "select diary_date diaryDate, day(diary_date) day, left(title,5) title , feeling from diary where year(diary_date)=? and month(diary_date)=?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, tYear);
	stmt2.setInt(2, tMonth + 1);
	System.out.println(stmt2);
	
	rs2 = stmt2.executeQuery();
	
	
	
%> 



<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style>	
		.cell{
			/*border: 1px solid #000000 ; /* 테두리 색 + 크기 + 그리기*/
			
			
			
			border-style:ridge;
			border-color:1px solid #000000; 
			border-radius: 7px;  /* 테두리 깍기*/
			margin:auto;
			float:left;
			
			background-color: #ffffff;
			width: 70px; height: 70px;
			
			 
			
		}
		.sun {
			clear: both;
			color; #FF0000;
		}
		
		.day{
			border: 1px solid #000000;
			width:70px ;height:20px ;
			
			float:left;
			
			
			border-radius: 5px;
			text-align:center;
			margin: 1px;
			
		}
		
		.button {
  			background-color: gray; /* Green */
			border: none;
			color: white;
			padding: 10px 10px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 16px;
			border-radius: 12px;
}
		.p1 {
  font-family: "Lucida Console" ;
}
		
		
		 .container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
	</style>
	<style type="text/css">
	a:link 		{color:black; 	text-decoration:none;}
	a:active 	{color:black; 	text-decoration:none;}
	a:visited 	{color:black; 	text-decoration:none;}
	a:hover 	{color:black; 	text-decoration:none;}
	</style>
	
	
	<title></title>
</head>
<body style=background-image:url(/diary/img/img4.jpg);background-repeat:no-repeat;background-attachment:fixed;background-size:100%100%; class="opacity-75" >

	<div class="container" style="height:900px; ">
	
	<h1>일기장</h1>
	<a href="/diary/diary.jsp">다이어리 모양으로 보기</a>
	<a href="/diary/diaryList.jsp">게시판 모양으로 보기</a>
	<div>
	 
		<h2><a href="/diary/logout.jsp" role="button">로그아웃</a>
		<a href="./addDiaryForm.jsp" role="button">글생성</a></h2>
	</div>
	
	
	<!--                      캘린더 작업 부분 -->
	 
	<div>
		<h1>
	
		<a class="button" href="./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth-1%>">저번달</a>
		<%=tYear%>년 <%=tMonth+1%>월
		<a class="button" href="./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth+1%>">다음달</a>
		</h1>
	</div>
	
	
	<div class="wrap">
	<div class="day p1" style="background-color:Tomato; width: 72px;">일</div>
	<div class="day p1" style="background-color:orange; width: 72px;;">월</div>
	<div class="day p1" style="background-color:DodgerBlue; width: 72px;">화</div>
	<div class="day p1" style="background-color:MediumSeaGreen; width: 72px;">수</div>
	<div class="day p1" style="background-color:violet; width: 72px;">목</div>
	<div class="day p1" style="background-color:SlateBlue; width: 72px;">금</div>
	<div class="day p1" style="background-color:LightGray; width: 72px;">토</div>
	
	<%
		for(int i=1; i<=countDiv; i=i+1){
			
				if(i%7 == 1){
			%>
				
				<div class=" cell sun p1 ">
				
					
			<%
				} else{  
			%>
				<div class="cell p1 ">
			<%
				}
			%>
		
				<% if(i>lastDate+startBlank)
					{
					%>
					     &nbsp;
				<% } else if(i-startBlank >0){
		
				%>
						<%=i-startBlank%><br>
						
				<%		
				// 현재날짜(i-startBlank)의 일기가 rs2목록에 있는지 비교
						while(rs2.next()){
						if(rs2.getInt("day") == (i-startBlank)) { 
					
				 %>
					<sapn><%=rs2.getString("feeling") %></sapn>			
						<div>
						<a href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>">
						<%=rs2.getString("title")%>...
						</a>
						</div>
					
			<%	
					break;
						}	}	rs2.beforeFirst(); // resultSet의 커스 위치를 처음으로
				} else { 
				%>
						&nbsp;
				<%
					}
				%>
				
					
			</div>

<%
		}
%>
	</div>
		
	</div>
	</div>
	
	
	
</body>
</html>