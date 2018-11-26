<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.vo.BuyerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	BuyerVO buyerInfo = (BuyerVO)request.getAttribute("buyer");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="table">
		<thead class="thead-dark">
		<tr>
			<th>BUYER_ID</th>
			<th>BUYER_NAME</th>
			<th>BUYER_LGU</th>
			<th>BUYER_BANK</th>
			<th>BUYER_BANKNO</th>
			<th>BUYER_BANKNAME</th>
			<th>BUYER_ZIP</th>
			<th>BUYER_ADD1</th>
			<th>BUYER_ADD2</th>
			<th>BUYER_COMTEL</th>
			<th>BUYER_FAX</th>
			<th>BUYER_MAIL</th>
			<th>BUYER_CHARGER</th>
			<th>BUYER_TELEXT</th>
		</tr>
		</thead>
		<tbody>
					<tr>
					<td><%=buyerInfo.getBuyer_id() %></td>
					</tr>
		</tbody>
	</table>
</body>
</html>