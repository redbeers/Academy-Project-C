package kr.or.profit.vo;

import java.util.Date;


public class ReplyVO {
	private String replySeq;
	private String communitySeq;
	private String lessonSeq;
	private String chatProfileSeq;
	private String replyContent;
	private String replyDelFlag;
	private String replyParentSeq;
	private String replyDepth;
	private String inUserId;
	private Date inDate;
	private String upUserId;
	private Date upDate;
	private String replySecretFlag;
	
	public String getReplySecretFlag() {
		return replySecretFlag;
	}
	public void setReplySecretFlag(String replySecretFlag) {
		this.replySecretFlag = replySecretFlag;
	}
	public String getReplySeq() {
		return replySeq;
	}
	public void setReplySeq(String replySeq) {
		this.replySeq = replySeq;
	}
	public String getCommunitySeq() {
		return communitySeq;
	}
	public void setCommunitySeq(String communitySeq) {
		this.communitySeq = communitySeq;
	}
	public String getLessonSeq() {
		return lessonSeq;
	}
	public void setLessonSeq(String lessonSeq) {
		this.lessonSeq = lessonSeq;
	}
	public String getChatProfileSeq() {
		return chatProfileSeq;
	}
	public void setChatProfileSeq(String chatProfileSeq) {
		this.chatProfileSeq = chatProfileSeq;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getReplyDelFlag() {
		return replyDelFlag;
	}
	public void setReplyDelFlag(String replyDelFlag) {
		this.replyDelFlag = replyDelFlag;
	}
	public String getReplyParentSeq() {
		return replyParentSeq;
	}
	public void setReplyParentSeq(String replyParentSeq) {
		this.replyParentSeq = replyParentSeq;
	}
	public String getReplyDepth() {
		return replyDepth;
	}
	public void setReplyDepth(String replyDepth) {
		this.replyDepth = replyDepth;
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
