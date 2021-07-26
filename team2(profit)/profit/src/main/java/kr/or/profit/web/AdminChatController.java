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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.profit.service.AdminChatService;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.BuyTicketVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.PageMaker;

@Controller
public class AdminChatController {
	@Resource(name = "adminChatService")
	private AdminChatService adminChatService;
	
	@RequestMapping(value = "adminChatList.do",  method = { RequestMethod.GET, RequestMethod.POST })
	public String adminChatList(Model model, HttpServletRequest request, Criteria cri,
			@RequestParam(value = "selStatus", required = false) String selStatus,
			@RequestParam(value = "selIdentity", required = false) String selIdentity,
			@RequestParam(value = "selDate", required = false) String selDate,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword) throws Exception{
		
		//체크체크
		//request.getServletContext().setAttribute(name, object);
			
		System.out.println("selStatus : " + selStatus);
		System.out.println("selIdentity : " + selIdentity);
		System.out.println("selDate : " + selDate);
		System.out.println("searchKeyword : " + searchKeyword);
		
		cri.setPerPageNum(10);
		cri.setSelStatus(selStatus);
		cri.setSelIdentity(selIdentity);
		cri.setSelDate(selDate);
		cri.setSearchKeyword(searchKeyword);
		
		//이용권 구매 목록 조회
		List<Map<String, Object>> chatList = adminChatService.selectAdminChatList(cri);
		
		model.addAttribute("chatList", chatList);
		System.out.println("========");
		System.out.println(chatList.size());
		System.out.println(model.toString());
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		System.out.println("뭔데");
		System.out.println(pageMaker.getCri().getPage());
		System.out.println(pageMaker.getCri().getPageStart());
		System.out.println(pageMaker.getCri().getPerPageNum());
		
		System.out.println(adminChatService.selectAdminChatCnt(cri));
		//전체 글 개수 세팅
		pageMaker.setTotalCount(adminChatService.selectAdminChatCnt(cri));
		
		System.out.println(adminChatService.selectAdminChatCnt(cri) + "가져오는 개수!");
		model.addAttribute("pageMaker", pageMaker);
		
		//입력한 검색어 유지시키기
		model.addAttribute("selStatus", selStatus);
		model.addAttribute("selIdentity", selIdentity);
		model.addAttribute("selDate", selDate);
		model.addAttribute("searchKeyword", searchKeyword);
		
		System.out.println("최종 모델");
		System.out.println(model);
		
		return "adminChat/adminChatList";
	}
	
