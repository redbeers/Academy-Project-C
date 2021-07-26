package kr.or.profit.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.MemberVO;

//Mapper Interface => 메서드명과 쿼리ID를 매핑하여 쿼리호출

@Mapper("memberMapper")
public interface MemberMapper {
	//회원가입
	public void insertMember(MemberVO vo);

	//아이디 중복 검사
	public int selectMemberIdCheck(String memberId);

	//닉네임 중복 검사
	public int selectMemberNicknameCheck(String memberNickname);

	//이메일 중복 검사
	public int selectMemberEmailCheck(String memberEmail);

	//로그인 처리
	public MemberVO selectMemberCount(MemberVO vo);
	
	//아이디 찾기
	public String selectByFindId(MemberVO vo);
	
	//비밀번호 찾기
	public int selectByFindPwd(MemberVO vo);
	
	//임시비밀번호 업데이트
	public void updateTempPwd(MemberVO vo);
	
	//카카오 회원가입
	public void kakaoInsertMember(MemberVO vo);
	
	//카카오 회원인지 검사
	public int kakaoSelectById(String memberId);
	
	//카카오 로그인 구분 가져오기
	public MemberVO selectKakaoGubun(String memberId);

}
