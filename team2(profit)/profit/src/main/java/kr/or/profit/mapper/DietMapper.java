package kr.or.profit.mapper;

import java.util.List;
import java.util.Map;

import org.antlr.grammar.v3.ANTLRParser.throwsSpec_return;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BuyTicketVO;
import kr.or.profit.vo.ChatProfileVO;
import kr.or.profit.vo.ChattingVO;
import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.ReplyVO;

@Mapper("dietMapper")
public interface DietMapper {
	
	
   //웹소켓
   int updateChatNowFlagToY(String memberId) throws Exception;
   int updateChatNowFlagToN(String memberId) throws Exception;
   
   //웹소켓 세션용 트레이너 리스트
   List<ChatProfileVO> websocketSessionList() throws Exception;
	
	//선택한 이용권 정보 조회
	Map<String, Object> selectTicketCategory(String ticketCategorySeq) throws Exception;
	
	//구매한 이용권 정보 추가
	int insertBuyTicket(BuyTicketVO vo) throws Exception;
	
	//사용가능한 이용권 존재여부 확인
	int selectAvailableTicket(String memberId) throws Exception;
	
	//채팅 프로필 등록
	int insertChatProfile(ChatProfileVO vo) throws Exception;
	
	//상담 프로필 등록 여부
	int selectRegisterProfile(String memberId) throws Exception;
	
	//상담 프로필 목록 가져오기
	List<Map<String, Object>> selectChatProflieList(Criteria cri) throws Exception;
	
	//상담 프로필 사진 추가
	int insertProcessFile(Map<String, Object> filemap) throws Exception;
	
	//상담 프로필 상세 조회
	Map<String, Object> selectChatProfileDetail(String chatProfileSeq) throws Exception;
	
	//문의 목록 조회
	List<Map<String, Object>> selectReplyList(String chatProfileSeq) throws Exception;
	
	//문의 댓글 추가
	int insertChatReply(ReplyVO vo) throws Exception;
	
	//문의 댓글 내 프로필 사진
	String selectMyProfile(String memberId) throws Exception;
	
	//문의 답글 추가
	int insertChatRereply(ReplyVO vo) throws Exception;
	
	//상담 프로필 수정
	int updateChatProfile(ChatProfileVO vo) throws Exception;
	
	//상담 프로필 비활성화
	int updatePrivate(String chatProfileSeq) throws Exception;
	
	//상담 프로필 활성화
	int updatePublic(String chatProfileSeq) throws Exception;
	
	//칼로리 정보 목록 조회
	List<Map<String, Object>> selectKcalList(Criteria cri) throws Exception;
	
	//페이징 - 칼로리 정보 목록 전체 글 개수
	int selectKcalCnt(Criteria cri) throws Exception;
	
	//kcal 정보 상세 조회
	Map<String, Object> selectkcalDetail(String kcalNum) throws Exception;
	
	//인기검색어 조회수 증가
	int updateKcalHit(String kcalNum) throws Exception;

	//인기 검색어 목록
	List<Map<String, Object>> selectPopularSearch() throws Exception;
	
	//전체 글 개수 세팅
	int selectChatListCnt(Criteria cri) throws Exception;
	
	//사용가능한 이용권이 있는 지 확인
	int selectMyticketFlag(String memberId) throws Exception;
	
	//이용권 개수 차감
	int updateTicketRemain(String memberId) throws Exception;
	
	//채팅 테이블에 데이터 추가
	int insertChatting(ChattingVO chattingVO) throws Exception;
	
}