<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	session.invalidate(); // 세션 공간 초기화(포맷)
	
	response.sendRedirect("/diary/loginForm.jsp");


	// ON --> OFF
	
/*
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
	// 현재값이 OFF아니고 ON이다 -> OFF변경후  loginForm으로 리다이렉트함
	String sql2 = "update login set my_session='OFF',off_date=now() ";
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	int row = stmt2.executeUpdate();
	System.out.println(row + "로우 값");
	
	response.sendRedirect("/diary/loginForm.jsp");
	
	*/
%>