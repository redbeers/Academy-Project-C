package kr.or.profit.service;

import java.util.List;
import java.util.Map;

import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.ReplyVO;

public interface QnaService {

//	List<?> qnaList(Criteria cri) throws Exception;
//
//	int qnaInsert(Map<String, Object> map) throws Exception;
//
	Map<String, Object> qnaDetail(Map<String, Object> map) throws Exception;

	int qnaUpdate(Map<String, Object> map) throws Exception;

	int qnaDelete(Map<String, Object> map) throws Exception;

//	//댓글등록
//	int qnaReplyInsert(Map<String, Object> map) throws Exception;
//
//	//댓글목록
//	List<?> qnaDetailReply(Map<String, Object> map) throws Exception;
//
//	//댓글삭제
//	int qnaReplyDelete(Map<String, Object> map) throws Exception;
//
//	Map<String, Object> qnaDetailMember(Map<String, Object> map) throws Exception;
//
//	List<?> qnaDetailReplyList(Map<String, Object> map) throws Exception;
//
//	int qnaReplyAdd(Map<String, Object> map) throws Exception;
//
//	int selectBoardCnt(Criteria cri) throws Exception;


	//관리자일 때 Qna 리스트 조회
	List<Map<String, Object>> selectAdminQnaList(Criteria cri) throws Exception;

	//사용자일때 Qna 리스트 조회
	List<Map<String, Object>> selectUserQnaList(Criteria cri) throws Exception;

	//관리자일때 전체 글 개수
	int selectAdminQnaCnt(Criteria cri) throws Exception;

	//사용자일때 전체 글 개수
	int selectUserQnaCnt(Criteria cri) throws Exception;

	//문의하기 상세
	Map<String, Object> selectQnaDetail(CommunityVO paramVO) throws Exception;

	//댓글 프로필 사진
	String selectQnaMyProfile(String memberId) throws Exception;

	// 댓글 목록
	List<Map<String, Object>> selectQnaReplyList(String communitySeq) throws Exception;

	//댓글 수 가져오기
	Map<String, Object> selectQnaReplyCnt(String communitySeq) throws Exception;

	//댓글 등록
	int insertQnaReply(ReplyVO replyvo) throws Exception;

	//답글 등록
	int insertQnaRereply(ReplyVO replyvo) throws Exception;

	//댓글 삭제
	int deleteQnaReply(String replySeq) throws Exception;

}
