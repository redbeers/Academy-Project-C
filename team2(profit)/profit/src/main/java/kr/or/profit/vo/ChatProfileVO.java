package kr.or.profit.vo;

import java.util.Date;

public class ChatProfileVO {
	private String chatProfileSeq;
	private String fileSeq;
	private String chatProfileId;
	private String chatProfileIntro;
	private String chatProfileMemo;
	private String chatProfilePrivate;
	private String inUserId;
	private Date inDate;
	private String upUserId;
	private Date upDate;
	
	public String getChatProfileSeq() {
		return chatProfileSeq;
	}
	public void setChatProfileSeq(String chatProfileSeq) {
		this.chatProfileSeq = chatProfileSeq;
	}
	public String getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getChatProfileId() {
		return chatProfileId;
	}
	public void setChatProfileId(String chatProfileId) {
		this.chatProfileId = chatProfileId;
	}
	public String getChatProfileIntro() {
		return chatProfileIntro;
	}
	public void setChatProfileIntro(String chatProfileIntro) {
		this.chatProfileIntro = chatProfileIntro;
	}
	public String getChatProfileMemo() {
		return chatProfileMemo;
	}
	public void setChatProfileMemo(String chatProfileMemo) {
		this.chatProfileMemo = chatProfileMemo;
	}
	public String getChatProfilePrivate() {
		return chatProfilePrivate;
	}
	public void setChatProfilePrivate(String chatProfilePrivate) {
		this.chatProfilePrivate = chatProfilePrivate;
	}
	public String getInUserId() {
		return inUserId;
	}
	public void setInUserId(String inUserId) {
		this.inUserId = inUserId;
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
