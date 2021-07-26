package kr.or.profit.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonVO;


@Mapper("adminLessonMapper")
public interface AdminLessonMapper {

	//관리자 - 온라인클래스 강좌 리스트
	List<?> selectAdminLessonList(Criteria cri) throws Exception;

	public int selectAdminLessonCnt(Criteria cri) throws Exception;

	//관리자 강의 상태업데이트
	int updAdminLesson(LessonVO vo) throws Exception;

	//refund_flag위한 리스트
	List<?> selectList(String lessonSeq) throws Exception;

	//관리자 비활성화 환불
	int updAdminRefund(BuyLessonVO buyvo)  throws Exception;

	//관리자가보는 온라인클래스 결제/환불 리스트
	List<?> adminLessonPayList(Criteria cri) throws Exception;

	//온라인클래스 결제/환불내역 전체 글개수
	int adminLessonPayListCnt(Criteria cri) throws Exception;
	
	//온라인 클래스 최근 7일 인기강좌
	List<Map<String, Object>> lessonPopularDays() throws Exception;
	
	//온라인 클래스 최근 5주 인기강좌
	List<Map<String,Object>> lessonPopularWeeks() throws Exception;
	
	//온라인 클래스 최근 6개월 인기강좌
	List<Map<String,Object>> lessonPopularMonths() throws Exception;
	
	
	//신규강좌(일주일) 구매 TOP5
	List<Map<String,Object>> newTop5() throws Exception;
	
	//카테고리별 신규강좌 등록 비율
	Map<String, Object> newRegister() throws Exception;
	
	//최근 일주일 신규강좌 등록 수
	Map<String, Object> newRegisterCount()throws Exception;
	
	//누적 북마크순
	List<Map<String,Object>> bookmarkRank() throws Exception;
	
	//누적 좋아요순
	List<Map<String, Object>> goodRank() throws Exception;
	
	//누적 조회순
	List<Map<String, Object>> viewRank() throws Exception;
	
	//누적 인기강좌 순위
	List<Map<String, Object>> lessonRank() throws Exception;





	

	

	


}
