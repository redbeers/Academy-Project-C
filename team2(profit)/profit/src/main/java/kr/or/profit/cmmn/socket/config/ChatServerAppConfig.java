package kr.or.profit.cmmn.socket.config;

import java.util.HashMap;
import java.util.Map;


import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

import kr.or.profit.cmmn.socket.ChatServerHandler;

/**
* @Class Name : ChatServerAppConfig.java
* @Description : 사용자리스트에서 다른사용자 선택 시, 사용자와 대화가능한 방(새로운 EndPoint 객체)을 만드는 Configurator
* @Modification Information
*
*    수정일       수정자         수정내용
*    -------        -------     -------------------
*    2014. 11. 27.    이영지
*
*/
public class ChatServerAppConfig extends Configurator{

	//대화창 서버객체(ChatServerEndPoint) 저장하는 Map
	private final static Map<String, ChatServerHandler> endpointMap = new HashMap<String, ChatServerHandler>(); //메모리로 등록을 해놓는다 사용자들이 접속을 하면 여기에 다 적재가 된다
	private String currentUri;

	@SuppressWarnings("unchecked")
	@Override
     public <T> T getEndpointInstance(Class<T> endpointClass) throws InstantiationException {

		ChatServerHandler endpoint = endpointMap.get(currentUri);

		 if(endpoint == null) {
			 endpoint = new ChatServerHandler();
			 endpointMap.put(currentUri, endpoint);
		 }

		 return (T)endpoint;
     }
	
	//핸들러를 통해서 누구랑 어떻게 통신할지를 결정

	@Override
	public void modifyHandshake(ServerEndpointConfig sec,
			HandshakeRequest request, HandshakeResponse response) {
		currentUri = request.getRequestURI().toString();
		super.modifyHandshake(sec, request, response);
	}
}
