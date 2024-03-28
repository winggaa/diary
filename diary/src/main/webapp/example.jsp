<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%

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

//System.out.println(" \"\" <<<<<<< ");

String num11 = request.getParameter("11");
String num12 = request.getParameter("12");
String num13 = request.getParameter("13");
String num14 = request.getParameter("14");
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

int score = 0;
int question = 5;
int answerScore = 100/question ;
int problem = 4;
int partialScore =  answerScore/4;


/*
if(num11.equals("11")){
	score = score + partialScore ;  
	result11 = "O";}
if(num11.equals("12")){
	score = score + partialScore ;  
	result12 = "O";}
if(num11.equals("13")){
	score = score + partialScore ;  
	result13 = "O";}
if(num11.equals("14")){
	score = score + partialScore ;  
	result14 = "O";}

*/
	




         

%>




<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>

<form action="/diary/exampleAction.jsp">
1.자바 프로그램 개발 과정을 순서대로 적어 보세요. <input type="text" value="" name=11>
<ol>
<li>javac 명령어로 컴파일한다.</li>

<li>소스파일(~.java)을 작성한다</li>

<li>java 명령어로 실행한다.</li>

<li>실행결과를 확인한다.</li>
</ol>

2.자바 소스에 대한 설명 중 맞는 것에 O표 틀린곳에x표 하세요. 
<ol>
<li>컴파일하면'클래스이름.class'라는 바이트 코드 파일이 생성된다.				<input type="radio" value="O" name=21>O
															<input type="radio" value="X" name=21>X</li>

<li>main()메소드는 반드시 클래스 블록 내부에서 작성해야 한다.					<input type="radio" value="O" name=22>O
															<input type="radio" value="X" name=22>X</li>

<li>main() 메소드를 작성할 때 중괄호 블록을 만들지 않아도 된다.					<input type="radio" value="O" name=23>O
															<input type="radio" value="X" name=23>X</li>

<li>컴파일 후 실행을 하려면 반드시 main() 메소드가 있어야 한다.					<input type="radio" value="O" name=24>O
															<input type="radio" value="X" name=24>X</li>
</ol>

3. 주석에 대한 설명 중 맞는 것에 O표, 틀린 곳에X표 하세요.
<ol>
<li>//뒤의 라인 내용은 모두 주석이 된다.									<input type="radio" value="O" name=31>O
															<input type="radio" value="X" name=31>X
</li>

<li>/*부터 시작해서 */까지 모든 내용이 주석이 된다.							<input type="radio" value="O" name=32>O
															<input type="radio" value="X" name=32>X	</li>

<li>주석이 많으면 바이트코드 파일의 크기가 커지므로 꼭 필요할 경우에만 작성한다.			<input type="radio" value="O" name=33>O
															<input type="radio" value="X" name=33>X </li>

<li>문자열 안에는 주석을 만들 수 없다.									<input type="radio" value="O" name=34>O
															<input type="radio" value="X" name=34>X </li>
</ol>

4. 이클립스의 자바 프로젝트에 대해 설명한 것 중 맞는 것에O표, 틀린 곳에 x표 하세요.
<ol>
<li>기본적으로 소스 파일과 바이트 코드 파일이 저장되는 폴더가 다르다. 				<input type="radio" value="O" name=41>O
															<input type="radio" value="X" name=41>X </li>
																				
<li>자바 소스 파일을 작성하는 폴더는 src이다.								<input type="radio" value="O" name=42>O
															<input type="radio" value="X" name=42>X </li>

<li>선언되는 클래스 이름은 소스 파일 이름과 달라도 상관없다. 					<input type="radio" value="O" name=43>O
															<input type="radio" value="X" name=43>X </li>

<li>올바르게 작성된 소스 파일을 저장하면 자동으로 컴파일되고, 바이트 코드 파일이 생성된다.	<input type="radio" value="O" name=44>O
															<input type="radio" value="X" name=44>X </li>
</ol>

5.이클립스에서 바이트 코드 파일을 실행하는 방법을 모두 선택해보세요. 
<ol>
<li>Package Explorer 뷰에서 소스 파일을 더블클릭한다. 					<input type="radio" value="O" name=51>O
															<input type="radio" value="X" name=51>X</li>

<li>Package Explorer 뷰에서 바이트 코드 파일을 선택하고, 툴 바에서 Run 아이콘을 클릭한다.<input type="radio" value="O" name=52>O
																<input type="radio" value="X" name=52>X</li>

<li>Package Explorer 뷰에서 소스 파일을 선택하고, 툴 바에서 Run 아이콘을 클릭한다.	 <input type="radio" value="O" name=53>O
																<input type="radio" value="X" name=53>X</li>

<li>Package Explorer 뷰에서 소스 파일을 선택하고, 마우스 오른쪽 버튼을 클릭한 후 [Run As]-[Java Application]을 선택한다 <input type="radio" value="O" name=54>O
																							  <input type="radio" value="X" name=54>X</li>
</ol>
<button type="submit">제출</button>



</form>
</body>
</html>