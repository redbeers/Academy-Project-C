package kr.or.profit.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.or.profit.service.MemberService;
import kr.or.profit.service.MypageService;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.BuyLessonPayVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.PageMaker;
import kr.or.profit.vo.ProcessVO;

/**
 * 
 * Handles requests for the application home page.
 */
@Controller
public class MypageController {
	@Resource(name = "mypageService")
	private MypageService mypageService;

	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	private static final String CURR_IMAGE_REPO_PATH = "\\\\192.168.41.6\\upload\\profit";

	//1. 내정보
	@RequestMapping(value = "myinfo.do", method = RequestMethod.GET)
	public String myinfo(HttpSession session, Model model) throws Exception {

		String memberId = (String) session.getAttribute("memberId");
		MemberVO vo = mypageService.selectAllMemberInfo(memberId);
		System.out.println("ddddd"+vo.getMemberGender());
		model.addAttribute("myInfo", vo);
		System.out.println(vo.getMemberMobile());
		System.out.println(vo.getMemberWeight());
		System.out.println(vo.getMemberHeight());
		
		return "mypage/myinfo";
	}
	
	@RequestMapping(value = "pwdMod.do", method = RequestMethod.GET)
	public String pwdMod(Locale locale, Model model) {

		return "mypage/pwdMod";
	}

	@RequestMapping(value = "mobileMod.do", method = RequestMethod.GET)
	public String mobileMod(Locale locale, Model model) {

		return "mypage/mobileMod";
	}
	
	
	
	//2. 북마크 리스트
	@RequestMapping(value = "bookmark.do", method = RequestMethod.GET)
	public String bookmark(HttpServletRequest request, Model model, Criteria cri,
			@RequestParam(value = "commonSeq", required = false) String commonSeq
			) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		commonSeq = request.getParameter("commonSeq");
		
		cri.setMemberId(memberId);
		cri.setCommonSeq(commonSeq);
		cri.setPerPageNum(6);
		
		List<Map<String, String>> list = mypageService.selectBookmarkList(cri);
		
		System.out.println(cri.getRowStart());
		System.out.println(cri.getRowEnd());
		
		
		System.out.println(list.toString());
		model.addAttribute("list", list);
		model.addAttribute("commonSeq", commonSeq);
		
		//페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//전체 글 개수 세팅
		pageMaker.setTotalCount(mypageService.selectBookmarkCnt(cri));
		
		System.out.println("전체글개수-----------");
		
