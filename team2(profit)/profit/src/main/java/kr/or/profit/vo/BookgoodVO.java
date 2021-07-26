package kr.or.profit.vo;

import java.util.Date;

public class BookgoodVO {
	
	private String bookgoodSeq;
	private Date inDate;
	
	//myinfo 북마크
	private String communitySeq;
	private String commonTitle;
	private String cDate;
	private String cFilepath;
	private String lessonSeq;
	private String lessonTitle;
	private String lFilepath;
	private String lDate;
	private String commonSeq;
	
	public String getCommonSeq() {
		return commonSeq;
	}
	public void setCommonSeq(String commonSeq) {
		this.commonSeq = commonSeq;
	}
	public String getCommonTitle() {
		return commonTitle;
	}
	public void setCommonTitle(String commonTitle) {
		this.commonTitle = commonTitle;
	}
	public String getcDate() {
		return cDate;
	}
	public void setcDate(String cDate) {
		this.cDate = cDate;
	}
	public String getcFilepath() {
		return cFilepath;
	}
	public void setcFilepath(String cFilepath) {
		this.cFilepath = cFilepath;
	}
	public String getLessonTitle() {
		return lessonTitle;
	}
	public void setLessonTitle(String lessonTitle) {
		this.lessonTitle = lessonTitle;
	}
	public String getlFilepath() {
		return lFilepath;
	}
	public void setlFilepath(String lFilepath) {
		this.lFilepath = lFilepath;
	}
	public String getlDate() {
		return lDate;
	}
	public void setlDate(String lDate) {
		this.lDate = lDate;
	}
	
	
	private String memberId;
	private String bookgoodGubun;
	private String bookgoodFlag;
	private String inUserId;
	private String upUserId;
	private Date upDate;
	public String getBookgoodSeq() {
		return bookgoodSeq;
	}
	public void setBookgoodSeq(String bookgoodSeq) {
		this.bookgoodSeq = bookgoodSeq;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
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
	public String getBookgoodGubun() {
		return bookgoodGubun;
	}
	public void setBookgoodGubun(String bookgoodGubun) {
		this.bookgoodGubun = bookgoodGubun;
	}
	public String getBookgoodFlag() {
		return bookgoodFlag;
	}
	public void setBookgoodFlag(String bookgoodFlag) {
		this.bookgoodFlag = bookgoodFlag;
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
