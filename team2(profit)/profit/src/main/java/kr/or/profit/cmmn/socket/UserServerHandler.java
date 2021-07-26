package kr.or.profit.cmmn.socket;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;
import javax.json.Json;
import javax.json.JsonArrayBuilder;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.profit.service.DietService;
import kr.or.profit.vo.ChatProfileVO;

public class UserServerHandler extends TextWebSocketHandler {

	@Resource(name = "dietService")
	private DietService dietService;

	private final ObjectMapper objectMapper = new ObjectMapper();

	private List<WebSocketSession> connectedAllUsers = new ArrayList<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("첫번째");
		System.out.println("afterConnectionEstablished:" + session);

		System.out.println(session.getAttributes());
		System.out.println(session.getAttributes().get("memberId")); // 이게 세션의 memberId ex) S00001

		connectedAllUsers.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("두번째");
		System.out.println("handleTextMessage:" + session + " : " + message);

		String msg = message.getPayload();
		ChatMessageVO chatMessage = objectMapper.readValue(msg, ChatMessageVO.class);
		
		//1) firstConnection
		if (chatMessage.getCommand().equals("firstConnection")) {
			System.out.println("first커맨드");
			List<ChatProfileVO> list = dietService.websocketSessionList();
			List<String> flagYList = new ArrayList<>();
			for (int i = 0; i < list.size(); i++) {
				flagYList.add(list.get(i).getChatProfileId());
			}
			System.out.println("db에서 flag Y인 리스트 : " + flagYList);
			HashSet<String> returnSet = new HashSet<String>();
			for (int i = 0; i < connectedAllUsers.size(); i++) {
				if (flagYList.contains(connectedAllUsers.get(i).getAttributes().get("memberId"))) {
					returnSet.add((String) connectedAllUsers.get(i).getAttributes().get("memberId"));
				}
			}
			System.out.println("현재 웹소켓 접속한 트레이너 중 Y인 리스트 : " + returnSet);

			TextMessage trainerList = new TextMessage(buildJsonUserData(returnSet).toString());

			System.out.println(buildJsonUserData(returnSet));

			for (WebSocketSession sess : connectedAllUsers) {
				sess.sendMessage(trainerList);
			}
		}
		//2)chatConnection
		else if(chatMessage.getCommand().equals("chatConnection")) {
			String chatroomId = genRandom();
			Set<WebSocketSession> chatroomMembers = new HashSet<WebSocketSession>();
			chatroomMembers.add(session);
			
			String connectingUser = chatMessage.getConnectingUser();
			
			
			if(connectingUser != null) {
				for (WebSocketSession sess : connectedAllUsers) {
					if(connectingUser.equals(sess.getAttributes().get("memberId"))) {
						chatroomMembers.add(sess);
						System.out.println("같은애 찍은거 : " + connectingUser);
					}
				}
				
				// chatroomMembers에게 room입장하라는 신호 보내기
				for(WebSocketSession sess : chatroomMembers) {
					System.out.println("chatroomMembers에게 room입장하라는 신호 보내기");
					
					TextMessage txt = new TextMessage(Json.createObjectBuilder().add("enterChatId", chatroomId).add("username", (String) sess.getAttributes().get("memberId")).build().toString());
					
					sess.sendMessage(txt);
				}
				
				
			}
			
		}

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("세번째");
		System.out.println("afterConnectionClosed:" + session + ":" + status);
		connectedAllUsers.remove(session);
	}

	public List<ChatProfileVO> websocketSessionList() throws Exception {
		List<ChatProfileVO> list = dietService.websocketSessionList();
		return list;
	}

	/**
	 * 유저 정보가 담긴 Set<String>을 json으로 변환해주는 함수
	 * 
	 * @param set
	 * @return jsondata
	 */
	private String buildJsonUserData(Set<String> set) {
		JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
		for (String user : set) {
			jsonArrayBuilder.add(user);
		}
		return Json.createObjectBuilder().add("allTrainers", jsonArrayBuilder).build().toString();
	}
	
	
	/**
	 * chatroomId를 위한 랜덤값을 생성하는 함수
	 * 
	 * @return chatroomId
	 */
	private String genRandom() {
		String chatroomId = "";
		for (int i = 0; i < 8; i++) {
			chatroomId += (char) ((new Random().nextDouble() * 26) + 97);
		}
		return chatroomId;
	}
	

}