	/**
	 * 민정
	 * 관리자페이지 이용권조회
	 * @param locale
	 * @param model
	 * @param request
	 * @param cri
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "adminTicketPayList.do", method = RequestMethod.GET)
	public String adminTicketPayList(Locale locale, Model model , HttpServletRequest request, Criteria cri) throws Exception {

		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		System.out.println("memberId : " + memberId);
		if (memberId == null) {
			memberId = "";
		}
		
		cri.setPerPageNum(10);
		
		//관리자 이용권조회리스트
		List<?> adminTicketPayList = adminChatService.adminTicketPayList(cri);
		System.out.println("adminTicketPayList " + adminTicketPayList);
		model.addAttribute("adminTicketPayList", adminTicketPayList);
		System.out.println("adminTicketPayList " + model.toString());
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		System.out.println("뭔데");
		System.out.println(pageMaker.getCri().getPage());
		System.out.println(pageMaker.getCri().getPageStart());
		System.out.println(pageMaker.getCri().getPerPageNum());
		
		//전체 글 개수 세팅
		pageMaker.setTotalCount(adminChatService.adminTicketPayListCnt(cri));
		System.out.println(adminChatService.adminTicketPayListCnt(cri) + "가져오는 개수뭐니?!");
		
		model.addAttribute("pageMaker", pageMaker);
		
		
		return "adminChat/adminTicketPayList";
	}
	
	/**
	 * 관리자 페이지 - 이용권구매 내역
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "updTicketCntAjax.do")
	@ResponseBody
	public String updTicketCnt(HttpServletRequest request, Model model) throws Exception {
	   HttpSession session = request.getSession();
	   String memberId = (String) session.getAttribute("memberId");
	   System.out.println("memberId업데이트하게나와랏 " + memberId);
	   if (memberId == null) {
		   memberId = "";
	   }
	   
      String buyTicketSeq = request.getParameter("buyTicketSeq");
      String ticketCnt = request.getParameter("ticketCnt");
      String ticketAvailFlag = request.getParameter("ticketAvailFlag");
      System.out.println("buyTicketSeq가져오삼= " + buyTicketSeq);
      System.out.println("ticketCnt가져오삼= " + ticketCnt);
      System.out.println("ticketAvailFlag가져오삼= " + ticketAvailFlag);
      
      
      //관리자가 이용권개수 수정했을때 
      BuyTicketVO vo = new BuyTicketVO();
      vo.setMemberId(memberId);
      vo.setBuyTicketSeq(buyTicketSeq);
      vo.setTicketRemain(ticketCnt);
      
      //TicketRemain
      int ticketCnt2 =Integer.parseInt(ticketCnt);
      System.out.println("int로바꾼ticketCnt " + ticketCnt2);
      if(ticketCnt2 > 0) {
    	  ticketAvailFlag = "Y";
      }else if(ticketCnt2 <= 0) {
    	  ticketAvailFlag = "N";
      }else {
    	  ticketAvailFlag = ticketAvailFlag;
      }
      vo.setTicketAvailFlag(ticketAvailFlag);
      int cnt = adminChatService.updTicketCnt(vo);
      
      
	  System.out.println("여기2");
      String msg = "ng";
      
      if(cnt > 0) {
         msg = "ok";
      }
      System.out.println("얌마"+msg);
       return msg;
   }
	
	
	@RequestMapping(value = "adminChatStat.do", method = RequestMethod.GET)
	public String adminChatStat(Locale locale, Model model) throws Exception {

	   //채팅개수 최근 7일
	   Map<String,Object> sevenDays = adminChatService.ChatDays();
	   model.addAttribute("ChatDays", sevenDays);
		   
	   //채팅개수 최근 7일 (남자)
	   Map<String,Object> sevenDaysM = adminChatService.ChatDaysM();
	   model.addAttribute("ChatDaysM" , sevenDaysM);
		   
	   //채팅개수 최근 7일 (여자)
	   Map<String,Object> sevenDaysF = adminChatService.ChatDaysF();
	   model.addAttribute("ChatDaysF" , sevenDaysF);
		   
	   //채팅개수 최근 5주
	   Map<String,Object> fiveWeeks = adminChatService.chatWeeks();
	   model.addAttribute("chatWeeks" , fiveWeeks);
		   
	   //채팅개수 최근 5주 (남자)
	   Map<String,Object> fiveWeeksM = adminChatService.chatWeeksM();
	   model.addAttribute("chatWeeksM" , fiveWeeksM);
		   
	   //채팅개수 최근 5주 (여자)
	   Map<String,Object> fiveWeeksF = adminChatService.chatWeeksF();
	   model.addAttribute("chatWeeksF" , fiveWeeksF);
		   
	   //채팅건수 최근6개월 
//	   Map<String,Object> sixMonths = adminChatService.chatMonths();
//	   model.addAttribute("chatMonths" , sixMonths);
		   
	   //채팅건수 최근 6개월 (남자)
//	   Map<String,Object> sixMonthsM = adminChatService.chatMonthsM();
//	   model.addAttribute("chatMonthsM" , sixMonthsM);
		   
	   //채팅건수 최근 6개월(여자)
//	   Map<String,Object> sixMonthsF = adminChatService.chatMonthsF();
//	   model.addAttribute("chatMonthsF" , sixMonthsF);
	   
	   
		return "adminChat/adminChatStat";
	}
	
	@RequestMapping(value = "adminChatDetail.do", method = RequestMethod.GET)
	public String adminChatDetail(Locale locale, Model model) {

		return "adminChat/adminChatDetail";
	}
}