<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
   String wsURL = "ws://"+request.getServerName()+":"+request.getServerPort()+cp+"/chat.msg";
%>

<style type="text/css">
.ui-widget-header{
	height:30px;
	line-height:30px;
}

.chatting-continer {
	width: 80%;
	padding: 25px 25px 25px;
    margin: 30px auto;
    background: #fefeff;
    box-shadow: 0 0 15px 0 rgb(2 59 109 / 10%);
    height: 520px;
    background: #f5f5f5;
   
}
.chatting-box {
	width: 100%;
	margin: 0 auto;
}

#chatMsgContainer {
   clear:both;
   border: 1px solid #ccc;
   height: 400px;
   overflow-y: scroll;
   padding: 3px;
   width: 100%;
   background: #bbdefb;
   border-radius: 10px;
}
#chatMsgContainer p{
   padding-bottom: 0px;
   margin-bottom: 0px;
}

#chatConnectionList{
	clear:both;
	width: 100%;
	height: 385px;
	text-align:left;
	padding:5px 5px 5px 5px;
	overflow-y:scroll;
    border: 1px solid #ccc;
    background: white;
    
}
#chatConnectionList span {
	display: block;
}
#chatConnectionList span:hover {
	font-weight: 600;
}
</style>


<div class="container body-container">
	<div style="height: 100px;"></div>
    <div class="body-chat">
		<div style="margin: auto; padding-bottom:30px; font-size: 27px; font-weight: 700; width: 80%; border-bottom: 1.5px solid black;">올리브네 반상회</div>
    </div>
    
    <div class="body-main wx-700 pt-15 content-center">
    	<div class="chatting-continer">
    		<div class="chatting-box">
		        <div style="float: left; width: 71%;">
		            <div style="clear: both; padding-bottom: 5px;">
		                <span style="font-weight: 600;">＞</span>
		                <span style="font-weight: 600; color: #424951;">단체 채팅</span>
		                
		            </div>
		            <div id="chatMsgContainer"></div>
		            <div style="clear: both; padding-top: 5px;">
		                <input type="text" id="chatMsg" class="boxTF"  style="width: 99%; height: 40px; margin-top: 8px; padding-left: 10px;"
		                   placeholder="메세지를 입력하세요.">
		            </div>
		        </div>
		        
		        <div style="float: left; width: 20px;">&nbsp;</div>
		        
		        <div style="float: left; width: 25%;">
		            <div style="clear: both; padding-bottom: 5px;">
		                <span style="font-weight: 600;">＞</span>
		                <span style="font-weight: 600; color: #424951;">접속 회원</span>
		            </div>
		            <div id="chatConnectionList"></div>
		        </div>
	    		<div class="clear"></div>
		    </div>
	    </div>
   	</div>
    
</div>

<script type="text/javascript">
$(function(){
	var socket=null;

	var host="<%=wsURL%>";
	
	if ('WebSocket' in window) {
		socket = new WebSocket(host);
    } else if ('MozWebSocket' in window) {
    	socket = new MozWebSocket(host);
    } else {
    	writeToScreen('브라우저의 버전이 낮아 채팅이 불가능 합니다.',"left");
        return false;
    }

	socket.onopen = function(evt) { onOpen(evt) };
	socket.onclose = function(evt) { onClose(evt) };
	socket.onmessage = function(evt) { onMessage(evt) };
	socket.onerror = function(evt) { onError(evt) };
	
	function onOpen(evt) {
	    var uid = "${sessionScope.member.userId}";
	    var nickName = "${sessionScope.member.userName}";
	    if(! uid) {
	    	location.href="${pageContext.request.contextPath}/member/login";
	    	return;
	    }
	    
		writeToScreen("채팅방에 입장했습니다.","center");
	    
	    var obj = {};
	    var jsonStr;
	    obj.cmd = "connect";
	    obj.uid = uid;
	    obj.nickName = nickName;
	    jsonStr = JSON.stringify(obj);
	    socket.send(jsonStr);
	    
	    $("#chatMsg").on("keydown",function(event) {
	        if (event.keyCode == 13) {
	            sendMessage();
	        }
	    });
	}

	function onClose(evt) {
       	$("#chatMsg").on("keydown",null);
       	writeToScreen('Info: WebSocket closed !',"left");
	}

	function onMessage(evt) {
    	var data=JSON.parse(evt.data); 
    	
    	var cmd=data.cmd;
    	
    	if(cmd=="connectList") { 
    		var uid=data.uid;
    		var nickName=data.nickName;
    		
    		var out="<span id='guest-"+uid+"' data-uid='"+uid+"'>"+nickName+"("+uid+")</span>";
    		$("#chatConnectionList").append(out);
    		
    	} else if(cmd=="connect") {
    		var uid=data.uid;
    		var nickName=data.nickName;
    		
    		var out=nickName+"("+uid+") 님이 입장했습니다.";
    		writeToScreen(out,"center");
    		
    		out="<span id='guest-"+uid+"' data-uid='"+uid+"'> "+nickName+"("+uid+")<span>";
    		$("#chatConnectionList").append(out);
    		
    	} else if(cmd=="disconnect") { 
    		var uid=data.uid;
    		var nickName=data.nickName;
    		
    		var out=nickName+"("+uid+") 님이 퇴장했습니다.";
    		writeToScreen(out,"center");
    		
    		$("#guest-"+uid).remove();

    	} else if(cmd=="message") { 
    		var uid=data.uid;
    		var nickName=data.nickName;
    		var msg=data.chatMsg;
    		
    		writeToScreen(nickName+" : " + msg, "left");
    		
    	}
	}

	function onError(evt) {
		writeToScreen('Info: WebSocket error !',"left");
	}
	
	function sendMessage() {
	    var msg = $("#chatMsg").val().trim();
	    if(! msg ) {
	    	$("#chatMsg").focus();
	    	return;
	    }
	    
        var obj = {};
        var jsonStr;
        obj.cmd="message";
        obj.chatMsg=msg;
        jsonStr = JSON.stringify(obj);
        socket.send(jsonStr);

        $("#chatMsg").val("");
        writeToScreen(msg, "right");
	}
});

function writeToScreen(message, align) {
    var $chatContainer = $("#chatMsgContainer");
    if(align==='center'){
   	 $chatContainer.append("<div style='text-align:"+align+"'><span></span></div>"); }
    else if(align==='left'){
       	$chatContainer.append("<div style='text-align:"+align+"'><span style='background: #eee; padding:10px; margin: 7px; border-radius:10px;'></span></div>");}
    else if(align==='right'){
       	$chatContainer.append("<div style='text-align:"+align+"'><span style='background: #dce775; padding:10px; margin: 7px; border-radius:10px;'></span></div>");}
      
  	$chatContainer.append("<div style='height:20px;'></div>");
    $chatContainer.find("span:last").css("wordWrap","break-word"); 
    $chatContainer.find("span:last").html(message);

    while ($chatContainer.find("span").length > 50) {
    	$chatContainer.find("span:first").remove();
	}

    $chatContainer.scrollTop($chatContainer.prop("scrollHeight"));
}
</script>