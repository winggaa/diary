<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%	/*
	// 0. 로그인(인증) 분기
	// diary.login.my_session => 'ON' => redirect("diary.jsp")
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	if(mySession.equals("ON")) {
		response.sendRedirect("/diary/diary.jsp");
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	} */
	
	// 0-1) 로그인(인증) 분기 session사용으로 변경
		// 로그인 성공시 세션에 loginMember라는 변수를 만들고 값으로 로그인 아이디를 저장
		
		String loginMember = (String)(session.getAttribute("loginMember"));

		//System.out.println(loginMember + "<-- 로그인멤버");
		
		if(loginMember != null) {
			response.sendRedirect("/diary/diary.jsp");
			return;
		}
		
		// loginMember가 null 이다 --> session공간에 loginMember 변수를 생성하고 
		
	
	// 1. 요청값 분석
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	String sql2 = "select member_id memberId from member where member_id=? and member_pw=?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 =	conn.prepareStatement(sql2);
	stmt2.setString(1, memberId);
	stmt2.setString(2, memberPw);
	rs2 = stmt2.executeQuery();
	
	if(rs2.next()) {
		// 로그인 성공
		System.out.println("로그인 성공");
		/*
		// diary.login.my_session -> "ON" 변경
		String sql3 = "update login set my_session = 'ON', on_date = NOW()";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		int row = stmt3.executeUpdate();
		System.out.println(row+ " <-- row");
		*/
		// 로그인 성공시 db값 설정 --> session 변수 설정
		session.setAttribute("loginMember", rs2.getString("memberId")); // loginMember에 데이터베이스에 있는 memberId 명의 session값 저장
		
		response.sendRedirect("/diary/diary.jsp");
		
	} else {
		// 로그인 실패
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
	}

%>
