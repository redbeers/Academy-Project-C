package kr.or.profit.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.MemberMapper;
import kr.or.profit.service.MemberService;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.MemberVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService{

	@Resource(name="memberMapper")
	private MemberMapper memberMapper;

	@Override
	public void insertMember(MemberVO vo) throws Exception {
		memberMapper.insertMember(vo);
	}
	
	@Override
	public void kakaoInsertMember(MemberVO vo) throws Exception {
		memberMapper.kakaoInsertMember(vo);
	}

	@Override
	public int selectMemberIdCheck(String memberId) throws Exception {
		return memberMapper.selectMemberIdCheck(memberId);
	}

	@Override
	public int selectMemberNicknameCheck(String memberNickname) throws Exception {
		return memberMapper.selectMemberNicknameCheck(memberNickname);
	}

	@Override
	public int selectMemberEmailCheck(String memberEmail) throws Exception {
		return memberMapper.selectMemberEmailCheck(memberEmail);
	}

	@Override
	public MemberVO selectMemberCount(MemberVO vo) throws Exception {
		return memberMapper.selectMemberCount(vo);
	}

	
	@Override
	public int kakaoSelectById(String memberId) throws Exception {
		return memberMapper.kakaoSelectById(memberId);
	}

	@Override
	public String selectByFindId(MemberVO vo) throws Exception {
		return memberMapper.selectByFindId(vo);
	}

	@Override
	public int selectByFindPwd(MemberVO vo) throws Exception {
		return memberMapper.selectByFindPwd(vo);
	}

	@Override
	public void updateTempPwd(MemberVO vo) throws Exception {
		memberMapper.updateTempPwd(vo);
	}

	@Override
	public MemberVO selectKakaoGubun(String memberId) throws Exception {
		return memberMapper.selectKakaoGubun(memberId);
	}




}
