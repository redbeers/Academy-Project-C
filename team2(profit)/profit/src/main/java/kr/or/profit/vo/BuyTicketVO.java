package kr.or.profit.vo;

import java.util.Date;

public class BuyTicketVO {
	private String buyTicketSeq;
	private String ticketCategorySeq;
	private String ticketRemain;
	private String ticketRefundFlag;
	private String inUserId;
	private Date inDate;
	private String upUserId;
	private Date upDate;
	private String memberId;
	private String ticketAvailFlag;
	
	
	public String getTicketAvailFlag() {
		return ticketAvailFlag;
	}
	public void setTicketAvailFlag(String ticketAvailFlag) {
		this.ticketAvailFlag = ticketAvailFlag;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getBuyTicketSeq() {
		return buyTicketSeq;
	}
	public void setBuyTicketSeq(String buyTicketSeq) {
		this.buyTicketSeq = buyTicketSeq;
	}
	public String getTicketCategorySeq() {
		return ticketCategorySeq;
	}
	public void setTicketCategorySeq(String ticketCategorySeq) {
		this.ticketCategorySeq = ticketCategorySeq;
	}
	public String getTicketRemain() {
		return ticketRemain;
	}
	public void setTicketRemain(String ticketRemain) {
		this.ticketRemain = ticketRemain;
	}
	public String getTicketRefundFlag() {
		return ticketRefundFlag;
	}
	public void setTicketRefundFlag(String ticketRefundFlag) {
		this.ticketRefundFlag = ticketRefundFlag;
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
