<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	
	<!-- 회원가입 -->
    <section class="page-section" id="contact" style="margin-top:120px">
        <div class="container">
            <!-- Contact Section Heading-->
            <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">마이페이지</h2>
            <!-- Icon Divider-->
            <div class="divider-custom">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon">
                	<!-- 없을때 -->
                	<c:if test="${sessionScope.login.profileImg == null }">
	                	<img alt="" src="${pageContext.request.contextPath}/assets/img/non.png" id="myImage" class="rounded-circle img-thumbnail shadow-sm" width="200" style="cursor:pointer;">
                	</c:if>
                	<c:if test="${sessionScope.login.profileImg != null }">
	                	<img alt="" src="${pageContext.request.contextPath}${sessionScope.login.profileImg}" id="myImage" class="rounded-circle img-thumbnail shadow-sm" width="200" style="cursor:pointer;">
                	</c:if>
                	<form action="" id="profileForm" enctype="multipart/form-data">
                		<input accept="image/*" type="file" style="display:none;" name="uploadImage" id="uploadImage">
                	</form>
                </div>
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
                    <form id="contactForm" action="${pageContext.request.contextPath}/loginDo" method="post" data-sb-form-api-token="API_TOKEN">
                        <div class="form-floating mb-3">
                            <input class="form-control" id="name" value="${cookie.rememberId.value}" name="memId" type="text" placeholder="아이디를 입력하세요..." data-sb-validations="required" />
                            <label for="">아이디</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input class="form-control" name="memPw" type="password" placeholder="비밀번호를 입력하세요..." data-sb-validations="required,email" />
                            <label for="">패스워드</label>
                        </div>
                        <!-- 아이디 기억 -->
                        <div class="form-floating mb-3">
                        	<input ${cookie.rememberId.value == null ? "" : "checked"} type="checkbox" class="form-check-input" name="remember">아이디 기억하기</input>
                        </div>
                        <button class="btn btn-primary btn-xl" id="submitButton" type="submit">로그인</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
        
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
	
	<script>
		$(document).ready(function(){
			$("#myImage").click(function(){
				$("#uploadImage").click();
			});
			
			// file을 선택하면
			$("#uploadImage").on("change", function(){
				var file = $(this)[0].files[0];
				if(file){
					var fileType = file["type"];
					var checkType = ["image/gif", "image/jpeg", "image/jpg", "image/png"];
					if(!checkType.includes(fileType)){
						alert("유효한 이미지 타입이 아닙니다.");
						$(this).val("") //파일선택 초기화
					} else{
						// 전송
						// html 폼 데이터를 쉽게 가져옴
						var formData = new FormData($("#profileForm")[0]);
						$.ajax({
							url : "<c:url value='/files/upload'/>"
							,type : "POST"
							,data : formData
							,processData : false // 전송 객체를 URL인코딩 하지 않도록
							,contentType : false // 파일을 이진 데이터 형태로 전송하기 위해
							,success : function(res){
								console.log(res);
								if(res.message == "success"){
									$("#myImage").attr("src", "${pageContext.request.contextPath}" + res.imagePath);
								}
							}
							,error : function(e){
								console.log(e);
							}
						})
						
					}
				}
			});
		});
	</script>
</body>
</html>