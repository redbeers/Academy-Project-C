package kr.or.profit.vo;

import java.util.Date;

public class BuyLessonVO {
	private String buyLessonSeq;
	private String lessonSeq;
	private String lessonFinishDate;
	private String lessonRefundFlag;
	private String lessonClickFlag;
	private String lessonClickDate;
	private String inUserId;
	private Date inDate;
	private String upUserId;
	private Date upDate;
	private String memberId;
	private String classAccountFlag;
	private String yyyymm;
	
	
	public String getClassAccountFlag() {
		return classAccountFlag;
	}
	public void setClassAccountFlag(String classAccountFlag) {
		this.classAccountFlag = classAccountFlag;
	}
	public String getYyyymm() {
		return yyyymm;
	}
	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getBuyLessonSeq() {
		return buyLessonSeq;
	}
	public void setBuyLessonSeq(String buyLessonSeq) {
		this.buyLessonSeq = buyLessonSeq;
	}
	public String getLessonSeq() {
		return lessonSeq;
	}
	public void setLessonSeq(String lessonSeq) {
		this.lessonSeq = lessonSeq;
	}
	public String getLessonFinishDate() {
		return lessonFinishDate;
	}
	public void setLessonFinishDate(String lessonFinishDate) {
		this.lessonFinishDate = lessonFinishDate;
	}
	public String getLessonRefundFlag() {
		return lessonRefundFlag;
	}
	public void setLessonRefundFlag(String lessonRefundFlag) {
		this.lessonRefundFlag = lessonRefundFlag;
	}
	public String getLessonClickFlag() {
		return lessonClickFlag;
	}
	public void setLessonClickFlag(String lessonClickFlag) {
		this.lessonClickFlag = lessonClickFlag;
	}
	public String getLessonClickDate() {
		return lessonClickDate;
	}
	public void setLessonClickDate(String lessonClickDate) {
		this.lessonClickDate = lessonClickDate;
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
