package kr.or.profit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.AdminChatMapper;
import kr.or.profit.mapper.CommunityMapper;
import kr.or.profit.service.AdminChatService;
import kr.or.profit.service.CommunityService;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.BuyTicketVO;
import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.ReplyVO;

@Service("adminChatService")
public class AdminChatServiceImpl implements AdminChatService {

	@Resource(name = "adminChatMapper")
	private AdminChatMapper adminChatDAO;
	
	//이용권 구매목록 조회
	@Override
	public List<Map<String, Object>> selectAdminChatList(Criteria cri) throws Exception {
		return adminChatDAO.selectAdminChatList(cri);
	}

	@Override
	public int selectAdminChatCnt(Criteria cri) throws Exception {
		return adminChatDAO.selectAdminChatCnt(cri);
	}

	//관리자 이용권조회리스트
	@Override
	public List<?> adminTicketPayList(Criteria cri) throws Exception {
		return adminChatDAO.adminTicketPayList(cri);
	}

	//관리자 이용권조회 리스트 전체 글 개수 
	@Override
	public int adminTicketPayListCnt(Criteria cri) throws Exception {
		return adminChatDAO.adminTicketPayListCnt(cri);
	}

	//관리자 이용권개수 수정
	@Override
	public int updTicketCnt(BuyTicketVO vo) throws Exception {
		return adminChatDAO.updTicketCnt(vo);
	}

	//채팅개수 최근 7일
	@Override
	public Map<String, Object> ChatDays() throws Exception {
		return adminChatDAO.ChatDays();
	}

	//채팅개수 최근 7일 수익(남자)
	@Override
	public Map<String, Object> ChatDaysM() throws Exception {
		return adminChatDAO.ChatDaysM();
	}

	//채팅개수 최근 7일 (여자)
	@Override
	public Map<String, Object> ChatDaysF() throws Exception {
		return adminChatDAO.ChatDaysF();
	}

	//채팅개수 최근 5주 수익
	@Override
	public Map<String, Object> chatWeeks() throws Exception {
		return adminChatDAO.chatWeeks();
	}

	//채팅개수 최근 5주 (남자)
	@Override
	public Map<String, Object> chatWeeksM() throws Exception {
		return adminChatDAO.chatWeeksM();
	}

	//채팅개수 최근 5주 (여자)
	@Override
	public Map<String, Object> chatWeeksF() throws Exception {
		return adminChatDAO.chatWeeksF();
	}

	//채팅건수 최근6개월 
	@Override
	public Map<String, Object> chatMonths() throws Exception {
		return adminChatDAO.chatMonths();
	}

	//채팅건수 최근 6개월 (남자)
	@Override
	public Map<String, Object> chatMonthsM() throws Exception {
		return adminChatDAO.chatMonthsM();
	}

	//채팅건수 최근 6개월(여자)
	@Override
	public Map<String, Object> chatMonthsF() throws Exception {
		return adminChatDAO.chatMonthsF();
	}

	


	
	


}
