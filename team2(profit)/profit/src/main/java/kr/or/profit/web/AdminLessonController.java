package kr.or.profit.web;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.profit.service.AdminLessonService;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.PageMaker;

@Controller
public class AdminLessonController {
	@Resource(name="adminLessonService")
	private AdminLessonService adminLessonService;
	
	@RequestMapping(value = "adminLessonList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adminLessonList(Locale locale, Model model, Criteria cri, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		System.out.println("memberId : " + memberId);
		if (memberId == null) {
			memberId = "";
		}
		
		cri.setPerPageNum(10);
		
		//관리자가보는 온라인클래스 리스트
		List<?> adminLessonList = adminLessonService.selectAdminLessonList(cri);
		System.out.println("adminLessonList " + adminLessonList);
		model.addAttribute("adminLessonList", adminLessonList);
		System.out.println("resultModel " + model.toString());
		
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		System.out.println("뭔데");
		System.out.println(pageMaker.getCri().getPage());
		System.out.println(pageMaker.getCri().getPageStart());
		System.out.println(pageMaker.getCri().getPerPageNum());
		
		//전체 글 개수 세팅
		pageMaker.setTotalCount(adminLessonService.selectAdminLessonCnt(cri));
		System.out.println(adminLessonService.selectAdminLessonCnt(cri) + "가져오는 개수!");
		
		model.addAttribute("pageMaker", pageMaker);
		
		
		
		
		return "adminLesson/adminLessonList";
	}
	
	
	/**
	 * 관리자 강의 활성화 업데이트
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
   @RequestMapping(value = "updAdminLessonAjax.do")
   @ResponseBody
   public String updAdminLesson(HttpServletRequest request, Model model) throws Exception {
	   HttpSession session = request.getSession();
	   String memberId = (String) session.getAttribute("memberId");
	   System.out.println("memberId업데이트하게나와랏 " + memberId);
	   if (memberId == null) {
		   memberId = "";
	   }
	   
      String lessonSeq = request.getParameter("lessonSeq");
      System.out.println("lessonSeq가져오삼= " + lessonSeq);
      
//      List<?> selectBuyLesson = adminLessonService.selectList(lessonSeq);
//      model.addAttribute("selectBuyLesson", selectBuyLesson);
//      System.out.println("모델 "+ model.toString());
//      String lessonRefundFlag = request.getParameter("lessonRefundFlag");
//      System.out.println("lessonRefundFlag : " +lessonRefundFlag);
      
      //관리자비활성화 시 구매테이블 refund_flag 업데이트
      BuyLessonVO buyvo = new BuyLessonVO();
      buyvo.setMemberId(memberId);
      buyvo.setLessonSeq(lessonSeq);
      int cnt1 = adminLessonService.updAdminRefund(buyvo);
      
      //관리자비활성화 시 강의 테이블 private_flag 업데이트
      String lessonPrivateFlag = request.getParameter("lessonPrivateFlag");
      System.out.println("lessonPrivateFlag가져오삼 " + lessonPrivateFlag);
      
      if(("N").equals(lessonPrivateFlag)) {
    	  lessonPrivateFlag = "Y";
      }else {
    	  lessonPrivateFlag = "N";
      }
      System.out.println("바뀐lessonPrivateFlag " + lessonPrivateFlag);
      
      LessonVO vo = new LessonVO();
      vo.setMemberId(memberId);
      vo.setLessonSeq(lessonSeq);
      vo.setLessonPrivateFlag(lessonPrivateFlag);
      System.out.println("여기1");
      
	  int cnt = adminLessonService.updAdminLesson(vo);
	  System.out.println("여기2");
      String msg = "ng";
      
      if(cnt > 0 && cnt1>0) {
         msg = "ok";
      }
      System.out.println("얌마"+msg);
       return msg;
   }

   /**
    * 민정
    * 관리자 강의 결제 환불내역
    * @param request
    * @param cri
    * @param locale
    * @param model
    * @return
    * @throws Exception
    */
   @RequestMapping(value = "adminLessonPayList.do", method = RequestMethod.GET)
	public String adminLessonPayList(HttpServletRequest request, Criteria cri, Locale locale, Model model) throws Exception {

	   HttpSession session = request.getSession();
	   String memberId = (String) session.getAttribute("memberId");
	   System.out.println("memberId는뭥미? " + memberId);
	   if (memberId == null) {
		   memberId = "";
	   }
	   
	   cri.setPerPageNum(10);
	   
	 //관리자가보는 온라인클래스 결제/환불 리스트
		List<?> adminLessonPayList = adminLessonService.adminLessonPayList(cri);
		System.out.println("adminLessonPayList " + adminLessonPayList);
		model.addAttribute("adminLessonPayList", adminLessonPayList);
		System.out.println("adminLessonPayList " + model.toString());
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		System.out.println("뭔데");
		System.out.println(pageMaker.getCri().getPage());
		System.out.println(pageMaker.getCri().getPageStart());
		System.out.println(pageMaker.getCri().getPerPageNum());
		
		//전체 글 개수 세팅
		pageMaker.setTotalCount(adminLessonService.adminLessonPayListCnt(cri));
		System.out.println(adminLessonService.adminLessonPayListCnt(cri) + "가져오는 개수뭐니?!");
		
		model.addAttribute("pageMaker", pageMaker);
	   
		return "adminLesson/adminLessonPayList";
	}	
	
   
   @RequestMapping(value = "adminLessonStat.do", method = RequestMethod.GET)
	public String adminLessonStat(Locale locale, Model model) throws Exception{
	   
	   //온라인 클래스 최근 7일 인기강좌
	   List<Map<String,Object>> sevenDays = adminLessonService.lessonPopularDays();
	   model.addAttribute("lessonPopularDays", sevenDays);
	   
	   //온라인 클래스 최근 5주 인기강좌
	   List<Map<String,Object>> fiveWeeks = adminLessonService.lessonPopularWeeks();
	   model.addAttribute("lessonPopularWeeks", fiveWeeks);
	   
	   //온라인 클래스 최근 6개월 인기강좌
	   List<Map<String,Object>> sixMonths = adminLessonService.lessonPopularMonths();
	   model.addAttribute("lessonPopularMonths", sixMonths);
	   
	   //온라인 클래스 최근 7일 수익
//	   Map<String,Object> sevenDays = adminLessonService.lessonPriceDays();
//	   model.addAttribute("lessonPriceDays", sevenDays);
	   
	   //온라인 클래스 최근 7일 수익(남자)
//	   Map<String,Object> sevenDaysM = adminLessonService.lessonPriceDaysM();
//	   model.addAttribute("lessonPriceDaysM" , sevenDaysM);
	   
	   //온라인 클래스 최근 7일 수익(여자)
//	   Map<String,Object> sevenDaysF = adminLessonService.lessonPriceDaysF();
//	   model.addAttribute("lessonPriceDaysF" , sevenDaysF);
	   
	   //온라인 클래스 최근 5주 수익
//	   Map<String,Object> fiveWeeks = adminLessonService.lessonPriceWeeks();
//	   model.addAttribute("lessonPriceWeeks" , fiveWeeks);
	   
	   //온라인 클래스 최근 5주 수익(남자)
//	   Map<String,Object> fiveWeeksM = adminLessonService.lessonPriceWeeksM();
//	   model.addAttribute("lessonPriceWeeksM" , fiveWeeksM);
//	   
	   //온라인 클래스 최근 5주 수익(여자)
//	   Map<String,Object> fiveWeeksF = adminLessonService.lessonPriceWeeksF();
//	   model.addAttribute("lessonPriceWeeksF" , fiveWeeksF);
	   
	   //온라인 클래스 최근 6개월 수익
//	   Map<String,Object> sixMonths = adminLessonService.lessonPriceMonths();
//	   model.addAttribute("lessonPriceMonths" , sixMonths);
	   
	   //온라인 클래스 최근 6개월 수익(남자)
//	   Map<String,Object> sixMonthsM = adminLessonService.lessonPriceMonthsM();
//	   model.addAttribute("lessonPriceMonthsM" , sixMonthsM);
	   
	   //온라인 클래스 최근 6개월 수익(여자)
//	   Map<String,Object> sixMonthsF = adminLessonService.lessonPriceMonthsF();
//	   model.addAttribute("lessonPriceMonthsF" , sixMonthsF);
	   
	   //신규강좌(일주일) 구매 TOP5
	   List<Map<String,Object>> buyTop5 = adminLessonService.newTop5();
	   model.addAttribute("buyTop5" , buyTop5);
	   
	   //카테고리별 신규강좌 등록 비율
	   Map<String,Object> newRegister = adminLessonService.newRegister();
	   model.addAttribute("newRegister" , newRegister);
	   
	   //최근 일주일 신규강좌 등록 수
	   Map<String,Object> newRegisterCount = adminLessonService.newRegisterCount();
	   model.addAttribute("newRegisterCount" , newRegisterCount);
	   
	   //누적 북마크순
	   List<Map<String,Object>> bookmarkRank = adminLessonService.bookmarkRank();
	   model.addAttribute("bookmarkRank" , bookmarkRank);
	   
	   //누적 좋아요순
	   List<Map<String,Object>> goodRank = adminLessonService.goodRank();
	   model.addAttribute("goodRank" , goodRank );
	   
	   //누적 조회순
	   List<Map<String,Object>> viewRank = adminLessonService.viewRank();
	   model.addAttribute("viewRank" , viewRank );
	   
	   //누적 인기강좌 순위
	   List<Map<String,Object>> lessonRank = adminLessonService.lessonRank();
	   model.addAttribute("lessonRank", lessonRank);
	   System.out.println(model.toString());
	   return "adminLesson/adminLessonStat";
	}
   
	
}