package com.olive.olive.chat;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.PostConstruct;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class MySocketHandler extends TextWebSocketHandler {
	private final Logger logger=LoggerFactory.getLogger(MySocketHandler.class);
	
	private Map<String, User> sessionMap = new Hashtable<>();

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);
		
		String uid = removeUser(session);
		
		logger.info("remove session : " + uid);
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		super.handleMessage(session, message);
		
		JSONObject jsonReceive = null;
		try {
			jsonReceive = new JSONObject(message.getPayload().toString());
		}catch (Exception e) {
			return;
		}
		
		String cmd=jsonReceive.getString("cmd");
		if(cmd==null) return;
		
		if(cmd.equals("connect")) { 
			String uid = jsonReceive.getString("uid");
			String nickName = jsonReceive.getString("nickName");
			
			User user=new User();
			user.setUserId(uid);
			user.setNickName(nickName);
			user.setSession(session);
			
			sessionMap.put(uid, user);
			
			Iterator<String> it = sessionMap.keySet().iterator();
			/*
			 * while (it.hasNext()) { String key = it.next(); if(uid.equals(key)) continue;
			 * 
			 * User vo=sessionMap.get(key);
			 * 
			 * JSONObject ob=new JSONObject(); ob.put("cmd", "connectList"); ob.put("uid",
			 * vo.getUserId()); ob.put("nickName", vo.getNickName());
			 * 
			 * }
			 */
			
			JSONObject ob=new JSONObject();
			ob.put("cmd", "connect");
			ob.put("uid", uid);
			ob.put("nickName", nickName);
			
			sendAllMessage(ob.toString(),  uid);
			
		} else if(cmd.equals("message")) { 
			User vo=getUser(session);
			String msg = jsonReceive.getString("chatMsg");
			
			JSONObject ob=new JSONObject();
			ob.put("cmd", "message");
			ob.put("chatMsg", msg);
			ob.put("uid", vo.getUserId());
			ob.put("nickName", vo.getNickName());
			

			sendAllMessage(ob.toString(),  vo.getUserId());
		} 
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		removeUser(session);
	}

	protected void sendAllMessage(String message, String out) {
		Iterator<String> it = sessionMap.keySet().iterator();
		while (it.hasNext()) {
			String key=it.next();
			if(out!=null && out.equals(key)) 
				continue;
			
			User user=sessionMap.get(key);
			WebSocketSession session=user.getSession();
			
			try {
				if (session.isOpen()) {
					session.sendMessage(new TextMessage(message));
				}
			} catch (IOException e) {
				removeUser(session);
			}			
		}
	}
	
	protected User getUser(WebSocketSession session) {
		Iterator<String> it =  sessionMap.keySet().iterator();
		
		while (it.hasNext()) {
			String key = it.next();
			
			User dto=sessionMap.get(key);
			if(dto.getSession()==session) {
				return dto;
			}
		}
		
		return null;
	}
	
	protected String removeUser(WebSocketSession session) {
		User user=getUser(session);
		
		if(user == null) {
			return null;
		}
		
		JSONObject job=new JSONObject();
		job.put("cmd", "disconnect");
		job.put("uid", user.getUserId());
		job.put("nickName", user.getNickName());			
		sendAllMessage(job.toString(), user.getUserId());
		
		try {
			user.getSession().close();
		} catch (Exception e) {
		}
		sessionMap.remove(user.getUserId());

		return user.getUserId();
	}

	@PostConstruct
	public void init() throws Exception {
		TimerTask task = new TimerTask() {
			@Override
			public void run() {
				Calendar cal=Calendar.getInstance();
				int h=cal.get(Calendar.HOUR_OF_DAY);
				int m=cal.get(Calendar.MINUTE);
				int s=cal.get(Calendar.SECOND);
				
				JSONObject job=new JSONObject();
				job.put("cmd", "time");
				job.put("hour", h);
				job.put("minute", m);
				job.put("second", s);

				sendAllMessage(job.toString(), null);
			}
		};
		
		Timer timer = new Timer();
		
		timer.schedule(task, new Date(), 30000);

	}
	
}
