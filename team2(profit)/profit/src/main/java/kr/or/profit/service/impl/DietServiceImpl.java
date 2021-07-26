package kr.or.profit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.CommunityMapper;
import kr.or.profit.mapper.DietMapper;
import kr.or.profit.service.CommunityService;
import kr.or.profit.service.DietService;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BuyTicketVO;
import kr.or.profit.vo.ChatProfileVO;
import kr.or.profit.vo.ChattingVO;
import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.ReplyVO;

@Service("dietService")
public class DietServiceImpl implements DietService {

	@Resource(name = "dietMapper")
	private DietMapper dietDAO;

	@Override
	public List<ChatProfileVO> websocketSessionList() throws Exception {
		return dietDAO.websocketSessionList();
	}

	@Override
	public int updateChatNowFlagToY(String memberId) throws Exception {
		return dietDAO.updateChatNowFlagToY(memberId);
	}

	@Override
	public int updateChatNowFlagToN(String memberId) throws Exception {
		return dietDAO.updateChatNowFlagToN(memberId);
	}

	// 선택한 이용권 정보 조회
	@Override
	public Map<String, Object> selectTicketCategory(String ticketCategorySeq) throws Exception {
		return dietDAO.selectTicketCategory(ticketCategorySeq);
	}

	// 구매한 이용권 정보 추가
	@Override
	public int insertBuyTicket(BuyTicketVO vo) throws Exception {
		return dietDAO.insertBuyTicket(vo);
	}

	// 사용가능한 이용권 존재여부 확인
	@Override
	public int selectAvailableTicket(String memberId) throws Exception {
		return dietDAO.selectAvailableTicket(memberId);
	}

	// 채팅 프로필 등록
	@Override
	public int insertChatProfile(ChatProfileVO vo) throws Exception {
		return dietDAO.insertChatProfile(vo);
	}

	// 상담 프로필 등록 여부
	@Override
	public int selectRegisterProfile(String memberId) throws Exception {
		return dietDAO.selectRegisterProfile(memberId);
	}

	// 상담 프로필 목록 가져오기
	@Override
	public List<Map<String, Object>> selectChatProflieList(Criteria cri) throws Exception {
		return dietDAO.selectChatProflieList(cri);
	}

	// 상담 프로필 사진 추가
	@Override
	public int insertProcessFile(Map<String, Object> filemap) throws Exception {
		return dietDAO.insertProcessFile(filemap);
	}

	// 상담 프로필 상세 조회
	@Override
	public Map<String, Object> selectChatProfileDetail(String chatProfileSeq) throws Exception {
		return dietDAO.selectChatProfileDetail(chatProfileSeq);
	}

	// 문의 목록 조회
	@Override
	public List<Map<String, Object>> selectReplyList(String chatProfileSeq) throws Exception {
		return dietDAO.selectReplyList(chatProfileSeq);
	}

	// 문의 댓글 추가
	public int insertChatReply(ReplyVO vo) throws Exception {
		return dietDAO.insertChatReply(vo);
	}

	// 문의 댓글 내 프로필 이미지
	@Override
	public String selectMyProfile(String memberId) throws Exception {
		return dietDAO.selectMyProfile(memberId);
	}

	// 문의 답글 추가
	@Override
	public int insertChatRereply(ReplyVO vo) throws Exception {
		return dietDAO.insertChatRereply(vo);
	}

	// 상담 프로필 수정
	@Override
	public int updateChatProfile(ChatProfileVO vo) throws Exception {
		return dietDAO.updateChatProfile(vo);
	}

	// 상담 프로필 비활성화
	@Override
	public int updatePrivate(String chatProfileSeq) throws Exception {
		return dietDAO.updatePrivate(chatProfileSeq);
	}

	// 상담 프로필 활성화
	@Override
	public int updatePublic(String chatProfileSeq) throws Exception {
		return dietDAO.updatePublic(chatProfileSeq);
	}

	// 칼로리 정보 목록 조회
	@Override
	public List<Map<String, Object>> selectKcalList(Criteria cri) throws Exception {
		return dietDAO.selectKcalList(cri);
	}

	// 페이징 - 칼로리 정보 목록 전체 글 개수
	@Override
	public int selectKcalCnt(Criteria cri) throws Exception {
		return dietDAO.selectKcalCnt(cri);
	}

	// kcal 정보 상세 조회
	@Override
	public Map<String, Object> selectkcalDetail(String kcalNum) throws Exception {
		return dietDAO.selectkcalDetail(kcalNum);
	}

	// 인기검색어 조회수 증가
	@Override
	public int updateKcalHit(String kcalNum) throws Exception {
		return dietDAO.updateKcalHit(kcalNum);
	}

	// 인기검색어 조회
	@Override
	public List<Map<String, Object>> selectPopularSearch() throws Exception {
		return dietDAO.selectPopularSearch();
	}

	// 전체 글 개수 세팅
	@Override
	public int selectChatListCnt(Criteria cri) throws Exception {
		return dietDAO.selectChatListCnt(cri);
	}

	// 사용가능한 이용권이 있는 지 확인
	@Override
	public int selectMyticketFlag(String memberId) throws Exception {
		return dietDAO.selectMyticketFlag(memberId);
	}

	// 이용권 개수 차감
	@Override
	public int updateTicketRemain(String memberId) throws Exception {
		return dietDAO.updateTicketRemain(memberId);
	}

	// 채팅 테이블에 데이터 추가
	@Override
	public int insertChatting(ChattingVO chattingVO) throws Exception {
		return dietDAO.insertChatting(chattingVO);
	}

}
