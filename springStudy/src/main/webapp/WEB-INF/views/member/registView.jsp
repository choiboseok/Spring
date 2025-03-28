<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	.error{color:red; font-size:0.9em;}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	
	<!-- 회원가입 -->
    <section class="page-section" id="contact" style="margin-top:120px">
        <div class="container">
            <!-- Contact Section Heading-->
            <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">회원가입</h2>
            <!-- Icon Divider-->
            <div class="divider-custom">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                <div class="divider-custom-line"></div>
            </div>
            <!-- Contact Section Form-->
            <div class="row justify-content-center">
                <div class="col-lg-8 col-xl-7">
                    <!-- * * * * * * * * * * * * * * *-->
                    <!-- * * SB Forms Contact Form * *-->
                    <!-- * * * * * * * * * * * * * * *-->
                    <!-- This form is pre-integrated with SB Forms.-->
                    <!-- To make this form functional, sign up at-->
                    <!-- https://startbootstrap.com/solution/contact-forms-->
                    <!-- to get an API token!-->
                    <!-- form:form teg modelAttribute는 서버 validation 체크를 유지함. -->
                    <form:form id="contactForm" modelAttribute="member" action="${pageContext.request.contextPath}/registDo" method="post" data-sb-form-api-token="API_TOKEN">
                        <!-- Name input-->
                        <div class="form-floating mb-3">
                            <form:input class="form-control" path="memId" id="name" name="memId" type="text" placeholder="아이디를 입력하세요..." data-sb-validations="required" />
                            <form:errors path="memId" cssClass="error" />
                            <label for="">아이디</label>
                        </div>
                        <!-- Email address input-->
                        <div class="form-floating mb-3">
                            <form:input class="form-control" path="memPw" name="memPw" type="password" placeholder="비밀번호를 입력하세요..." data-sb-validations="required,email" />
                            <form:errors path="memPw" cssClass="error" />
                            <label for="">패스워드</label>
                        </div>
                        <!-- Phone number input-->
                        <div class="form-floating mb-3">
                            <form:input class="form-control" path="memNm" name="memNm" type="text" placeholder="이름을 입력하세요..." data-sb-validations="required" />
                            <form:errors path="memNm" cssClass="error" />
                            <label for="">이름</label>
                        </div>
                        <button class="btn btn-primary btn-xl" id="submitButton" type="submit">회원가입</button>
                    </form:form>
                </div>
            </div>
        </div>
    </section>
        
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
	
	<!-- Modal -->
	<div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">${msgVO.title } </h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
		      <div class="modal-body">
                    <!-- title input-->
                    <div class="mb-3">
                        <label for="title">${msgVO.message }</label>
                    </div>
                    <a href="<c:url value='${msgVO.url }'/>"> ${msgVO.url }로 가기 </a>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
	    </div>
	  </div>
	</div>
	
	<script>
	$(document).ready(function(){
		var message = "${msgVO.message}";
		if(message != ''){
			$("#messageModal").modal('show');
		}
	});
	</script>
</body>
</html>