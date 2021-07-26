package kr.or.profit.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.profit.service.AdminSalesService;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.ChattingVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.PageMaker;
import kr.or.profit.vo.ReplyVO;
import kr.or.profit.vo.SalesVO;
import net.sf.json.JSONObject;

@Controller
public class AdminSalesController {
	@Resource(name = "adminSalesService")
	private  AdminSalesService adminSalesService;
	
	@RequestMapping(value = "adminSalesList.do", method = RequestMethod.GET)
	public String adminSalesList(Locale locale, Model model, Criteria cri, HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		System.out.println("memberId : " + memberId);
		if (memberId == null) {
			memberId = "";
		}
		
		cri.setPerPageNum(10);
		
		//관리자가보는 정산하기 리스트
		List<?> adminSalesList = adminSalesService.selectAdminSales(cri);
		System.out.println("adminSalesList " + adminSalesList);
		model.addAttribute("adminSalesList", adminSalesList);
		System.out.println("resultModel " + model.toString());
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		System.out.println("뭔데");
		System.out.println(pageMaker.getCri().getPage());
		System.out.println(pageMaker.getCri().getPageStart());
		System.out.println(pageMaker.getCri().getPerPageNum());
		
		//전체 글 개수 세팅
		pageMaker.setTotalCount(adminSalesService.selectAdminSalesCnt(cri));
		System.out.println(adminSalesService.selectAdminSalesCnt(cri) + "가져오는 개수!");
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "adminSales/adminSalesList";
	}
	
	@RequestMapping(value = "adminSalesDetail.do", method = RequestMethod.GET)
	public String adminSalesDetail(Locale locale, Model model, Criteria cri, HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		System.out.println("memberId : " + memberId);
		if (memberId == null) {
			memberId = "";
		}
		
		String yyyymm = request.getParameter("yyyymm");
		System.out.println("yyyymm뭐 " + yyyymm);
		String gubun = request.getParameter("gubun");
		System.out.println("gubun뭐 " + gubun);
		
		cri.setPerPageNum(10);
		cri.setYyyymm(yyyymm);
		cri.setGubun(gubun);
		
		//관리자가보는 정산하기 상세 리스트
		List<?> adminSalesDetailList = adminSalesService.selectAdminSalesDetail(cri);
		System.out.println("adminSalesDetailList " + adminSalesDetailList);
		model.addAttribute("adminSalesDetailList", adminSalesDetailList);
		System.out.println("resultModel " + model.toString());
		
		//정산하기 상세 총금액
		List<?> totalPrice =  adminSalesService.totalPrice(cri);
		System.out.println(totalPrice);
		model.addAttribute("totalPrice", totalPrice);
		System.out.println("모델가져와 " + model.toString());
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		System.out.println("뭔데");
		System.out.println(pageMaker.getCri().getPage());
		System.out.println(pageMaker.getCri().getPageStart());
		System.out.println(pageMaker.getCri().getPerPageNum());
		
		//정산하기 상세 리스트 전체 글 개수 세팅
		pageMaker.setTotalCount(adminSalesService.selectAdminSalesDetailCnt(cri));
		System.out.println(adminSalesService.selectAdminSalesDetailCnt(cri) + "가져오는 개수!");
		
		model.addAttribute("pageMaker", pageMaker);
		
		
		return "adminSales/adminSalesDetail";
	}
	
