package kr.or.profit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.AdminLessonMapper;
import kr.or.profit.mapper.AdminMemberMapper;
import kr.or.profit.service.AdminLessonService;
import kr.or.profit.service.AdminMemberService;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.ProcessVO;

@Service("adminLessonService")
public class AdminLessonServiceImpl implements AdminLessonService {

	@Resource(name = "adminLessonMapper")
	private AdminLessonMapper adminLessonDAO;

	//관리자 - 온라인클래스 강좌 리스트
	@Override
	public List<?> selectAdminLessonList(Criteria cri) throws Exception {
		return adminLessonDAO.selectAdminLessonList(cri);
	}

	//페이징 - 온라인클래스 목록 개수
	@Override
	public int selectAdminLessonCnt(Criteria cri) throws Exception {
		return adminLessonDAO.selectAdminLessonCnt(cri);
	}

	//관리자 강의 상태업데이트
	@Override
	public int updAdminLesson(LessonVO vo) throws Exception {
		return adminLessonDAO.updAdminLesson(vo);
	}

	//refund_flag위한 리스트
	@Override
	public List<?> selectList(String lessonSeq) throws Exception {
		return adminLessonDAO.selectList(lessonSeq);
	}

	//관리자 비활성화 환불
	@Override
	public int updAdminRefund(BuyLessonVO buyvo) throws Exception {
		return adminLessonDAO.updAdminRefund(buyvo);
	}

	//관리자가보는 온라인클래스 결제/환불 리스트
	@Override
	public List<?> adminLessonPayList(Criteria cri) throws Exception {
		return adminLessonDAO.adminLessonPayList(cri);
	}

	//온라인클래스 결제/환불내역 전체 글개수
	@Override
	public int adminLessonPayListCnt(Criteria cri) throws Exception {
		return adminLessonDAO.adminLessonPayListCnt(cri);
	}
	
	//온라인 클래스 최근 7일 인기강좌
	@Override
	public List<Map<String, Object>> lessonPopularDays() throws Exception {
		return adminLessonDAO.lessonPopularDays();
	}
	
	//온라인 클래스 최근 5주 인기강좌
	@Override
	public List<Map<String,Object>> lessonPopularWeeks() throws Exception {
		return adminLessonDAO.lessonPopularWeeks();
	}
	
	//온라인 클래스 최근 6개월 인기강좌
	@Override
	public List<Map<String,Object>> lessonPopularMonths() throws Exception {
		return adminLessonDAO.lessonPopularMonths();
	}
	

	//신규강좌(일주일) 구매 TOP5
	@Override
	public List<Map<String,Object>> newTop5() throws Exception {
		return adminLessonDAO.newTop5();
	}
	
	//카테고리별 신규강좌 등록 비율
	@Override
	public Map<String, Object> newRegister() throws Exception {
		return adminLessonDAO.newRegister();
	}
	
	//최근 일주일 신규강좌 등록 수
	@Override
	public Map<String, Object> newRegisterCount() throws Exception {
		return adminLessonDAO.newRegisterCount();
	}
	
	//누적 북마크순
	@Override
	public List<Map<String,Object>> bookmarkRank() throws Exception {
		return adminLessonDAO.bookmarkRank();
	}
	
	//누적 좋아요순
	@Override
	public List<Map<String, Object>> goodRank() throws Exception {
		return adminLessonDAO.goodRank();
	}
	
	//누적 조회순
	@Override
	public List<Map<String, Object>> viewRank() throws Exception {
		return adminLessonDAO.viewRank();
	}
	
	//누적 인기강좌 순위
	@Override
	public List<Map<String, Object>> lessonRank() throws Exception {
		return adminLessonDAO.lessonRank();
	}







	

	

	
	
	
	

}
