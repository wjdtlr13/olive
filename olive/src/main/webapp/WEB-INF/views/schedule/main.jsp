<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/icofont/icofont.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fullcalendar5/lib/main.min.css">
<style type="text/css">
.ui-dialog {
	z-index: 9999;
}

.ui-dialog * {
	box-sizing: content-box;
}

.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #ccc;
	border-radius: 0px;
}

.body-title {
	margin-top: 80px;
	margin-bottom: 30px;
}
.body-title h2{
	font-weight: 700;
}

.table1 {
	width: 100%; border-spacing: 0; border-collapse: collapse;
}
.table1 tr th, .table1 tr td {
	padding: 7px 0;
}
.table1 p{
	margin-bottom: 0;
}

.table-article {
	margin-top: 10px;
}
.table-article tr > td {
	padding-left: 5px; padding-right: 5px;
}
.table-article tr > td:nth-child(1) {
	width: 100px; text-align: center; background: #eee;
}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar5/lib/main.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/fullcalendar5/lib/locales-all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status===403) {
				login();
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

var calendar=null;
var group="all";
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');

	calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		},
		initialView: 'dayGridMonth', // ?????? ????????? ????????? ???
		locale: 'ko',
		editable: true,
		navLinks: true,
		dayMaxEvents: true,
		events: function(info, successCallback, failureCallback) {
			var url="${pageContext.request.contextPath}/schedule/month";
			var startDay=info.startStr.substr(0, 10);
			var endDay=info.endStr.substr(0, 10);
            var query="start="+startDay+"&end="+endDay+"&group="+group;
            
        	var fn = function(data){
        		// var events = eval(data.list);
        		successCallback(data.list);
        	};
        	ajaxFun(url, "get", query, "json", fn);

		},
		selectable: true,
		selectMirror: true,
		select: function(info) {
			// ????????? ?????? ??????????????? ??????????????? ?????? ??????????????? ??????
			// insertSchedule(info.start, info.end, info.allDay); // start : Date ???
			insertSchedule(info.startStr, info.endStr, info.allDay); //startStr : 2021-06-06T07:00:00+09:00
			
	        calendar.unselect();
		},
		eventClick: function(info) {
			// ?????? ????????? ????????? ?????? ?????? ??????
			viewSchedule(info.event);
		},
		eventDrop: function(info) {
			// ????????? ????????? ??? ??????
			updateDrag(info.event);
		},
		eventResize: function(info) {
			// ????????? ????????? ?????? ??? ??????
			updateDrag(info.event);
		},
		loading: function(bool) {
			document.getElementById('scheduleLoading').style.display = bool ? 'block' : 'none';
		}
	});

	calendar.render();
});

$(function(){
	$("#tab-"+group).addClass("active");

	$("ul.tabs li").click(function() {
		group = $(this).attr("data-group");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+group).addClass("active");
		
		calendar.refetchEvents();
	});
});

// ?????? ?????? ????????????
function insertSchedule(start, end, allDay) {
	// ??? ?????????
	initForm(start, end, allDay, "insert");
	
	$('#schedule-dialog').dialog({
		  modal: true,
		  height: 665,
		  width: 615,
		  title: '?????? ??????',
		  close: function(event, ui) {
		  }
	});
}

// ?????? ??? ?????? ??? ?????????
function initForm(start, end, allDay, mode) {
	// ??? reset
	$("form[name=scheduleForm]").each(function(){
		this.reset();
	});
	$("form[name=scheduleForm] input[name=mode]").val(mode);
	
	if(mode=="insert") {
		$(".btnScheduleSendOk").text("????????????");
		$(".btnScheduleSendCancel").text("????????????");
	} else {
		$(".btnScheduleSendOk").text("????????????");
		$(".btnScheduleSendCancel").text("????????????");
	}

	$("#form-repeat_cycle").hide();
	$("#form-eday").closest("tr").show();
	$("#form-allDay").removeAttr("disabled");
	
	var startDate, endDate, startTime, endTime;
	if(allDay) {
		startDate = start;
		endDate = "";
		if(end) endDate = daysLater(end, 0); // ?????? ????????? ?????? ????????? ????????? +1 ??? ?????? ????????? -1 ??? 
		$("#form-allDay").prop("checked", true);
		
		$("#form-stime").val("").hide();
		$("#form-etime").val("").hide();
	} else {
		startDate = start.substr(0, 10);
		endDate = end.substr(0, 10);
		startTime = start.substr(11, 5);
		endTime = end.substr(11, 5);
		$("#form-allDay").prop("checked", false);
		
		$("#form-stime").val(startTime).show();
		$("#form-etime").val(endTime).show();
	}
	
	$("form[name=scheduleForm] input[name=sday]").val(startDate);
	$("form[name=scheduleForm] input[name=eday]").val(endDate);
	
	$("#form-sday").datepicker({showMonthAfterYear:true});
	$("#form-eday").datepicker({showMonthAfterYear:true});
}

