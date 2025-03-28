<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>채팅</title>
        <style>
			.chat-containerK {
				/* overflow: hidden; */
				width : 100%;
				/* max-width : 200px; */
			}
			.chatcontent {
				height: 700px;
				width : 100%;
				/* width:300px; */
				overflow-y: scroll;
			}
			.chat-fix {
				position: fixed;
				bottom: 0;
				width: 100%;
			}
			#alertK{
				display : none;
			}
			#msgi{	
				resize: none;
			}
			.myChat{
				background-color : #E0B1D0;
			}
			li{
				list-style-type:none;
			}
			.chatBox{
				display : inline-block;
			}
			.chatBox dateK{
				vertical-align: text-bottom;
			} 
			.me{
				text-align : right;
				/* text-align:center; */
			}
			.chat-box{
				max-width : 200px;
				display: inline-block;
				border-radius: 15px;
			}
			.notification{
				text-align : center;
			}
		</style>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<jsp:include page="/WEB-INF/inc/top.jsp" ></jsp:include>
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;">
                <div id="chat-containerK">
					<div class="chatWrap">
						<div class="main_tit">
							<h1>방 정보: [${roomNo }] </h1>
						</div>
						<div class="content chatcontent border border-secondary" data-room-no="" >
							<div id="list-guestbook" class="">
									<c:forEach items="${chatList }" var="chat">
							     
									<!-- 내 채팅일 경우 -->
									<c:if test="${sessionScope.login.memId eq chat.memId }">
										<li data-no="" class="me pr-2">
											<strong class="">${chat.memId } (${chat.memNm })</strong>
											<div class="me">
												<p class='myChat chat-box text-left p-3'>${chat.chatMsg }</p>
     											<strong style="display : inline;" class="align-self-end">${chat.sendDate }</strong>
											</div>
										</li>
									</c:if>
									<!-- 다른사람의 채팅일 경우 -->
									<c:if test="${sessionScope.login.memId ne chat.memId }"> <!-- ne = not eq -->
										<li data-no="" class="pl-2">
											<strong>${chat.memId } (${chat.memNm })</strong>
											<div>
												<p class='chat-box bg-light p-3'>${chat.chatMsg }</p>
												<strong style="display : inline;" class="align-self-center">${chat.sendDate }</strong>
											</div>
										</li>
									</c:if>
									</c:forEach>
							</div>
						</div>
						<div>
							<div class="d-flex justify-content-center" style="height: 60px">
								<input type="text" id="msgi" name="msg" class="form-control" style="width: 75%; height: 100%">
								<button type="button" id="btnSend" class="send btn btn-primary" style="width: 25%; height: 100%">보내기</button>
								<button type="button" id="btnOut" class="btn btn-secondary " style="width: 25%; height: 100%">나가기</button>
							</div>
						</div>
					</div>
				</div>
            </div>
        </section>

        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<jsp:include page="/WEB-INF/inc/footer.jsp" ></jsp:include>
		<script src="<c:url value='/js/sockjs.min.js' />"></script>
		<!-- sockjs.min.js -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>	
		<script>
		  $(document).ready(function(){
			  var client;
			  var memId = '${sessionScope.login.memId}';
			  var memNm = '${sessionScope.login.memNm}';
			  var roomNo = '${roomNo}';
			  // 소켓 접속
			  var sock = new SockJS("<c:url value='/endpoint' />");
			  client = Stomp.over(sock);
			  console.log(client);
			  // 최초 연결시 메시지 전송
			  client.connect({"userId":memId, "roomNo":roomNo}, function(){
				  // 상대방이 보낸 메세지가 전달 받았을때
				  client.subscribe("/subscribe/chat/"+roomNo, function(chat){
					  var body = JSON.parse(chat.body);
					  console.log(body);
					  if(body.type=='notification'){
						  var str = '<div class="notification">' + body.message + '</div>'
						  $("#list-guestbook").append(str);
					  }else{
						  console.log(body);
						  $("#list-guestbook").append(renderMsg(body));
					  }
				  });
			  });
			  // 창 나갔을때
			  window.onbeforeunload = function(){
				  disconnect();
			  }
			  // 나가기
			  function disconnect(){
				  // 종료 직전 나간다고 전송
				  client.send("/subscribe/chat/" + roomNo, {}, JSON.stringify({"type":"notification", "message": memId + "님이 나가셨습니다."}));
				  client.disconnect();
			  }
			  // 메세지 전송
			  function sendmsg(){
				  var msg = $("#msgi").val()
				  if(msg == ""){
					  return false;
				  }
				  client.send("/app/hello/" + roomNo, {}, JSON.stringify({
					  chatMsg:msg,
					  memId:memId,
					  roomNo:roomNo,
					  memNm:memNm
				  }))
				  $("#msgi").val('');
			  }
			  // 메세지 출력
			  function renderMsg(vo){
				  var str = "";
				  var content = "";
				  // 내가 쓴
				  if(vo.memId == memId){
					content = "<p class='myChat chat-box text-left p-3'>"+vo.chatMsg+"</p>";
					str = "<li data-no='' class='me pr-2'>"
					str +="<strong>" + vo.memId + "(" + vo.memNm + ")</strong>";
					str += "<div class='me'>" + content + '<strong style="display : inline;" class="align-self-end">' + vo.sendDate + '</strong>';
					str += "</div>";
					str += "</li>";
				  // 다른 사람
				  } else{
					content = "<p class='chat-box bg-light p-3'>"+vo.chatMsg+"</p>";
					str = "<li data-no='' class='pr-2'>"
					str +="<strong>" + vo.memId + "(" + vo.memNm + ")</strong>";
					str += "<div>" + content + '<strong style="display : inline;" class="align-self-end">' + vo.sendDate + '</strong>';
					str += "</div>";
					str += "</li>";
				  }
				  return str;
			  }
			  
			  // 버튼 클릭
			  $("#btnSend").click(function(){
				  sendmsg();
			  });
			  // 엔터
			  $("#msgi").keydown(function(e){
				  if(e.keyCode == 13){
					  sendmsg();
				  }
			  })
		  });	
		</script>
    </body>
</html>


