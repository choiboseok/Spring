<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>채팅방 목록</title>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<jsp:include page="/WEB-INF/inc/top.jsp" ></jsp:include>
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;min-height: 400px;">
                <table class="table table-hover">
                	<thead>
                		<tr>
                			<th>방번호</th>
                			<th>방제목</th>
                			<th>방장</th>
                			<th>생성일</th>
                		</tr>
                	</thead>
                	<tbody>
                		<!-- 데이터의 수만큼 반복되는 부분 -->
                		<c:forEach items="${roomList }" var="room">
							<tr>
								<td>${room.roomNo }</td>
								<td><a href="<c:url value='chatView?roomNo=${room.roomNo }' /> ">${room.roomName }</a></td>
								<td>${room.memNm }</td>
								<td>${room.regDate }</td>
							</tr>   
						</c:forEach>
                	</tbody>
                </table>
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#roomModal">채팅방 생성</button>
                </div>
            </div>
        </section>

        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<jsp:include page="/WEB-INF/inc/footer.jsp" ></jsp:include>
		
		<!-- Modal -->
		<div class="modal fade" id="roomModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">채팅방 이름을 작성해 주세요 ^^ </h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
				  <form action="<c:url value='/roomCreateDo' />" method="post"> 
				      <div class="modal-body">
		                     <!-- title input-->
		                     <div class="mb-3">
		                         <label for="title">방 제목</label>
		                         <input class="form-control" id="title" name="roomName" type="text" />
		                     </div>
		                     <input type="hidden" value="${sessionScope.login.memId }" name="memId">
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				        <button type="submit" class="btn btn-primary">방 생성</button>
				      </div>
			      </form>
		    </div>
		  </div>
		</div>
    </body>
</html>


