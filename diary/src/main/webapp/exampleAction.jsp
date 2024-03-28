<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
/*
for (int i=1; i<=4 ;i++){
	int a = 0 ;
	a = i* 10;
	for(int j=1; j<=4 ; j++){
		 a = a + 1 ;
		 Integer.toString(a);
		// System.out.println("String"+ " "+ "num"+ a + " "+ "="+ " "+ "request.getParameter(\""	+a+		"\");");
		System.out.println("String " +"result"+ a +" "+ "="+ " \"X\""+ ";");
	}
}  

*/
//System.out.println(" \"\" <<<<<<< ");

	String num11 = request.getParameter("11");
/*	String num12 = request.getParameter("12");
	String num13 = request.getParameter("13");
	String num14 = request.getParameter("14"); */
String num21 = request.getParameter("21");
String num22 = request.getParameter("22");
String num23 = request.getParameter("23");
String num24 = request.getParameter("24");
String num31 = request.getParameter("31");
String num32 = request.getParameter("32");
String num33 = request.getParameter("33");
String num34 = request.getParameter("34");
String num41 = request.getParameter("41");
String num42 = request.getParameter("42");
String num43 = request.getParameter("43");
String num44 = request.getParameter("44");
String num51 = request.getParameter("51");
String num52 = request.getParameter("52");
String num53 = request.getParameter("53");
String num54 = request.getParameter("54");

/*
	System.out.println(num11);
	System.out.println(num12);
	System.out.println(num13);
	System.out.println(num14);
	System.out.println(num21);
	System.out.println(num22);
	System.out.println(num23);
	System.out.println(num24);
	System.out.println(num31);
	System.out.println(num32);
	System.out.println(num33);
	System.out.println(num34);
	System.out.println(num41);
	System.out.println(num42);
	System.out.println(num43);
	System.out.println(num44); */

	
	String answer11 = "2134";
	
	String answer21 = "O";
	String answer22 = "O";
	String answer23 = "X";
	String answer24 = "O";
	String answer31 = "O";
	String answer32 = "O";
	String answer33 = "X";
	String answer34 = "O";
	String answer41 = "O";
	String answer42 = "O";
	String answer43 = "X";
	String answer44 = "O";
	String answer51 = "X";
	String answer52 = "X";
	String answer53 = "O";
	String answer54 = "O";
	
	
	
	
	
	
	
	
	
	
	
	
	

String result11 =  "X";
String result12 =  "X";
String result13 =  "X";
String result14 =  "X";
String result21 =  "X";
String result22 =  "X";
String result23 =  "X";
String result24 =  "X";
String result31 =  "X";
String result32 =  "X";
String result33 =  "X";
String result34 =  "X";
String result41 =  "X";
String result42 =  "X";
String result43 =  "X";
String result44 =  "X";
String result51 =  "X";
String result52 =  "X";
String result53 =  "X";
String result54 =  "X";

int score = 0;
int question = 5;
int answerScore = 100/question ;
int problem = 4;
int partialScore =  answerScore/4;


if(num11.equals("2134") || num11.equals("2-1-3-4") ){
	score = score + answerScore ;  
	result11 = num11;}
	

if(num21.equals("O")){
	score = score + partialScore ;  
	result21 = "O";}
if(num22.equals("O")){
	score = score + partialScore ;  
	result22 = "O";}
if(num23.equals("X")){
	score = score + partialScore ;  
	result23 = "O";}
if(num24.equals("O")){
	score = score + partialScore ;  
	result24 = "O";}

 // 2번
if(num31.equals("O")){
	score = score + partialScore ;  
	result31 = "O";}
if(num32.equals("O")){
	score = score + partialScore ;  
	result32 = "O";}
if(num33.equals("X")){
	score = score + partialScore ;  
	result33 = "O";}
if(num34.equals("O")){
	score = score + partialScore ;  
	result34 = "O";}

// 3번
if(num41.equals("O")){
	score = score + partialScore ;  
	result41 = "O";}
if(num42.equals("O")){
	score = score + partialScore ;  
	result42 = "O";}
if(num43.equals("X")){
	score = score + partialScore ;  
	result43 = "O";}
if(num44.equals("O")){
	score = score + partialScore ;  
	result44 = "O";}

//4번
if(num51.equals("X")){
	score = score + partialScore ;  
	result51 = "O";}
if(num52.equals("X")){
	score = score + partialScore ;  
	result52 = "O";}
if(num53.equals("O")){
	score = score + partialScore ;  
	result53 = "O";}
if(num54.equals("O")){
	score = score + partialScore ;  
	result54 = "O";}

System.out.println(score);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<ol>
	<li><%=result11%> 정답은 <%=answer11%></li>
	</ol>
	
	1번
	<ol>
	<li><%=result21%> 정답은 <%=answer21%>입니다</li>
	<li><%=result22%> 정답은 <%=answer22%>입니다</li>
	<li><%=result23%> 정답은 <%=answer23%>입니다</li>
	<li><%=result24%> 정답은 <%=answer24%>입니다</li>
	</ol>
	2번
	<ol>
	<li><%=result31%> 정답은 <%=answer31%>입니다</li>
	<li><%=result32%> 정답은 <%=answer32%>입니다</li>
	<li><%=result33%> 정답은 <%=answer33%>입니다</li>
	<li><%=result34%> 정답은 <%=answer34%>입니다</li>
	</ol>
	3번
	<ol>
	<li><%=result41%> 정답은 <%=answer41%>입니다</li>
	<li><%=result42%> 정답은 <%=answer42%>입니다</li>
	<li><%=result43%> 정답은 <%=answer43%>입니다</li>
	<li><%=result44%> 정답은 <%=answer44%>입니다</li>
	</ol>
	4번
	<ol>
	<li><%=result51%> 정답은 <%=answer51%>입니다</li>
	<li><%=result52%> 정답은 <%=answer52%>입니다</li>
	<li><%=result53%> 정답은 <%=answer53%>입니다</li>
	<li><%=result54%> 정답은 <%=answer54%>입니다</li>
	</ol>
	
	<span>총점수는<%=score%>입니다</span>
</body>
</html>