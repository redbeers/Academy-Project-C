package kr.or.profit.vo;

import java.util.Date;

public class ProcessVO {
	private String processSeq;
	private String memberId;
	private String fileSeq;
	private String trainerAward;
	private String trainerGym;
	private String trainerCareer;
	private String processStatus;
	private Date processFinishDate;
	private String adminMemo;
	private String resultReason;
	private String inUserId;
	private Date inDate;
	private String upUserId;
	public Date getProcessFinishDate() {
		return processFinishDate;
	}
	public void setProcessFinishDate(Date processFinishDate) {
		this.processFinishDate = processFinishDate;
	}
	public String getResultReason() {
		return resultReason;
	}
	public void setResultReason(String resultReason) {
		this.resultReason = resultReason;
	}
	private Date upDate;
	
	//민선 추가-내정보 탭
	private String memberName;
	private String memberGender;
	private String memberMobile;
	private String memberEmail;
	
	//민선추가-관리자 프로세스 리스트
	private String statusA;
	private String statusB;
	private String statusC;
	private String statusDate;

	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getStatusDate() {
		return statusDate;
	}
	public void setStatusDate(String statusDate) {
		this.statusDate = statusDate;
	}
	public String getStatusA() {
		return statusA;
	}
	public void setStatusA(String statusA) {
		this.statusA = statusA;
	}
	public String getStatusB() {
		return statusB;
	}
	public void setStatusB(String statusB) {
		this.statusB = statusB;
	}
	public String getStatusC() {
		return statusC;
	}
	public void setStatusC(String statusC) {
		this.statusC = statusC;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public String getMemberMobile() {
		return memberMobile;
	}
	public void setMemberMobile(String memberMobile) {
		this.memberMobile = memberMobile;
	}
	public String getProcessSeq() {
		return processSeq;
	}
	public void setProcessSeq(String processSeq) {
		this.processSeq = processSeq;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getTrainerAward() {
		return trainerAward;
	}
	public void setTrainerAward(String trainerAward) {
		this.trainerAward = trainerAward;
	}
	public String getTrainerGym() {
		return trainerGym;
	}
	public void setTrainerGym(String trainerGym) {
		this.trainerGym = trainerGym;
	}
	public String getTrainerCareer() {
		return trainerCareer;
	}
	public void setTrainerCareer(String trainerCareer) {
		this.trainerCareer = trainerCareer;
	}
	public String getProcessStatus() {
		return processStatus;
	}
	public void setProcessStatus(String processStatus) {
		this.processStatus = processStatus;
	}
	public String getAdminMemo() {
		return adminMemo;
	}
	public void setAdminMemo(String adminMemo) {
		this.adminMemo = adminMemo;
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
