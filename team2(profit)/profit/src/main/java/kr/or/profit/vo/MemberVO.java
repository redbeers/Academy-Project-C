package kr.or.profit.vo;

public class MemberVO {
	private String memberId;
	private String memberPwd;
	private String memberName;
	private String memberNickname;
	private String memberMobile;
	private String memberGender;
	private String memberHeight;
	private String memberWeight;
	private String memberEmail;
	private String memberGubun;
	private String memberRoute;
	private String inUserId;
	private String inDate;
	private String upUserId;
	private String upDate;
	
	private String blacklistFlag;
	private String blacklistReason;
	private String bDate;
	
	private String addFlag;
	
	
	
	
	public String getAddFlag() {
		return addFlag;
	}
	public void setAddFlag(String addFlag) {
		this.addFlag = addFlag;
	}
	public String getBlacklistReason() {
		return blacklistReason;
	}
	public void setBlacklistReason(String blacklistReason) {
		this.blacklistReason = blacklistReason;
	}
	public String getbDate() {
		return bDate;
	}
	public void setbDate(String bDate) {
		this.bDate = bDate;
	}
	public String getBlacklistFlag() {
		return blacklistFlag;
	}
	public void setBlacklistFlag(String blacklistFlag) {
		this.blacklistFlag = blacklistFlag;
	}
	//필요한 컬럼 추가
	private String filePath;
	
	
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPwd() {
		return memberPwd;
	}
	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberNickname() {
		return memberNickname;
	}
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	public String getMemberMobile() {
		return memberMobile;
	}
	public void setMemberMobile(String memberMobile) {
		this.memberMobile = memberMobile;
	}
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public String getMemberHeight() {
		return memberHeight;
	}
	public void setMemberHeight(String memberHeight) {
		this.memberHeight = memberHeight;
	}
	public String getMemberWeight() {
		return memberWeight;
	}
	public void setMemberWeight(String memberWeight) {
		this.memberWeight = memberWeight;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getMemberGubun() {
		return memberGubun;
	}
	public void setMemberGubun(String memberGubun) {
		this.memberGubun = memberGubun;
	}
	public String getMemberRoute() {
		return memberRoute;
	}
	public void setMemberRoute(String memberRoute) {
		this.memberRoute = memberRoute;
	}
	public String getInUserId() {
		return inUserId;
	}
	public void setInUserId(String inUserId) {
		this.inUserId = inUserId;
	}
	public String getInDate() {
		return inDate;
	}
	public void setInDate(String inDate) {
		this.inDate = inDate;
	}
	public String getUpUserId() {
		return upUserId;
	}
	public void setUpUserId(String upUserId) {
		this.upUserId = upUserId;
	}
	public String getUpDate() {
		return upDate;
	}
	public void setUpDate(String upDate) {
		this.upDate = upDate;
	}
	
}
