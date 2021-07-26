package kr.or.profit.mapper;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.ReplyVO;

//Mapper Interface => 메서드명과 쿼리ID를 매핑하여 쿼리호출

@Mapper("qnaMapper")
public interface QnaMapper {

	List<?> qnaList(Criteria cri) throws Exception;

	int qnaInsert(Map<String, Object>map) throws Exception;

	//상세보기
	Map<String, Object> qnaDetail(Map<String, Object> map) throws Exception;

	int qnaUpdate(Map<String, Object> map) throws Exception;

	int qnaDelete(Map<String, Object> map) throws Exception;

	//댓글 등록
	int qnaReplyInsert(Map<String, Object> map) throws Exception;

	//댓글 목록
	List<?> qnaDetailReply(Map<String, Object> map) throws Exception;

	//댓글 삭제
	int qnaReplyDelete(Map<String, Object> map) throws Exception;

	//로그인중인사람 정보
	Map<String, Object> qnaDetailMember(Map<String, Object> map) throws Exception;

	//대 댓글 목록
	List<?> qnaDetailReplyList(Map<String, Object> map) throws Exception;

	//대 댓글 등록
	int qnaReplyAdd(Map<String, Object> map) throws Exception;

	//페이징
	int selectBoardCnt(Criteria cri) throws Exception;

	//관리자일 때 Qna 리스트 조회
	List<Map<String, Object>> selectAdminQnaList(Criteria cri) throws Exception;
	
	//사용자일 떄 Qna 리스트 조회
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
	
	//댓글 수 
	Map<String, Object> selectQnaReplyCnt(String communitySeq) throws Exception;
	
	//댓글 등록
	int insertQnaReply(ReplyVO replyvo) throws Exception;
	
	//답글 등록
	int insertQnaRereply(ReplyVO replyvo) throws Exception;
	
	//댓글 삭제
	int deleteQnaReply(String replySeq) throws Exception;

}
