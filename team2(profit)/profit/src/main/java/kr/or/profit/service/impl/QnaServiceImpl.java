package kr.or.profit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.QnaMapper;
import kr.or.profit.service.QnaService;
import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.ReplyVO;

@Service("qnaService")
public class QnaServiceImpl implements QnaService{

	@Resource(name = "qnaMapper")
	private QnaMapper mapper;

	//관리자일 때 Qna 리스트 조회
	@Override
	public List<Map<String, Object>> selectAdminQnaList(Criteria cri) throws Exception {
		return mapper.selectAdminQnaList(cri);
	}

	//사용자일때 Qna 리스트 조회
	@Override
	public List<Map<String, Object>> selectUserQnaList(Criteria cri) throws Exception {
		return mapper.selectUserQnaList(cri);
	}

	//관리자일때 전체 글 개수
	@Override
	public int selectAdminQnaCnt(Criteria cri) throws Exception {
		return mapper.selectAdminQnaCnt(cri);
	}

	//사용자일때 전체 글 개수
	@Override
	public int selectUserQnaCnt(Criteria cri) throws Exception {
		return mapper.selectUserQnaCnt(cri);
	}

	//문의하기 상세
	@Override
	public Map<String, Object> selectQnaDetail(CommunityVO paramVO) throws Exception {
		return mapper.selectQnaDetail(paramVO);
	}

	//댓글 프로필 사진
	@Override
	public String selectQnaMyProfile(String memberId) throws Exception {
		return mapper.selectQnaMyProfile(memberId);
	}

	// 댓글 목록
	@Override
	public List<Map<String, Object>> selectQnaReplyList(String communitySeq) throws Exception {
		return mapper.selectQnaReplyList(communitySeq);
	}

	//댓글 수 가져오기
	@Override
	public Map<String, Object> selectQnaReplyCnt(String communitySeq) throws Exception {
		return mapper.selectQnaReplyCnt(communitySeq);
	}

	//댓글 등록
	@Override
	public int insertQnaReply(ReplyVO replyvo) throws Exception {
		return mapper.insertQnaReply(replyvo);
	}

	//답글 등록
	@Override
	public int insertQnaRereply(ReplyVO replyvo) throws Exception {
		return mapper.insertQnaRereply(replyvo);
	}

	//댓글 삭제
	@Override
	public int deleteQnaReply(String replySeq) throws Exception {
		return mapper.deleteQnaReply(replySeq);
	}

	//문의하기 수정 내용 불러오기
	@Override
	public Map<String, Object> qnaDetail(Map<String, Object> map) throws Exception {
		return mapper.qnaDetail(map);
	}

	//문의하기 수정
	@Override
	public int qnaUpdate(Map<String, Object> map) throws Exception {
		return mapper.qnaUpdate(map);
	}

	//문의하기 삭제
	@Override
	public int qnaDelete(Map<String, Object> map) throws Exception {
		return mapper.qnaDelete(map);
	}
}
