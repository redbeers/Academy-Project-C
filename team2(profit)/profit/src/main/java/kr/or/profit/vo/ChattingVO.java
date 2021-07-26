package kr.or.profit.vo;

import java.util.Date;

public class ChattingVO {
	private String chattingSeq;
	private String chatProfileSeq;
	private String chattingMemberId;
	private String chattingAccountFlag;
	private String InUserId;
	private Date inDate;
	private String upUserId;
	private Date upDate;
	private String yyyymm;
	
	
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getChattingSeq() {
		return chattingSeq;
	}
	public void setChattingSeq(String chattingSeq) {
		this.chattingSeq = chattingSeq;
	}
	public String getChatProfileSeq() {
		return chatProfileSeq;
	}
	public void setChatProfileSeq(String chatProfileSeq) {
		this.chatProfileSeq = chatProfileSeq;
	}
	public String getChattingMemberId() {
		return chattingMemberId;
	}
	public void setChattingMemberId(String chattingMemberId) {
		this.chattingMemberId = chattingMemberId;
	}
	public String getChattingAccountFlag() {
		return chattingAccountFlag;
	}
	public void setChattingAccountFlag(String chattingAccountFlag) {
		this.chattingAccountFlag = chattingAccountFlag;
	}
	public String getInUserId() {
		return InUserId;
	}
	public void setInUserId(String inUserId) {
		InUserId = inUserId;
	}
	public Date getInDate() {
		return inDate;
	}
	public void setInDate(Date inDate) {
		this.inDate = inDate;
	}
	public String getUpUserId() {
		return upUserId;
	}
	public void setUpUserId(String upUserId) {
		this.upUserId = upUserId;
	}
	public Date getUpDate() {
		return upDate;
	}
	public void setUpDate(Date upDate) {
		this.upDate = upDate;
	}
	
	
}
