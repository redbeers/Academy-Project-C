package kr.or.profit.vo;

import java.util.Date;


public class CommunityVO {
	private String communitySeq;
	private String commonSeq;
	private String communityCategorySeq;
	private String fileSeq;
	private String commonTitle;
	private String commonContent;
	private String commonHit;
	private String commonDelFlag;
	private String inUserId;
	private Date inDate;
	private String upUserId;
	private Date upDate;
	
	private String goodFlag;
	private String bookFlag;
	private String memberId;

	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getGoodFlag() {
		return goodFlag;
	}
	public void setGoodFlag(String goodFlag) {
		this.goodFlag = goodFlag;
	}
	public String getBookFlag() {
		return bookFlag;
	}
	public void setBookFlag(String bookFlag) {
		this.bookFlag = bookFlag;
	}
	public String getCommunitySeq() {
		return communitySeq;
	}
	public void setCommunitySeq(String communitySeq) {
		this.communitySeq = communitySeq;
	}
	public String getCommonSeq() {
		return commonSeq;
	}
	public void setCommonSeq(String commonSeq) {
		this.commonSeq = commonSeq;
	}
	public String getCommunityCategorySeq() {
		return communityCategorySeq;
	}
	public void setCommunityCategorySeq(String communityCategorySeq) {
		this.communityCategorySeq = communityCategorySeq;
	}
	public String getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getCommonTitle() {
		return commonTitle;
	}
	public void setCommonTitle(String commonTitle) {
		this.commonTitle = commonTitle;
	}
	public String getCommonContent() {
		return commonContent;
	}
	public void setCommonContent(String commonContent) {
		this.commonContent = commonContent;
	}
	public String getCommonHit() {
		return commonHit;
	}
	public void setCommonHit(String commonHit) {
		this.commonHit = commonHit;
	}
	public String getCommonDelFlag() {
		return commonDelFlag;
	}
	public void setCommonDelFlag(String commonDelFlag) {
		this.commonDelFlag = commonDelFlag;
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
