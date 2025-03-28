<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >

<body>
	<jsp:include page="/WEB-INF/inc/top.jsp" ></jsp:include>
	<section class="page-section" id="contact">
		<div class="container" style="margin-top: 100px;">
                <table class="table table-striped table-bordered">
                    <tr>
                        <th>제목</th>
                        <td><input value="${free.boTitle }" class="form-control input-sm" type="text" name="boTitle"></td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td><input value="${free.boWriter }" class="form-control input-sm" type="text" name="boWriter"></td>
                    </tr>
                    <tr>
                    	<th>분류</th>
                    	<td><input value="${free.boCategoryNm }" class="form-control input-sm" type="text" name="boCategoryNm"></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>${free.boContent }</td>
                    </tr>
                </table>
		</div>
	</section>
	<jsp:include page="/WEB-INF/inc/footer.jsp" ></jsp:include>
</body>
</html>






