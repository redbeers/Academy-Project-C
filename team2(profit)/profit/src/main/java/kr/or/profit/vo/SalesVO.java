package kr.or.profit.vo;

import java.util.Date;

public class SalesVO {
	private String salesSeq;
	private String salesGubun;
	private String slaesMonth;
	private String salesFee;
	private String inUserId;
	private Date inDate;
	private String upUserId;
	private Date upDate;
	private String memberId;
	
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getSalesSeq() {
		return salesSeq;
	}
	public void setSalesSeq(String salesSeq) {
		this.salesSeq = salesSeq;
	}
	public String getSalesGubun() {
		return salesGubun;
	}
	public void setSalesGubun(String salesGubun) {
		this.salesGubun = salesGubun;
	}
	public String getSlaesMonth() {
		return slaesMonth;
	}
	public void setSlaesMonth(String slaesMonth) {
		this.slaesMonth = slaesMonth;
	}
	public String getSalesFee() {
		return salesFee;
	}
	public void setSalesFee(String salesFee) {
		this.salesFee = salesFee;
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