	/**
	 * 일괄정산 insert
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "insSalesAjax.do", method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String insSalesAjax(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		System.out.println("멤버아이디 "+memberId);
		System.out.println("오니?");
		
		String gubun = request.getParameter("gubun");
		System.out.println("gubun여기서찍어라 " + gubun);
		
		String yyyymm = request.getParameter("yyyymm");
		System.out.println("yyyymm : " + yyyymm);
		
		String totalfee = request.getParameter("totalfee");
		System.out.println("totalfee값 " + totalfee);
		
		
		if(("온라인클래스").equals(gubun)) {
			gubun = "O";
		}else if(("채팅").equals(gubun)) {
			gubun = "C";
		}
		System.out.println("최종gubun "+ gubun);
		
		int totalfee2 = Integer.parseInt(totalfee);
		System.out.println("totalfee2 " + totalfee2);
		
		SalesVO vo = new SalesVO();
		vo.setSalesGubun(gubun);
		vo.setSlaesMonth(yyyymm);
		vo.setSalesFee(totalfee);
		vo.setInUserId(memberId);
		vo.setUpUserId(memberId);
		
		//일괄정산시 sales 테이블에 insert
		int insertResult = adminSalesService.insertSales(vo);
		System.out.println("insertResult개수 " +insertResult );
		
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm");
		Date yd = dateFormat.parse(yyyymm);
		String finalDate = new SimpleDateFormat("yyyy/mm").format(yd);
		System.out.println("finalDate " + finalDate );

		int updateResult=0;
		if(("O").equals(gubun)) {
			BuyLessonVO buyvo = new BuyLessonVO();
			buyvo.setYyyymm(finalDate);
			
			//일괄정산시 buy_lesson 테이블에 update
			updateResult = adminSalesService.updateBuyLesson(buyvo);
			System.out.println("updateResult개수 " +updateResult);
		}else if(("C").equals(gubun)) {
			ChattingVO chatvo = new ChattingVO();
			chatvo.setYyyymm(finalDate);
		//일괄정산 시 chatting 테이블에 update
			updateResult = adminSalesService.updateChatting(chatvo);
			System.out.println("updateResult1개수 " + updateResult);
			
		}

		
		
	    String msg="ng";
	    
		if(insertResult > 0 & updateResult>0) {
			msg = "ok";
		}
		return msg;
	}


	
//	@RequestMapping(value = "showPdfAjax.do", produces = "application/text; charset=utf-8")
//	@ResponseBody
//	public String showPdfAjax(HttpServletRequest request, HttpServletResponse response,  Model model) throws Exception{
//		HttpSession session = request.getSession();
//		String memberId = (String) session.getAttribute("memberId");
//		System.out.println("멤버아이디 "+memberId);
//		System.out.println("오니?");
//		
//		String yyyymm = request.getParameter("yyyymm");
//		System.out.println("yyyymm : " + yyyymm);
//		
//		String gubun = request.getParameter("gubun");
//		System.out.println("gubun여기서찍어라 " + gubun);
//		
//		Map<String, Object> info = new HashMap<>();
//		info.put("memberId", memberId);
//		info.put("yyyymm", yyyymm);
//		info.put("gubun", gubun);
//		
//		//정산pdf 정보
//		List<Map<String, Object>> AccountList = adminSalesService.selectAccountList(info);
//		
//		JSONObject jsonObject = new JSONObject();
//		
//		jsonObject.put("msg", "ok");
//		jsonObject.put("AccountList", AccountList);
//		
//		String jsonInfo = jsonObject.toString();
//		System.out.println("jsonInfo " + jsonInfo);
//		
//		return jsonInfo;
//	}
	
	
	@RequestMapping(value = "salesAccountPdf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String salesAccountPdf(HttpServletRequest request, Model model) throws Exception{
		System.out.println("여기");
//		System.out.println(request.getParameter("yyyymm"));
//		System.out.println(request.getParameter("gubun"));
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		
		String yyyymm = request.getParameter("yyyymm");
		System.out.println("yyyymm : " + yyyymm);
		
		String gubun = request.getParameter("gubun");
		System.out.println("gubun여기서찍어라 " + gubun);
		
		Map<String, Object> info = new HashMap<>();
		info.put("memberId", memberId);
		info.put("yyyymm", yyyymm);
		info.put("gubun", gubun);
		
		List<Map<String, Object>> AccountList = adminSalesService.selectAccountList(info);
		model.addAttribute("AccountList", AccountList);
		
		List<Map<String, Object>> AccountSumList = adminSalesService.selectAccountSumList(info);
		model.addAttribute("AccountSumList", AccountSumList);
		
		System.out.println("모델...");
		System.out.println(model.toString());
	
		return "adminSales/salesAccountPdf";
	}
	
	
}