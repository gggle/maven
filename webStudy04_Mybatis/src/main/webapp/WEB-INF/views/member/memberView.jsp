<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://jqueryui.com/resources/demos/style.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function(){
		<c:if test="${not empty message }">
			alert('${message}');
			<c:remove var="message" scope="session"/>
		</c:if>
		
		$(".date").datepicker({
			dateFormat : "yy-mm-dd"
		});
		$("#delBtn").on("click", function(){
			var chk = confirm(" 정말로 탈퇴 ?");
			if(chk){
				var password = prompt("비밀번호 입력");
				if(password){
					document.delForm.mem_pass.value=password;
	// 				$("[name='mem_pass']").val(password);
					document.delForm.submit();
				}
			}
		});	
	});
</script>
</head>
<body>
<jsp:useBean id="member" class="kr.or.ddit.vo.MemberVO" scope="request" />
<%-- <jsp:useBean id="errors" class="java.util.LinkedHashMap" scope="request" /> --%>
<c:set var="mutable" value="false" />
${not empty sessionScope.authMember and 'ROLE_ADMIN' ne sessionScope.authMember.mem_auth } ------
<c:if test="${not empty sessionScope.authMember and 'ROLE_ADMIN' ne sessionScope.authMember.mem_auth }">
	<c:if test="${sessionScope.authMember.mem_id eq member.mem_id }">
		<c:set var="mutable" value="true" />
	</c:if>
</c:if>
<c:if test="${mutable }">
<form name="delForm" method="post" action="${pageContext.request.contextPath }/member/memberDelete.do">
 	<input type="hidden" name="mem_id" value="${member.mem_id }"/>
 	<input type="hidden" name="mem_pass" />
</form>
<form action="${pageContext.request.contextPath }/member/memberUpdate.do" method="post">
</c:if>
<h4>회원정보 상세조회 및 수정폼</h4>
	<table>
			<tr>
				<th>회원아이디</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_id"
							value="${member.mem_id }" />
							<span class="error input-group-text">${errors["mem_id"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_pass"
							value="${member.mem_pass }" />
							<span class="error input-group-text">${errors["mem_pass"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>회원명</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_name"
							value="${member.mem_name }" />
							<span class="error input-group-text">${errors["mem_name"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>주민번호</th>
				<td><div class="input-group">
						<input class="form-control col-md-2" type="text" name="mem_regno1"
							value="${member.mem_regno1 }" disabled="disabled" />
						<span class="input-group-text">-</span>	
						<input class="form-control col-md-2" type="text" name="mem_regno2"
							value="${member.mem_regno2 }" disabled="disabled"/>
							<span class="error input-group-text">${errors["mem_regno1"] }</span>
							<span class="error input-group-text">${errors["mem_regno2"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>생일</th>
				<td><div class="input-group">
						<input class="form-control date" type="text" name="mem_bir"
							value="${member.mem_bir }" disabled="disabled"/>
							<span class="error input-group-text">${errors["mem_bir"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_zip"
							value="${member.mem_zip }" />
							<span class="error input-group-text">${errors["mem_zip"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>주소1</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_add1"
							value="${member.mem_add1 }" />
							<span class="error input-group-text">${errors["mem_add1"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>주소2</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_add2"
							value="${member.mem_add2 }" />
							<span class="error input-group-text">${errors["mem_add2"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>집전번</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_hometel"
							value="${member.mem_hometel }" />
							<span class="error input-group-text">${errors["mem_hometel"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>회사전번</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_comtel"
							value="${member.mem_comtel }" />
							<span class="error input-group-text">${errors["mem_comtel"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_hp"
							value="${member.mem_hp }" />
							<span class="error input-group-text">${errors["mem_hp"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_mail"
							value="${member.mem_mail }" />
							<span class="error input-group-text">${errors["mem_mail"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>직업</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_job"
							value="${member.mem_job }" />
							<span class="error input-group-text">${errors["mem_job"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>취미</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_like"
							value="${member.mem_like }" />
							<span class="error input-group-text">${errors["mem_like"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>기념일</th>
				<td><div class="input-group">
						<input class="form-control" type="text" name="mem_memorial"
							value="${member.mem_memorial }" />
							<span class="error input-group-text">${errors["mem_memorial"] }</span>
					</div></td>
			</tr>
			<tr>
				<th>기념일자</th>
				<td><div class="input-group">
						<input class="form-control date" type="text" name="mem_memorialday"
							value="${member.mem_memorialday }" />
							<span class="error input-group-text">${errors["mem_memorialday"] }</span>
					</div></td>
			</tr>
		<tr>
			<th>마일리지</th>
			<td>${member.mem_mileage }</td>
		</tr>
		<tr>
			<th>탈퇴여부</th>
			<td>${member.mem_delete eq 'Y'?"탈퇴":"활동중" }</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" class="btn btn-info" value="뒤로가기" 
					onclick="history.back();"
				/>
				<c:if test="${mutable }">
					<input type="submit" class="btn btn-success" value="수정" />
					<input type="reset" class="btn btn-info" value="취소" />
					<input type="button" value="탈퇴" id="delBtn"/>
				</c:if>
			</td>
		</tr>
	</table>
	${mutable } --------------
<c:if test="${mutable }">	
</form>	
</c:if>
<h4>구매상품목록</h4>
<table class="table">
	<thead>
		<tr>
			<th>상품코드</th>
			<th>상품명</th>
			<th>구매가</th>
			<th>판매가</th>
			<th>상품개요</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="prodList" value="${member.prodList }" />
		<c:choose>
			<c:when test="${not empty prodList }">
				<c:forEach items="${prodList }" var="prod">
					<tr>
						<td>${prod.prod_id }</td>
						<td>${prod.prod_name }</td>
						<td>${prod.prod_cost }</td>
						<td>${prod.prod_price }</td>
						<td>${prod.prod_outline }</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5">구매상품이 엄슴.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
</body>
</html>