		model.addAttribute("pageMaker", pageMaker);
		
		
		return "mypage/bookmark";
	}

	
	//3.마이클래스
	@RequestMapping(value = "myLessonList.do", method = RequestMethod.GET)
	public String myLessonList(Locale locale, Model model, HttpServletRequest request,  Criteria cri) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		System.out.println("buy파람id : " + memberId);
		if (memberId == null) {
			memberId = "";
		}
		
		
		cri.setMemberId(memberId);
		cri.setPerPageNum(10);
		
		List<?> myBuyLessonList = mypageService.myBuyLessonList(cri);
		System.out.println(cri.getRowStart());
		System.out.println(cri.getRowEnd());
		model.addAttribute("buyListResult", myBuyLessonList);
		System.out.println("가랏 "+ model.toString());
		
	     
	     System.out.println("가랏2222 "+ model.toString());
		//페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//전체 글 개수 세팅
		pageMaker.setTotalCount(mypageService.selectbuyLessonCnt(cri));
		
		System.out.println("전체글개수-----------" + mypageService.selectbuyLessonCnt(cri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "mypage/myLessonList";
	}
	
	
	//3-1.마이클래스에서 상세결제내역
	@RequestMapping(value = "myLessonPayDetail.do", method = RequestMethod.GET)
	public String myLessonPayDetail(Locale locale, Model model,  HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		System.out.println("결제상세id " + memberId);
		
		String lessonSeq = request.getParameter("lessonSeq");
		System.out.println("제발시퀀와라 "+ lessonSeq);
		
		String buyLessonSeq =  request.getParameter("buyLessonSeq");
		System.out.println("결제로보낼buyLessonSeq " + buyLessonSeq);
		
		BuyLessonPayVO vo = new BuyLessonPayVO();
		vo.setMemberId(memberId);
		vo.setLessonSeq(lessonSeq);
		vo.setBuyLessonSeq(buyLessonSeq);
		
		//마이페이지 결제상세내역 
		Map<String, Object> payDetailList = mypageService.selectMyLessonPayDetail(vo);
		model.addAttribute("payDetailList", payDetailList);
		System.out.println("결제상세model "+model);
		return "mypage/myLessonPayDetail";
	}
	
	
	
	//4. 1:1상담내역
	@RequestMapping(value = "myChatList.do", method = RequestMethod.GET)
	public String myChatList(Locale locale, Model model) {

		return "mypage/myChatList";
	}
	
	//4-1. 1:1상담내역 디테일
	@RequestMapping(value = "myChatDetail.do", method = RequestMethod.GET)
	public String myChatDetail(Locale locale, Model model) {

		return "mypage/myChatDetail";
	}
	
	
	
	///////////////////////////////////////
	
	//이용권 구매내역
	@RequestMapping(value = "ticketBuyList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String ticketBuyList(Model model, HttpServletRequest request, Criteria cri,
			@RequestParam(value = "selDate", required = false) String selDate,
			@RequestParam(value = "selTicketName", required = false) String selTicketName) throws Exception{
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		
		System.out.println(selTicketName);
		
		cri.setPerPageNum(10);
		cri.setMemberId(memberId);
		cri.setSelDate(selDate);
		cri.setSelTicketName(selTicketName);
		
		//이용권 구매목록
		List<Map<String, Object>> buyTicketList = mypageService.selectBuyTicketList(cri);
		model.addAttribute("buyTicketList", buyTicketList);
		System.out.println(model.toString());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//전체 글 개수 세팅
		pageMaker.setTotalCount(mypageService.selectBuyTicketCnt(cri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("selDate", selDate);
		model.addAttribute("selTicketName", selTicketName);
		
		return "mypage/ticketBuyList";
	}

	@RequestMapping(value = "ticketBuyDetail.do", method = RequestMethod.GET)
	public String ticketBuyDetail(Locale locale, Model model) {

		return "mypage/ticketBuyDetail";
	}
	
	
	
	//////////////////////////////////////////
	
	//나의 신청내역
	@RequestMapping(value = "trainerApplyList.do", method = RequestMethod.GET)
	public String trainerApplyList(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		ProcessVO vo = mypageService.selectProcessInfo(memberId);
		
		if(vo == null) {
			model.addAttribute("msg", "no");
		}else {
			model.addAttribute("msg", "yes");
			model.addAttribute("vo", vo);
			String fileSeq = vo.getFileSeq();
			List<?> fileVO = mypageService.selectFileInfo(fileSeq);
			model.addAttribute("fileVO", fileVO);
		}
		return "mypage/trainerApplyList";
	}
	
	
	
	//신청하기
	@RequestMapping(value = "trainerApply.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String trainerApply(HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		String page = "";
		
		request.setCharacterEncoding("utf-8");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter(); 
		
		//신청상태가 A거나 B거나 C거나 E면 페이지 못 들어가게 막기
		int cnt = mypageService.checkApplyPage(memberId);
		
		if(cnt != 0) {
			out.println("<script>alert('신청내역이 존재합니다. 신청내역을 확인해주세요'); location.href=' trainerApplyList.do';</script>"); 
			out.flush();
			
		}else {
			System.out.println("memberId : " + memberId);
			List<Map<String, String>> list = mypageService.selectMemberInfo(memberId);
			System.out.println(list.toString());
			String memberName = list.get(0).get("memberName");
			String memberGender = list.get(0).get("memberGender");
			String memberMobile = list.get(0).get("memberMobile");

			model.addAttribute("memberName", memberName);
			model.addAttribute("memberGender", memberGender);
			model.addAttribute("memberMobile", memberMobile);
			
			page = "mypage/trainerApply";
		}

		return page;

	}

	
	
	/////////////////////////////////////////////
	
	//민선 내정보 수정
	@RequestMapping(value = "updateMyInfoAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public String uploadProfileImg(MultipartHttpServletRequest multipartRequest, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		multipartRequest.setCharacterEncoding("utf-8");
		
		Iterator<String> fileNames = multipartRequest.getFileNames();
		String fileName = fileNames.next();
		System.out.println("fileName : " + fileName);
		MultipartFile mFile = multipartRequest.getFile(fileName);
		
		
		String originalFileName = mFile.getOriginalFilename();
		String msg = "";
		System.out.println("originalFileName : "+originalFileName);
		
		if(originalFileName == "") {
			System.out.println("제발제발22222");
			String memberName = multipartRequest.getParameter("memberName");
			String memberNickname = multipartRequest.getParameter("memberNickname");
			String memberMobile = multipartRequest.getParameter("memberMobile");
			String memberGender = multipartRequest.getParameter("memberGender");
			String memberHeight = multipartRequest.getParameter("memberHeight");
			String memberWeight = multipartRequest.getParameter("memberWeight");
			System.out.println("----------------------------------");
			System.out.println(memberName);
			System.out.println(memberNickname);
			System.out.println(memberMobile);
			System.out.println(memberGender);
			System.out.println(memberHeight);
			System.out.println(memberWeight);
			
			System.out.println("프로필 사진 없을때 들어올곳");
			
			MemberVO vo = new MemberVO();
			String memberId = (String) session.getAttribute("memberId");
			vo.setMemberId(memberId);
			vo.setMemberName(memberName);
			vo.setMemberNickname(memberNickname);
			vo.setMemberMobile(memberMobile);
			vo.setMemberGender(memberGender);
			vo.setMemberHeight(memberHeight);
			vo.setMemberWeight(memberWeight);
			
			//update
			int cnt = mypageService.updateOnlyInfo(vo);
			
			System.out.println("여기로 들어왔따!!!!");
			System.out.println(cnt);
			
			
			msg = "ok";
			
			
		}else {
		
		System.out.println("여기로 안와야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

		// 파일업로드
		List<AttachFileVO> fileVOList = fileProcess(multipartRequest, request);
		
		// 파일 DB 저장
		Map<String, Object> filemap = new HashMap<String, Object>();
		filemap.put("list", fileVOList);
		int insertResult = mypageService.insertProcessFile(filemap);
		
		System.out.println("int" + insertResult);
		
		//실제 member테이블 update
		String memberName = multipartRequest.getParameter("memberName");
		String memberNickname = multipartRequest.getParameter("memberNickname");
		String memberMobile = multipartRequest.getParameter("memberMobile");
		String memberGender = multipartRequest.getParameter("memberGender");
		String memberHeight = multipartRequest.getParameter("memberHeight");
		String memberWeight = multipartRequest.getParameter("memberWeight");
		
		System.out.println("----------------------------------");
		System.out.println(memberName);
		System.out.println(memberNickname);
		System.out.println(memberMobile);
		System.out.println(memberGender);
		System.out.println(memberHeight);
		System.out.println(memberWeight);
		
		
		MemberVO vo = new MemberVO();

		String memberId = (String) session.getAttribute("memberId");
		vo.setMemberId(memberId);
		vo.setMemberName(memberName);
		vo.setMemberNickname(memberNickname);
		vo.setMemberMobile(memberMobile);
		vo.setMemberGender(memberGender);
		vo.setMemberHeight(memberHeight);
		vo.setMemberWeight(memberWeight);
		
		mypageService.updateMemberInfo(vo);
		
		msg = "ok";
		}

		System.out.println("여기는 와야함!!!!!!!!!!!!!!!!!!!!!!!!!");
//		if (cnt > 0) {
//			msg = "ok";
//		}
		return msg;
		
	}
	
	
	//예진 - 파일 업로드!
	@RequestMapping(value = "uploadAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public String upload(MultipartHttpServletRequest multipartRequest, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		multipartRequest.setCharacterEncoding("utf-8");

		// 파일업로드
		List<AttachFileVO> fileVOList = fileProcess(multipartRequest, request);
		
		// 파일 DB 저장
		Map<String, Object> filemap = new HashMap<String, Object>();
		filemap.put("list", fileVOList);
		int insertResult = mypageService.insertProcessFile(filemap);

		// 회원 정보 Process Table에 Insert
		String trainerAward = multipartRequest.getParameter("trainerAward");
		String trainerCareer = multipartRequest.getParameter("trainerCareer");
		String trainerGym = multipartRequest.getParameter("trainerGym");

		ProcessVO vo = new ProcessVO();

		String loginMemberId = (String) session.getAttribute("memberId");
		vo.setMemberId(loginMemberId);
		vo.setTrainerAward(trainerAward);
		vo.setTrainerCareer(trainerCareer);
		vo.setTrainerGym(trainerGym);
		vo.setInUserId(loginMemberId);
		vo.setUpUserId(loginMemberId);
		mypageService.insertProcess(vo);

		String msg = "ng";

		if (insertResult > 0) {
			msg = "ok";
		}
		return msg;

	}

	//uploadAjax 안에서 사용하는 메서드
	public List<AttachFileVO> fileProcess(MultipartHttpServletRequest multipartRequest, HttpServletRequest request)
			throws Exception {
		HttpSession session = request.getSession();

		List<AttachFileVO> fileVOList = new ArrayList<AttachFileVO>();
//        List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		int cnt = 1;
		while (fileNames.hasNext()) {

			UUID uuid = UUID.randomUUID();

			System.out.println("uuid : " + uuid);
			String fileName = fileNames.next();
			System.out.println("fileName : " + fileName);
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			//??
			File file = new File(CURR_IMAGE_REPO_PATH + "\\" + uuid.toString() + "_" + originalFileName);
			if (mFile.getSize() != 0) {
				if (!file.exists()) {
					if (file.getParentFile().mkdir()) {
						file.createNewFile();
					}
				}

				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH + "\\" + uuid.toString() + "_" + originalFileName));
			}

			String memberId = (String) session.getAttribute("memberId");
			// attach_file 테이블에 저장할 vo list
			AttachFileVO attachvo = new AttachFileVO();
			attachvo.setFileDetailSeq(Integer.toString(cnt));
			attachvo.setFileRealName(originalFileName);
			//여기가 str_filename
			attachvo.setFileSaveName(uuid.toString() + "_" + originalFileName);
			
			attachvo.setFilePath("http://192.168.41.6:9999/upload/profit/" + uuid.toString() + "_" + originalFileName);
			
			attachvo.setInUserId(memberId);
			attachvo.setUpUserId(memberId);
			fileVOList.add(attachvo);
			cnt++;
		}
		System.out.println("insert 할 것");
		System.out.println(fileVOList.get(0).getFileDetailSeq());
		System.out.println(fileVOList.get(0).getFilePath());
		System.out.println(fileVOList.get(0).getFileRealName());
		System.out.println(fileVOList.get(0).getFileSaveName());
		System.out.println(fileVOList.get(0).getFileSeq());
		System.out.println(fileVOList.get(0).getInUserId());
		
		return fileVOList;
	}

	
		//민정
		//환불가능여부 확인
		@RequestMapping(value = "checkRefundAjax.do", method = RequestMethod.POST)
		@ResponseBody
		public String checkRefund(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
		   
			HttpSession session = request.getSession();
			String memberId = (String) session.getAttribute("memberId");
			System.out.println("환불확인Id " + memberId);
			
			String buyLessonSeq = request.getParameter("buyLessonSeq");
			System.out.println("환불확인seq "+ buyLessonSeq);
			
			String lessonSeq = request.getParameter("lessonSeq");
			System.out.println("환불확인seq2 " + lessonSeq);
			
			 //환불 할 수 있는 사람인지 확인
		      Map<String, Object> refundMap = new HashMap<>();
		      refundMap.put("memberId", memberId);
		      refundMap.put("lessonSeq", lessonSeq);
		      refundMap.put("buyLessonSeq", buyLessonSeq);
		      int checkRefundFlag = mypageService.selectcheckRefundFlag(refundMap);
		      
		      String msg="";
		      if(checkRefundFlag > 0) {
		    	  model.addAttribute("refundOk", "1");
		    	   msg="ok"; 
		    	   Map<String, Object> refundFlagMap = new HashMap<>();
		    	   refundFlagMap.put("memberId", memberId);
		    	   refundFlagMap.put("lessonSeq", lessonSeq);
		    	   refundFlagMap.put("buyLessonSeq", buyLessonSeq);
		    	   int refundFlag = mypageService.updBuyLessonRefundFlag(refundFlagMap);
		    	   System.out.println("refundFlag" + refundFlag);
		    	   
		      }else {
		    	  model.addAttribute("refundOk", "0");
		    	   msg="no";
		      }
		      System.out.println("환불모델 " + model.toString());
			return msg;
		}
	
		//이용권 구매내역
		@RequestMapping(value = "ticketUseList.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String ticketUseList(Model model, HttpServletRequest request, Criteria cri,
				@RequestParam(value = "selDate", required = false) String selDate,
				@RequestParam(value = "keyword", required = false) String keyword) throws Exception{
			HttpSession session = request.getSession();
			String memberId = (String) session.getAttribute("memberId");
			if (memberId == null) {
				memberId = "";
			}
			
			
			cri.setPerPageNum(10);
			cri.setMemberId(memberId);
			cri.setSelDate(selDate);
			cri.setKeyword(keyword);
			
			//이용권 사용목록
			List<Map<String, Object>> useTicketList = mypageService.selectUseTicketList(cri);
			model.addAttribute("useTicketList", useTicketList);
			System.out.println(model.toString());
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			//전체 글 개수 세팅
			pageMaker.setTotalCount(mypageService.selectUseTicketCnt(cri));
			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("selDate", selDate);
			model.addAttribute("keyword", keyword);
			
			return "mypage/ticketUseList";
		}
		
		@RequestMapping(value = "myChattingDetail.do", method = RequestMethod.GET)
		public String myChattingDetail(Locale locale, Model model) {

			return "mypage/myChattingDetail";
		}
}