$(function(){
	$("#form-allDay").click(function(){
		if(this.checked==true) {
			$("#form-stime").val("").hide();
			$("#form-etime").val("").hide();
		} else if(this.checked==false && $("#form-repeat").val()==0){
			$("#form-stime").val("00:00").show();
			$("#form-etime").val("00:00").show();
		}
	});

	$("#form-sday").change(function(){
		$("#form-eday").val($("#form-sday").val());
	});
	
	$("#form-repeat").change(function(){
		if($(this).val()=="0") {
			$("#form-repeat_cycle").val("0").hide();
			
			$("#form-allDay").prop("checked", true);
			$("#form-allDay").removeAttr("disabled");
			
			$("#form-eday").val($("#form-sday").val());
			$("#form-eday").closest("tr").show();
		} else {
			$("#form-repeat_cycle").show();
			
			$("#form-allDay").prop("checked", true);
			$("#form-allDay").attr("disabled","disabled");

			$("#form-stime").val("").hide();
			$("#form-eday").val("");
			$("#form-etime").val("");
			$("#form-eday").closest("tr").hide();
		}
	});
});

// ?????? ???????????? ??? ?????? ??????
$(function(){
	$(".btnScheduleSendOk").click(function(){
		if($("#form-repeat_cycle").val()=="") {
			$("#form-repeat_cycle").val("0");
		}
		
		if(! check()) {
			return false;
		}
		
		// ??????????????? ?????? ??????????????? ????????????+1??? ???????????? ???????????? ???
		if($("#form-eday").val() && $("#form-allDay").is(":checked")) {
			$("#form-eday").val(daysLater($("#form-eday").val(), 2));
		}
		
		var mode = $("form[name=scheduleForm] input[name=mode]").val();

		var query=$("form[name=scheduleForm]").serialize();
		var url="${pageContext.request.contextPath}/schedule/"+mode;

		var fn = function(data) {
			var state=data.state;
			
			if(state=="true") {
				group="all";
				
				// ?????? ????????? ???????????? ?????? ????????? ????????? ?????? ?????????
				calendar.refetchEvents();
			}
			
			$('#schedule-dialog').dialog("close");
		};
		ajaxFun(url, "post", query, "json", fn);
	});
});

// ?????? ???????????? ??????
$(function(){
	$(".btnScheduleSendCancel").click(function(){
		$('#schedule-dialog').dialog("close");
	});
});

// ???????????? ????????? ??????
function check() {
	if(! $("#form-subject").val()) {
		$("#form-subject").focus();
		return false;
	}

	if(! $("#form-sday").val()) {
		$("#form-sday").focus();
		return false;
	}

	if($("#form-eday").val()) {
		var s1=$("#form-sday").val().replace("-", "");
		var s2=$("#form-eday").val().replace("-", "");
		if(s1>s2) {
			$("#form-sday").focus();
			return false;
		}
	}
	
	if($("#form-stime").val()!="" && !isValidTime($("#form-stime").val())) {
		$("#form-stime").focus();
		return false;
	}

	if($("#form-etime").val()!="" && !isValidTime($("#form-etime").val())) {
		$("#form-etime").focus();
		return false;
	}
	
	if($("#form-etime").val()) {
		var s1=$("#form-stime").val().replace(":", "");
		var s2=$("#form-etime").val().replace(":", "");
		if(s1>s2) {
			$("#form-stime").focus();
			return false;
		}
	}	
	
	if($("#form-repeat").val()!="0" && ! /^(\d){1,2}$/g.test($("#form-repeat_cycle").val())) {
		$("#form-repeat_cycle").focus();
		return false;
	}
	
	if($("#form-repeat").val()!="0" && $("#form-repeat_cycle").val()<1) {
		$("#form-repeat_cycle").focus();
		return false;
	}
	
	return true;
}

// ?????? ?????? ????????? ??????
function isValidTime(data) {
	if(! /(\d){2}[:](\d){2}/g.test(data)) {
		return false;
	}
	
	var t=data.split(":");
	if(t[0] < 0 || t[0] > 23 || t[1] < 0 || t[1] > 59) {
		return false;
	}

	return true;
}

