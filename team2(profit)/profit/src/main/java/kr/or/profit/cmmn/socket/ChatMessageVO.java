package kr.or.profit.cmmn.socket;

public class ChatMessageVO {
	private String connectionType;
	private String memberId;
	private String memberGubun;
	private String trainerChatFlag;
	private String command;
	private String connectingUser;
	
	public String getConnectingUser() {
		return connectingUser;
	}
	public void setConnectingUser(String connectingUser) {
		this.connectingUser = connectingUser;
	}
	public String getConnectionType() {
		return connectionType;
	}
	public void setConnectionType(String connectionType) {
		this.connectionType = connectionType;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberGubun() {
		return memberGubun;
	}
	public void setMemberGubun(String memberGubun) {
		this.memberGubun = memberGubun;
	}
	public String getTrainerChatFlag() {
		return trainerChatFlag;
	}
	public void setTrainerChatFlag(String trainerChatFlag) {
		this.trainerChatFlag = trainerChatFlag;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	
	
	
}
