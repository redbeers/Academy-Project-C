package kr.or.profit.service;

import kr.or.profit.vo.MemberVO;

public interface MemberService {
	//회원가입-등록처리
	public void insertMember(MemberVO vo) throws Exception;
	
	//카카오 회원가입
	public void kakaoInsertMember(MemberVO vo) throws Exception;

	//아이디 중복검사
	public int selectMemberIdCheck(String memberId) throws Exception;

	//닉네임 중복검사
	public int selectMemberNicknameCheck(String memberNickname) throws Exception;

	//이메일 중복검사
	public int selectMemberEmailCheck(String memberEmail) throws Exception;

	//로그인 처리
	public MemberVO selectMemberCount(MemberVO vo) throws Exception;

	//이미 카카오 회원가입 되어있는지 검사
	public int kakaoSelectById(String memberId) throws Exception;
	
	//아이디 찾기
	public String selectByFindId(MemberVO vo) throws Exception;
	
	//비밀번호 찾기
	public int selectByFindPwd(MemberVO vo) throws Exception;
	
	//임시 비밀번호로 update
	public void updateTempPwd(MemberVO vo) throws Exception;
	
	//카카오 로그인 구분 가져오기
	public MemberVO selectKakaoGubun(String memberId) throws Exception;
	

}
