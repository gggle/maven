<%@page import="java.util.Map.Entry"%>
<%@page import="kr.or.ddit.vo.BuyerVO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.vo.ProdVO"%>
<%@page import="kr.or.ddit.vo.PagingInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	PagingInfoVO<ProdVO> pagingVO = (PagingInfoVO<ProdVO>)request.getAttribute("pagingVO");
	List<ProdVO> prodList = pagingVO.getDataList();
	
	List<Map<String,Object>> lprodList = (List) request.getAttribute("lprodList");
	List<BuyerVO> buyerList = (List) request.getAttribute("buyerList");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script type="text/javascript" 
	src="${pageContext.request.contextPath }/js/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script type="text/javascript">
	function ${pagingVO.funcName}(page){
		$("[name='searchForm']").find("[name='page']").val(page);
		//document.searchForm.page.value=page;
		$("[name='searchForm']").submit();
		//document.searchForm.submit();
	}
	$(function(){
		var prod_lguTag = $("[name='prod_lgu']");
		var prod_buyerTag = $("[name='prod_buyer']");
		prod_lguTag.val("${pagingVO.searchVO.prod_lgu }");
		prod_buyerTag.val("${pagingVO.searchVO.prod_buyer }");
		prod_lguTag.on("change", function(){
			var lprod_gu = $(this).val();
			var buyerOptions = prod_buyerTag.find("option");
			$(buyerOptions).hide();
			if(lprod_gu){
				var buyerOptions2 = prod_buyerTag.find("option."+lprod_gu);
				$(buyerOptions2).show();
			}else{
				$(buyerOptions).show();
			}
			
		});
		var listBody = $("#listBody");
		listBody.on("click", "tr" ,function(){
			var prod_id = $(this).find("td:first").text();
			location.href = "${pageContext.request.contextPath }/prod/prodView.do?what="+prod_id;
		});
		 $("[name='searchForm']").on("submit",function(event){
			event.preventDefault();
				var data = $(this).serialize(); //queryString 생성
			$.ajax({
				data : data,
				dataType : "json",
				success : function(resp) {
					var prodList = resp.dataList;
					var html ="";
					if(prodList){
						$.each(prodList,function(idx, prod){
							html += "<tr>";
							html += "<td>"+prod.prod_id+"</td>";
							html += "<td>"+prod.prod_name+"</td>";
							html += "<td>"+prod.lprod_nm+"</td>";
							html += "<td>"+prod.buyer_name+"</td>";
							html += "<td>"+prod.prod_cost+"</td>";
							html += "<td>"+prod.prod_outline+"</td>";
							html += "<td>"+prod.prod_mileage+"</td>";
							html += "</tr>";
						});
					}else{
						html += "<tr><td colspan='7'>상품이 없음</td></tr>";
					}
					listBody.html(html);
					$("#pagingArea").html(resp.pagingHTML);
					$("[name='page']").val("");
				},
				error : function(resp) { // 에러 응답 데이터를 받음
				}
			});
			return false;
		}); 
	});
</script>
</head>
<body>
<!-- 스크린사이즈 7 -->
<!-- 블럭사이즈 4  -->
<form name="searchForm">
	<input type="text" name="page" />
	<select name="prod_lgu">
		<option value="">분류선택</option>
		<%
			for(Map<String,Object> lprod : lprodList){
				%>
				<option value="${lprod.lprod_gu}">${lprod.lprod_nm}</option><!--체크  -->
				<%
			}
		%>
	</select>
	<select name="prod_buyer">
		<option value="">거래처선택</option>
		<%
			for(BuyerVO buyer : buyerList){
				%>
				<option value="${buyer.buyer_id}" class="${buyer.buyer_lgu}">${buyer.buyer_name}</option>
				<%
			}
		%>
	</select>
	<input type="text" name="prod_name" value="${pagingVO.searchVO.prod_name }" />
	<input type="submit" value="검색" />
</form>
<input type="button" class="btn btn-info" value="신규상품등록" 
	onclick="location.href='${pageContext.request.contextPath }/prod/prodInsert.do';"
/>
<table class="table">
	<thead>
		<tr>
			<th>상품코드</th>
			<th>상품명</th>
			<th>분류명</th>
			<th>거래처명</th>
			<th>판매가</th>
			<th>상품개요</th>
			<th>마일리지</th>
		</tr>
	</thead>
	<tbody id="listBody">
		<%
			if(prodList.size()>0){
				for(ProdVO prod : prodList){
					 pageContext.setAttribute("prod", prod);
					%>
					<tr>
						<td>${prod.prod_id}</td>
						<td>${prod.prod_name} </td>
						<td>${prod.lprod_nm}</td>
						<td>${prod.buyer_name}</td>
						<td>${prod.prod_price}</td>
						<td>${prod.prod_outline}</td>
						<td>${prod.prod_mileage}</td>
					</tr>
					<%
				}
			}else{
				%>
				<tr>
					<td colspan="7">조건에 맞는 상품이 없슴.</td>
				</tr>
				<%
			}
		%>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="7">
				<nav aria-label="Page navigation example" id="pagingArea">
					${pagingVO.pagingHTML}
				</nav>
			</td>
		</tr>
	</tfoot>
</table>
</body>
</html>