//  ?????? ?????? ??????
function viewSchedule(calEvent) {
	$("form[name=scheduleForm]").each(function(){
		this.reset();
	});

	var num=calEvent.id;
	var title=calEvent.title;
	var color=calEvent.backgroundColor;
	// var start=calEvent.start;
	// var end=calEvent.end;
	var start=calEvent.startStr;
	var end=calEvent.endStr;
	var allDay=calEvent.allDay;	
	var sday=calEvent.extendedProps.sday;
	var eday=calEvent.extendedProps.eday;
	var stime=calEvent.extendedProps.stime;
	var etime=calEvent.extendedProps.etime;
	
	var memo=calEvent.extendedProps.memo;
	var created=calEvent.extendedProps.created;
	var repeat=calEvent.extendedProps.repeat;
	var repeat_cycle=calEvent.extendedProps.repeat_cycle;

	$(".btnScheduleUpdate").attr("data-num", num);
	$(".btnScheduleDelete").attr("data-num", num);
	
	// ????????? ?????????
	initForm(start, end, allDay, "update");
	$("#form-subject").val(title);
	$("#form-color").val(color);
	$("#form-num").val(num);
	$("#form-memo").val(memo);
	if(repeat!=0) {
		$("#form-repeat_cycle").val(repeat_cycle);
		$("#form-repeat").val(repeat);

		$("#form-repeat_cycle").show();
		
		$("#form-allDay").prop("checked", true);
		$("#form-allDay").attr("disabled","disabled");

		$("#form-stime").val("").hide();
		$("#form-eday").val("");
		$("#form-etime").val("");
		$("#form-eday").closest("tr").hide();		
	}
	
	// ????????????
	var s;
	$(".table-article .subject").html(title);
	
	if(color=="green") s = "????????????";
	else if(color=="blue") s = "????????????";
	else if(color=="tomato") s = "????????????";
	else s = "????????????";
	
	if(allDay) s +=", ????????????";
	else s +=", ????????????";
	
	$(".table-article .color").html(s);
	
	s = sday;
	if( stime ) s+=" "+stime;
	
	if( eday && allDay ) s += " ~ " + daysLater(eday, 0);
	else if( eday ) s += " ~ " + eday;
	
	if( etime ) s+=" "+etime;
	
	$(".table-article .period").html(s);

	if(repeat!=0 && repeat_cycle!=0) s="????????????, ???????????? : "+repeat_cycle+"???"
	else s="????????????";
	$(".table-article .repeat").html(s);
	
	$(".table-article .created").html(created);
	
	if(! memo) memo="";
	$(".table-article .memo").html(memo);

	$('#viewSchedule-dialog').dialog({
		  modal: true,
		  height: 445,
		  width: 600,
		  title: '?????? ??????',
		  open: function() {
		  },
		  close: function(event, ui) {
		  }
	});	
}

// ?????? ?????? ???????????? ??????
$(function(){
	$(".btnScheduleClose").click(function(){
		$('#viewSchedule-dialog').dialog("close");
	});
});

// ?????? ???
$(function(){
	$(".btnScheduleUpdate").click(function(){
		$('#viewSchedule-dialog').dialog("close");
		
		$('#schedule-dialog').dialog({
			  modal: true,
			  height: 665,
			  width: 615,
			  title: '?????? ??????',
			  close: function(event, ui) {
			  }
		});
	});
});

// ?????? ??????
$(function(){
	$(".btnScheduleDelete").click(function(){
		var num = $(this).attr("data-num");
		
		if(confirm("????????? ?????? ?????????????????? ?")) {
			var url="${pageContext.request.contextPath}/schedule/delete";
			var query="num="+num;
			
			var fn = function(data){
				var event = calendar.getEventById(num);
		        event.remove();
			};
			
			ajaxFun(url, "post", query, "json", fn);
		}
		
		 $("#viewSchedule-dialog").dialog("close");		
	});
});

function updateDrag(calEvent) {
	var num=calEvent.id;
	var title=calEvent.title;
	var color=calEvent.backgroundColor;
	var start=calEvent.startStr;
	var end=calEvent.endStr;
	var allDay=calEvent.allDay;
	var memo=calEvent.extendedProps.memo;
	var repeat=calEvent.extendedProps.repeat;
	var repeat_cycle=calEvent.extendedProps.repeat_cycle;
	
	var startDate="", endDate="", startTime="", endTime="", all_day="";
	if(allDay) {
		startDate = start;
		endDate = end;
		all_day = "1";
	} else {
		startDate = start.substr(0, 10);
		endDate = end.substr(0, 10);
		startTime = start.substr(11, 5);
		endTime = end.substr(11, 5);
	}
	
	var query="num="+num+"&subject="+title+"&color="+color+"&all_day="+all_day
			+"&sday="+startDate+"&eday="+endDate+"&stime="+startTime+"&etime="+endTime
			+"&memo="+memo+"&repeat="+repeat+"&repeat_cycle="+repeat_cycle;
	var url="${pageContext.request.contextPath}/schedule/update";

	var fn = function(data) {
	};
	ajaxFun(url, "post", query, "json", fn);
}

</script>

