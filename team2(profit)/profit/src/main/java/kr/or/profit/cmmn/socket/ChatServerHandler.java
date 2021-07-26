package kr.or.profit.cmmn.socket;

import java.io.IOException;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;


import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import kr.or.profit.cmmn.socket.config.ChatServerAppConfig;
import kr.or.profit.cmmn.socket.model.ChatMessage;
import kr.or.profit.cmmn.socket.model.Message;
import kr.or.profit.cmmn.socket.model.UsersMessage;
import kr.or.profit.cmmn.socket.model.decoder.MessageDecoder;
import kr.or.profit.cmmn.socket.model.encoder.MessageEncoder;

//Spring bean과 연동하기 위해서는 ServerAppConfig를 configurator로 등록해줘야만 한다!!!!!!
@ServerEndpoint(value = "/chat/{room}", encoders = { MessageEncoder.class }, decoders = { MessageDecoder.class }, configurator=ChatServerAppConfig.class)
public class ChatServerHandler {
	private Set<Session> chatroomUsers = Collections.synchronizedSet(new HashSet<Session>());

	/**
	 * Handshaking 함수
	 * 
	 * @param userSession 사용자 session
	 */
	@OnOpen
	public void handleOpen(Session userSession, @PathParam("room") final String room) throws IOException, EncodeException {
		System.out.println("chat 오픈");
		userSession.getUserProperties().put("room", room);
		chatroomUsers.add(userSession);
	}

	/**
	 * 메시지 전달 함수
	 * 
	 * @param incomingMessage 들어오는 메시지
	 * @param userSession     사용자 session
	 * @param room            room Id
	 * @throws IOException
	 * @throws EncodeException
	 */
	@OnMessage
	public void handleMessage(Message incomingMessage, Session userSession, @PathParam("room") final String room) throws IOException, EncodeException {
		ChatMessage outgoingChatMessage = new ChatMessage();
		ChatMessage incomingChatMessage = (ChatMessage) incomingMessage;
		System.out.println("메시지 찍은거"+incomingChatMessage.getMessage());//나는 5197
		System.out.println("메시지 찍은거"+incomingChatMessage.getName());//null
		System.out.println("메시지 찍은거"+incomingChatMessage.getRoom());//rsbuskrl

		String username = (String) userSession.getUserProperties().get("username");
		System.out.println("유저네임!!!!"+username);//쳇_5197
		
		System.out.println(chatroomUsers.size());
		
		//첫번째 턴일때!!!
		if (username == null) {
			System.out.println("여기 들어옴???");
			username = incomingChatMessage.getMessage();
			if (username != null) {
				System.out.println("두번째 이프문");
				System.out.println("username : "+username);
				//여기서 put을 해주네!!!!!!!!유저네임을 put!!!!
				userSession.getUserProperties().put("username", username);
			}

			synchronized (chatroomUsers) {
				for (Session session : chatroomUsers) {
					//메세지 보내는 부분 1
					session.getBasicRemote().sendObject(new UsersMessage(getUsers()));
					System.out.println("보내는부분");
				}
			}
		} 
		
		//유저네임이 null이 아니면 즉 첫번째 턴을 지나면!!!!!!
		else { 
			System.out.println("else문!!!");
			outgoingChatMessage.setName(username);
			outgoingChatMessage.setMessage(incomingChatMessage.getMessage());

			for (Session session : chatroomUsers) {
				System.out.println("여기는 뭐야");
				//메세지 보내는 부분 2
				session.getBasicRemote().sendObject(outgoingChatMessage);
			}
		}
	}

	// 누군가가 접속 끊을때
	@OnClose
	public void handleClose(Session userSession, @PathParam("room") final String room) throws IOException, EncodeException {
		chatroomUsers.remove(userSession);

		for (Session session : chatroomUsers) {
			//메세지 보내는 부분3인데 접속 끊을때 나오는 부분
			session.getBasicRemote().sendObject(new UsersMessage(getUsers()));
		}
	}

	/**
	 * 사용자가 접속 끊기 전 호출되는 함수
	 * 
	 * @param session
	 * @param throwable
	 * @param room
	 */
	@OnError
	public void handleError(Session session, Throwable throwable, @PathParam("room") final String room) {
		// Error handling
		System.out.println("ChatServerEndPoint (room: " + room + ") occured Exception!");
		System.out.println("Exception : " + throwable.getMessage());
	}

	/**
	 * 사용자 정보를 가져오는 함수
	 * 
	 * @return
	 */
	private Set<String> getUsers() {
		HashSet<String> returnSet = new HashSet<String>();

		for (Session session : chatroomUsers) {
			if (session.getUserProperties().get("username") != null) {
				returnSet.add(session.getUserProperties().get("username").toString());
			}
		}
		return returnSet;
	}

}
