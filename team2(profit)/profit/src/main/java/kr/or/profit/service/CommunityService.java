package kr.or.profit.service;

import java.util.List;
import java.util.Map;

import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.ReplyVO;

public interface CommunityService {


	//자유게시판 글 등록
	public int insertBoard(CommunityVO vo) throws Exception;
	
	//자유게시판 사진파일 추가
	public int insertBoardFile(AttachFileVO vo) throws Exception;
	
	//페이징 - 자유게시판 전체 글 개수
	public int selectBoardCnt(Criteria cri) throws Exception;
	
	//자유게시판 목록 조회
	public List<Map<String, String>> selectBoardList(Criteria cri) throws Exception;
	
	//자유게시판 인기글 목록 조회
	public List<Map<String, String>> selectBoardTopList(String memberId) throws Exception;
	
	//자유게시판 상세 글 조회
	public Map<String, Object> selectBoardDetail(CommunityVO paramVO) throws Exception;
	
	//자유게시판 상세 댓글 나의 프로필 사진 조회
	public String selectMyProfile(String memberId) throws Exception;
	
	//자유게시판 상세 댓글 추가
	public int insertBoardReply(ReplyVO vo) throws Exception;
	
	//자유게시판 댓글 리스트 가져오기
	public List<Map<String, Object>> selectReplyList(String communitySeq) throws Exception;
	
	//자유게시판 답글 추가
	public int insertBoardRereply(ReplyVO vo) throws Exception;
	
	//자유게시판 댓글 삭제
	public int deleteBoardReply(String replySeq) throws Exception;
	
	//자유게시판 조회수 증가
	public int increaseHit(String communitySeq) throws Exception;
	
	//자유게시판 글 수정
	public int updateBoard(CommunityVO vo) throws Exception;
	
	//자유게시판 글 삭제
	public int deleteBoard(String communitySeq) throws Exception;
	
	//최신글 TOP5 가져오기
	public List<Map<String, Object>> recentBoardList() throws Exception;
	
	//인기글 TOP5 가져오기
	public List<Map<String, Object>> bestBoardList() throws Exception;
	
	//좋아요북마크 삭제
	public int deleteBookgood(BookgoodVO vo) throws Exception;
	
	//좋아요북마크 추가
	public int insertBookgood(BookgoodVO vo) throws Exception;
	
	//좋아요북마크 개수 가져오기
	public int selectBookgoodCnt(BookgoodVO vo) throws Exception;
	
	//댓글 수 가져오기
	public Map<String, Object> selectReplyCnt(String communitySeq) throws Exception;
	
	
	
	
	
}