<div class="container">
    <div class="body-title">
		<h2><i class="icofont-calendar"></i> ???????????? </h2>
    </div>
    
    <div class="body-main">
		<div>    
			<ul class="tabs">
				<li id="tab-all" data-group="all">????????????</li>
				<li id="tab-green" data-group="green">????????????</li>
				<li id="tab-blue" data-group="blue">????????????</li>
				<li id="tab-tomato" data-group="tomato">????????????</li>
				<li id="tab-purple" data-group="purple">????????????</li>
			</ul>
		</div>
		<div id="tab-content" style="padding: 25px 10px 15px; clear: both;">
			<div id="calendar"></div>
		</div>
		<div id='scheduleLoading' style="display: none;">loading...</div>
	</div>
</div>

<div id="schedule-dialog" style="display: none;">
	<form name="scheduleForm">
		<table style="width: 100%; margin: 20px auto 0; border-spacing: 0; border-collapse: collapse;">
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">??????</label>
				</td>
				<td style="padding: 0 0 5px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<input type="text" name="subject" id="form-subject" maxlength="100" class="boxTF" style="width: 95%;">
					</p>
					<p class="help-block">* ????????? ?????? ?????????.</p>
				</td>
			</tr>
			
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">????????????</label>
				</td>
				<td style="padding: 0 0 5px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<select name="color" id="form-color" class="selectField">
							<option value="green">????????????</option>
							<option value="blue">????????????</option>
							<option value="tomato">????????????</option>
							<option value="purple">????????????</option>
						</select>
					</p>
				</td>
			</tr>

			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">????????????</label>
				</td>
				<td style="padding: 0 0 5px 15px;">
					<div  class="form-row">
						<div class="col col-sm-1">
							<input type="checkbox" name="all_day" id="form-allDay" value="1" checked="checked">
						</div>
						<div class="col col-sm-2">
							<label for="allDay">????????????</label>
						</div>
					</div>
				</td>
			</tr>

			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">????????????</label>
				</td>
				<td style="padding: 0 0 5px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<input type="text" name="sday" id="form-sday" maxlength="10" class="boxTF" readonly="readonly" style="width: 25%; background: #fff;">
						<input type="text" name="stime" id="form-stime" maxlength="5" class="boxTF" style="width: 15%; display: none;" placeholder="????????????">
					</p>
					<p class="help-block">* ??????????????? ???????????????.</p>
				</td>
			</tr>

			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">????????????</label>
				</td>
				<td style="padding: 0 0 5px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<input type="text" name="eday" id="form-eday" maxlength="10" class="boxTF" readonly="readonly" style="width: 25%; background: #fff;">
						<input type="text" name="etime" id="form-etime" maxlength="5" class="boxTF" style="width: 15%; display: none;" placeholder="????????????">
					</p>
					<p class="help-block">??????????????? ??????????????????, ?????????????????? ?????? ??? ????????????.</p>
				</td>
			</tr>

			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">????????????</label>
				</td>
				<td style="padding: 0 0 5px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<select name="repeat" id="form-repeat" class="selectField">
							<option value="0">????????????</option>
							<option value="1">?????????</option>
						</select>
						<input type="text" name="repeat_cycle" id="form-repeat_cycle" maxlength="2" class="boxTF" style="width: 20%; display: none;" placeholder="????????????">
					</p>
				</td>
			</tr>
			  
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">??????</label>
				</td>
				<td style="padding: 0 0 5px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<textarea name="memo" id="form-memo" class="boxTA" style="width:93%; height: 70px;"></textarea>
					</p>
				</td>
			</tr>
			  
			<tr height="45">
				<td align="center" colspan="2">
					<div class="insert-button">
						<button type="button" class="btn btn-dark btnScheduleSendOk">????????????</button>
						<button type="button" class="btn btnScheduleSendCancel">????????????</button>
					</div>
					<input type="hidden" id="form-num" name="num" value="0">
					<input type="hidden" id="form-mode" name="mode" value="insert">
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="viewSchedule-dialog" style="display: none;">
	<table class="table1 table-article" border="1">
		<tr>
			<td>??????</td>
			<td><p class="subject"></p></td>
		</tr>
		
		<tr>
			<td>????????????</td>
			<td><p class="color"></p></td>
		</tr>

		<tr>
			<td>??????</td>
			<td><p class="period"></p></td>
		</tr>

		<tr>
			<td>????????????</td>
			<td><p class="repeat"></p></td>
		</tr>

		<tr>
			<td>?????????</td>
			<td><p class="created"></p></td>
		</tr>
		
		
		<tr height="70">
			<td valign="top">??????</td>
			<td valign="top"><p class="memo" style="white-space: pre;"></p></td>
		</tr>
	</table>
	
	<table class="table">
		<tr> 
			<td align="right">
				<button type="button" class="btn btnScheduleUpdate">????????????</button>
				<button type="button" class="btn btnScheduleDelete">????????????</button>
				<button type="button" class="btn btnScheduleClose">??????</button>
			</td>
		</tr>
	</table>

</div>