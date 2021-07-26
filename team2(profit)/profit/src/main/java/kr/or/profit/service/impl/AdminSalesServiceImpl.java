package kr.or.profit.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.AdminSalesMapper;
import kr.or.profit.service.AdminSalesService;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.ChattingVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.SalesVO;


@Service("adminSalesService")
public class AdminSalesServiceImpl implements AdminSalesService {

	@Resource(name = "adminSalesMapper")
	private AdminSalesMapper adminSalesDAO;

	//관리자가보는 정산하기 리스트
	@Override
	public List<?> selectAdminSales(Criteria cri) throws Exception {
		return adminSalesDAO.selectAdminSales(cri);
	}

	//전체 글 개수
	@Override
	public int selectAdminSalesCnt(Criteria cri) throws Exception {
		return adminSalesDAO.selectAdminSalesCnt(cri);
	}

	//관리자가보는 정산하기 상세 리스트
	@Override
	public List<?> selectAdminSalesDetail(Criteria cri) throws Exception {
		return adminSalesDAO.selectAdminSalesDetail(cri);
	}

	//정산하기 상세 리스트 전체 글 개수 세팅
	@Override
	public int selectAdminSalesDetailCnt(Criteria cri) throws Exception {
		System.out.println("얌마" + cri.getGubun());
		System.out.println(cri.getYyyymm());
		return adminSalesDAO.selectAdminSalesDetailCnt(cri);
	}

	//정산하기 상세 총금액
	@Override
	public List<?> totalPrice(Criteria cri) throws Exception {
		return adminSalesDAO.totalPrice(cri);
	}

	//일괄정산시 sales 테이블에 insert
	@Override
	public int insertSales(SalesVO vo) throws Exception {
		return adminSalesDAO.insertSales(vo);
	}

	//일괄정산시 buy_lesson 테이블에 update
	@Override
	public int updateBuyLesson(BuyLessonVO buyvo) throws Exception {
		return adminSalesDAO.updateBuyLesson(buyvo);
	}

	//일괄정산 시 chatting 테이블에 update
	@Override
	public int updateChatting(ChattingVO chatvo) throws Exception {
		return adminSalesDAO.updateChatting(chatvo);
	}

	//정산pdf 정보
	@Override
	public List<Map<String, Object>> selectAccountList(Map<String, Object> info) throws Exception {
		return adminSalesDAO.selectAccountList(info);
	}

	//정산 pdf 합계정보
	@Override
	public List<Map<String, Object>>  selectAccountSumList(Map<String, Object> info) throws Exception {
		return adminSalesDAO.selectAccountSumList(info);
	}

	

	


}
