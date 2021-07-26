<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
   var webSocket = null;
   var first = "true";
   $('#sendBtn').attr("disabled", true);

   //DOCUMENT READY FUNCTION START
   $(document).ready(function() {
      //memberGubun = "${sessionScope.memberGubun}";
      //trainerId = "${sessionScope.memberId}";
      connect();

      $('#sendBtn').click(function() {
         send(textMessage.value); //send function 
         textMessage.value = "";
      });

      $('#textMessage').keypress(function(e) {
         if (e.which == 13) {
            send(textMessage.value);
            textMessage.value = "";
         }
      });

      $('#leaveBtn').click(function() {
         websocket.close();
         window.close();
      });

   });
   //DOCUMENT READY FUNCTION END

   function connect() {
      var url = 'ws://' + window.location.host
            + '${pageContext.request.contextPath}/chat/'
            + '<c:out value="${roomId}"/>';
      console.log(url)
      var ws = new WebSocket(url);
      webSocket = ws;

      ws.onopen = function() {
         console.log('Info: connection opened.');
         send('<c:out value="${username}"/>');
         $('#sendBtn').attr("disabled", false);
      };

      ws.onmessage = function(message) {
         console.log(message);
         console.log("ReceiveMessage:", message.data + '\n');
         processMessage(message);
      };

      ws.onclose = function(event) {
         console.log('Info: connection closed.');
      };

      ws.onerror = function(err) {
         console.log('Error:', err);
      };
   }

   //오픈 메세지 보내는 부분!!!
   function send(message) {
      webSocket.send(JSON.stringify({
         'message' : message,
         'room' : "<c:out value='${roomId}'/>"
      }));
   }

   //프로세스 중
   function processMessage(message) {
      
      var jsonData = JSON.parse(message.data);

      console.log("프로세스중")
      if (jsonData.messageType == "ChatMessage") {
         console.log("ChatMessage 받음");
         message = jsonData.name + " : " + jsonData.message + '\n';
         //display(message);

         displaybubble(jsonData);

         //첫번째 턴일때 메세지 받으면 이곳으로 온다!   
      } else if (jsonData.messageType == "UsersMessage") {
         console.log("UsersMessage받음");
         var other = "";
         for (var i = 0; i < jsonData.users.length; i++) {
            if ("${sessionScope.memberId}" != jsonData.users[i]) {
               $('#users').append(jsonData.users[i] + "님과 대화중입니다");
               other = jsonData.users[i];
               first = "false";
            }
         }
         if (first == "false" && other == "") {
            $('#users').empty();
            $('#users').append("");//대화상대가 아무도 없습니다.
         }
      }
      
      $('#chat-content').scrollTop($('#chat-content')[0].scrollHeight);
   }
   
   
   
   function displaybubble(data) {
      //data.name => 아이디 
      //보낸사람이 나일때
      if (data.name == "${sessionScope.memberId}") {
         if($('#chat-content div').last().hasClass("reverse")){
            $('#chat-content div').last().append("<p>"+ data.message + "</p>");
         }else {
            $('#chat-content').append("<div class='media media-chat media-chat-reverse'><div class='media-body reverse'><p>"
                     + data.message + "</p></div></div>");
         }
         
         
      //상대방한테 메세지 받음
      } else {
         if($('#chat-content div').last().hasClass("reverse") || $('#chat-content div').last().hasClass("empty")){
            $('#chat-content').append("<div class='media media-chat'><img class='avatar' src='https://img.icons8.com/color/36/000000/administrator-male.png'><div class='media-body'><p>"
                  + data.message + "</p></div></div>");
         }else {
            $('#chat-content div').last().append("<p>"+ data.message + "</p>");
         }
         
         
      }
   }

   function processError(message) {
   }

   window.onbeforeunload = function() {
      websocket.close();

   };
