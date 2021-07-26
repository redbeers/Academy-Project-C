package kr.or.profit.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.BuyTicketVO;
import kr.or.profit.vo.Criteria;


@Mapper("adminChatMapper")
public interface AdminChatMapper {

	public List<Map<String, Object>> selectAdminChatList(Criteria cri);

	public int selectAdminChatCnt(Criteria cri);

	//관리자 이용권조회리스트
	public List<?> adminTicketPayList(Criteria cri) throws Exception ;

	//관리자 이용권조회 리스트 전체 글 개수 
	public int adminTicketPayListCnt(Criteria cri) throws Exception;

	//관리자 이용권개수 수정
	public int updTicketCnt(BuyTicketVO vo) throws Exception;

	//채팅개수 최근 7일
	public Map<String, Object> ChatDays() throws Exception;

	//채팅개수 최근 7일 수익(남자)
	public Map<String, Object> ChatDaysM() throws Exception;

	//채팅개수 최근 7일 (여자)
	public Map<String, Object> ChatDaysF() throws Exception;

	//채팅개수 최근 5주 수익
	public Map<String, Object> chatWeeks() throws Exception;

	//채팅개수 최근 5주 (남자)
	public Map<String, Object> chatWeeksM() throws Exception;

	//채팅개수 최근 5주 (여자)
	public Map<String, Object> chatWeeksF() throws Exception;

	//채팅건수 최근6개월 
	public Map<String, Object> chatMonths() throws Exception;

	//채팅건수 최근 6개월 (남자)
	public Map<String, Object> chatMonthsM() throws Exception;

	//채팅건수 최근 6개월(여자)
	public Map<String, Object> chatMonthsF() throws Exception;

}
