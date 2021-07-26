package kr.or.profit.mapper;


import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.ChattingVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.SalesVO;


@Mapper("adminSalesMapper")
public interface AdminSalesMapper {

	//관리자가보는 정산하기 리스트
	List<?> selectAdminSales(Criteria cri) throws Exception;

	//전체 글 개수
	int selectAdminSalesCnt(Criteria cri) throws Exception;

	//관리자가보는 정산하기 상세 리스트
	List<?> selectAdminSalesDetail(Criteria cri) throws Exception;

	//정산하기 상세 리스트 전체 글 개수 세팅
	int selectAdminSalesDetailCnt(Criteria cri) throws Exception;

	//정산하기 상세 총금액
	List<?> totalPrice(Criteria cri) throws Exception;

	//일괄정산시 sales 테이블에 insert
	int insertSales(SalesVO vo) throws Exception;

	//일괄정산시 buy_lesson 테이블에 update
	int updateBuyLesson(BuyLessonVO buyvo) throws Exception;

	//일괄정산 시 chatting 테이블에 update
	int updateChatting(ChattingVO chatvo) throws Exception;

	//정산pdf 정보
	List<Map<String, Object>> selectAccountList(Map<String, Object> info) throws Exception;

	//정산 pdf 합계정보
	List<Map<String, Object>>  selectAccountSumList(Map<String, Object> info) throws Exception;



}