</script>
</head>
<body>
   <!-- Breadcrumb Begin -->
   <section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <div class="breadcrumb__text">
                  <h2>1:1 상담</h2>
               </div>
            </div>
         </div>
      </div>
   </section>
   
   <input type="button" id="leaveBtn" name="leaveBtn" value="Leave" />

   <div class="page-content page-container" id="page-content">
      <div style="margin-top: 30px; margin-bottom: 30px;">
         <div class="row container d-flex justify-content-center" style="margin-right: auto; margin-left: auto;">
            <div class="col-md-6">
               <div class="card card-bordered" style="width: 450px;">
                  <div class="card-header">
                     <div id="users" style="font-size: 18px;"></div>
                     <a class="btn btn-xs btn-secondary" href="#" data-abc="true">Let's Chat App</a>
                  </div>
                  
                  
                  
                  
                  <!-- chat-content DIV 시작 -->
                  <div id="chat-content" class="ps-container ps-theme-default ps-active-y" style="overflow-y: scroll !important; height: 600px !important;" >
                     <!-- <div class="ps-scrollbar-x-rail" style="left: 0px; bottom: 0px;">
                        <div class="ps-scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                     </div>
                     <div class="ps-scrollbar-y-rail" style="top: 0px; height: 0px; right: 2px;">
                        <div class="ps-scrollbar-y" tabindex="0" style="top: 0px; height: 2px;"></div>
                     </div> -->
                     
                  
                     
                     
                     
                     
                     <div class="empty"></div>
                     <!--  
                     <div class="media media-chat media-chat-reverse">
                        <div class="media-body">
                        <p>안녕</p>
                        </div>
                     </div>
                     
                     

                     <div class="media media-chat media-chat-reverse">
                        <div class="media-body">
                        <p>안녕</p>
                        <p>안녕</p>
                        </div>
                     </div>
                      
                     
                     <div class="media media-chat">
                        <img class="avatar"
                           src="https://img.icons8.com/color/36/000000/administrator-male.png"
                           alt="...">
                        <div class="media-body">
                           <p>Hi</p>
                           <p>How are you ...???</p>
                           <p>
                              What are you doing tomorrow?<br> Can we come up a bar?
                           </p>
                           <p class="meta">
                              <time datetime="2018">23:58</time>
                           </p>
                        </div>
                     </div>
                     <div class="media media-meta-day">Today</div>
                     <div class="media media-chat media-chat-reverse">
                        <div class="media-body">
                           <p>Hiii, I'm good.</p>
                           <p>How are you doing?</p>
                           <p>Long time no see! Tomorrow office. will be free on
                              sunday.Long time no see! Tomorrow office. will be free on
                              sunday.</p>
                           <p class="meta">
                              <time datetime="2018">00:06</time>
                           </p>
                        </div>
                     </div>
                      -->
                  
                  </div>
                  <!-- chat-content DIV 끝 -->
                  
                  
                  <div class="publisher bt-1 border-light">
                     <img class="avatar avatar-xs" src="https://img.icons8.com/color/36/000000/administrator-male.png">
                     
                     <input id="textMessage" class="publisher-input" type="text" placeholder="Write something"> 
                     
                     <input type="button" id="sendBtn" name="sendBtn" value="Send" />
                     
                     <a class="publisher-btn text-info" href="#" data-abc="true"><i class="fa fa-paper-plane"></i></a>
                     
                     <span class="publisher-btn file-group"><i class="fa fa-paperclip file-browser"></i><input type="file"></span> 
                     
                  </div>
                  <div class="publisher bt-1" style="background-color: #f9fafb; border: none;">
                     <div class="classes__item__text" style="text-align: center; padding-top: 10px; padding-left: 0; padding-right: 0">
                        <a href="chatDetail" class="class-btn_w" style="font-size: 1.1em; width: 410px; height: 50px;">상담종료</a>
                     </div>
                  </div>
               </div>

            </div>

         </div>
      </div>
   </div>
</body>
<!-- Js Plugins -->
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/jquery.nice-select.min.js"></script>
<script src="./resources/js/jquery.barfiller.js"></script>
<script src="./resources/js/jquery.slicknav.js"></script>
<script src="./resources/js/owl.carousel.min.js"></script>
<script src="./resources/js/main.js"></script>

<!--     <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js" rel="stylesheet"> -->
<link href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" rel="stylesheet">
<!--     <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet"> -->

</html>