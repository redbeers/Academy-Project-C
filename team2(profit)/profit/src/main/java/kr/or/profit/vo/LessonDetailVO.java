package kr.or.profit.vo;

import java.util.Date;

public class LessonDetailVO {
	private String lessonDetailSeq;
	private String lessonSeq;
	private String fileSeq;
	private String lessonDetailTitle;
	private String lessonDetailContent;
	private String inUserId;
	private Date inDate;
	private String upUserId;
	private Date upDate;
	
	public String getLessonDetailSeq() {
		return lessonDetailSeq;
	}
	public void setLessonDetailSeq(String lessonDetailSeq) {
		this.lessonDetailSeq = lessonDetailSeq;
	}
	public String getLessonSeq() {
		return lessonSeq;
	}
	public void setLessonSeq(String lessonSeq) {
		this.lessonSeq = lessonSeq;
	}
	public String getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getLessonDetailTitle() {
		return lessonDetailTitle;
	}
	public void setLessonDetailTitle(String lessonDetailTitle) {
		this.lessonDetailTitle = lessonDetailTitle;
	}
	public String getLessonDetailContent() {
		return lessonDetailContent;
	}
	public void setLessonDetailContent(String lessonDetailContent) {
		this.lessonDetailContent = lessonDetailContent;
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
