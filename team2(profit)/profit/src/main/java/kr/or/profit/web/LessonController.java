package kr.or.profit.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import javax.annotation.Resource;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.tiles.autotag.core.runtime.annotation.Parameter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.or.profit.service.AttachFileService;
import kr.or.profit.service.LessonService;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.BuyTicketVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonDetailVO;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.PageMaker;
import kr.or.profit.vo.ReplyVO;
import net.sf.json.JSONObject;

/**
 * 
 * Handles requests for the application home page.
 */
@Controller
public class LessonController {
   
   private static final Logger logger = LoggerFactory.getLogger(LessonController.class);
   private static final String CURR_IMAGE_REPO_PATH = 
            "\\\\192.168.41.6\\upload\\profit";
   @Resource(name="lessonService")
   private LessonService lessonService;
   
   @Resource(name = "fileService")
   private AttachFileService fileService;
   
   /**
    * 강의 목록 조회 -나중에 페이징처리하자민정아
    * @param locale
    * @param model
    * @return
    */
   @RequestMapping(value = "lessonList.do",  method = {RequestMethod.GET, RequestMethod.POST})
   public String lessonList(Locale locale, Model model, Criteria cri, HttpServletRequest request) throws Exception  {
	   
	   HttpSession session = request.getSession();
	   String memberId = (String) session.getAttribute("memberId");
	   System.out.println("memberId나와랏 " + memberId);
	   if (memberId == null) {
		   memberId = "";
	   }
	   
	   String selCate = request.getParameter("selCate");
	   String selLev = request.getParameter("selLev");
	   String keyword = request.getParameter("keyword");
	   
	  cri.setPerPageNum(9);
	  cri.setMemberId(memberId);
	  
      List<?> lessonList = lessonService.selectLessonList(cri);
      model.addAttribute("resultList", lessonList);
//      model.addAttribute("option", map);
      System.out.println("resultList새롬이 "+ model.toString());
      
    //입력한 검색어 유지시키기
	model.addAttribute("selCate", selCate);
	model.addAttribute("selLev", selLev);
	model.addAttribute("keyword", keyword);
      
   // 페이징처리
      PageMaker pageMaker = new PageMaker();
      pageMaker.setCri(cri);
      
   // 전체 글 개수 세팅 - 검색결과과 무관하게 페이징 생성 => 수정필요
   	  pageMaker.setTotalCount(lessonService.selectLessonCnt(cri)); 
      
   	  System.out.println(lessonService.selectLessonCnt(cri) + "가져오는 개수!!!!!!!!!!!!");
   	
   	  model.addAttribute("pageMaker", pageMaker);
   	  
   	  
      //트레이너인지 아닌지 여부
      int trainerFlag = lessonService.checkTrainer(memberId);
      if(trainerFlag > 0) {
    	  model.addAttribute("rightTrainer", "1");
      }else {
    	  model.addAttribute("rightTrainer", "0");
      }
      
      //인기강의top5
      List<?> lessonTopList = lessonService.selectTopLessonList(memberId);
      model.addAttribute("resultTopList", lessonTopList);
      System.out.println("dddddddddddd"+model);
      
      
      return "lesson/lessonList";
   }
   
   
   /**
    * 강의 상세 조회
    * @param lessonVO
    * @param locale
    * @param model
    * @return
    * @throws Exception
    */
   @RequestMapping(value = "lessonDetail.do",  method = {RequestMethod.GET, RequestMethod.POST})
   public String lessonDetail(@ModelAttribute("lessonVO") LessonVO lessonVO, AttachFileVO fileVO, Model model, HttpServletRequest request, Criteria cri) throws Exception  { 
      HttpSession session = request.getSession();
      String memberId = (String) session.getAttribute("memberId");
      System.out.println("민정이 "+memberId);
      
      lessonVO.setMemberId(memberId);
      Map<String, Object> lessonDetailList = lessonService.selectLessonDetail(lessonVO);
      String lessonSeq = request.getParameter("lessonSeq");
//      String lessonSeq = (String) lessonDetailList.get("lessonSeq");
      lessonDetailList.put("lessonSeq", lessonSeq);
      System.out.println("레슨시퀀은 뭐냐ㅕ "+lessonSeq);
      System.out.println("제발찍혀라" + model);
      
      cri.setMemberId(memberId);
      cri.setMemberId(lessonSeq);
      cri.setPerPageNum(5);
      
      List<?> classList = lessonService.selectClassList(cri);
      
      System.out.println(cri.getRowStart());
      System.out.println(cri.getRowEnd());
      
      List<?> trainerInfoList = lessonService.trainerInfo(lessonSeq);
      
      model.addAttribute("resultClassList", classList);
      model.addAttribute("trainerInfoList", trainerInfoList);
      System.out.println("디테일로 갈 파일 상세 리트스" + model.toString());
      
      //강좌 추천ai
      List<Map<String, Object>> recommandList =  lessonService.recommand(lessonSeq);
      model.addAttribute("recommandList", recommandList);
      System.out.println("추천강좌 " + model.toString());
      
      
    //페이징처리
      PageMaker pageMaker = new PageMaker();
      pageMaker.setCri(cri);
      
    //전체 글 개수 세팅
      pageMaker.setTotalCount(lessonService.selectClassCnt(cri));
      
      System.out.println("전체글개수-----------");
      
      model.addAttribute("pageMaker", pageMaker);
      
      //강의 구매한 사람있는지 확인
      Map<String, Object> buyMap = new HashMap<>();
      buyMap.put("memberId", memberId);
      buyMap.put("lessonSeq", lessonSeq);
      int buyLessonFlag = lessonService.selectBuyLesson(buyMap);
      if(buyLessonFlag > 0) {
    	  model.addAttribute("buyer", "1");
      }else {
    	  model.addAttribute("buyer", "0");
      }
      
    //조회수 증가
      lessonService.increaseLessonHit(lessonSeq);
      
	// 댓글 목록 가져오기
      List<Map<String, Object>> replyList = lessonService.selectReplyList(lessonSeq);
      System.out.println("replyList : "+replyList);
      lessonDetailList.put("replyList", replyList);
      model.addAttribute("resultList", lessonDetailList);
      System.out.println("resultList " + model.toString());
    
    //댓글 수 가져오기
	  Map<String,Object> replyCnt = lessonService.selectReplyCnt(lessonSeq);
	  model.addAttribute("replyCnt", replyCnt);
      System.out.println("댓글 수 가져오니 " + model.toString());
    //댓글 내 프로필 사진 이미지 정보
      String myprofile = lessonService.selectMyProfile(memberId);
      System.out.println("기본이미지 : " + myprofile);
      model.addAttribute("MyProfileImage", myprofile);
      
      return "lesson/lessonDetail";
   }
   
	/**
    * 자유게시판 댓글 등록
    * @author 정예진
    * @param HttpServletRequest,HttpServletResponse
    * @return String - msg
    * @throws Exception
    */
	@RequestMapping(value = "replyLessonAddAjax.do", method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String replyAddAjax(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		System.out.println("댓글쓴사람 "+memberId);
		System.out.println("오니?");
		
		String lessonSeq = request.getParameter("lessonSeq");
		System.out.println("lessonSeq여기서찍어라 " + lessonSeq);
		
		String replyContent = request.getParameter("replyContent");
		System.out.println("replyContent : " + replyContent);
		
		String secret = request.getParameter("secret");
		System.out.println("secret값 " + secret);
		
		if(("비밀댓글").equals(secret)) {
			secret = "Y";
		}else {
			secret = "N";
		}
		System.out.println("최종secret "+ secret);
		
		ReplyVO replyvo = new ReplyVO();
		replyvo.setLessonSeq(lessonSeq);
		replyvo.setReplyContent(replyContent);
		replyvo.setReplySecretFlag(secret);
		replyvo.setInUserId(memberId);
		replyvo.setUpUserId(memberId);
		
		int insertResult = lessonService.insertLessonReply(replyvo);
		

	    String msg="ng";
	    
		if(insertResult > 0) {
			msg = "ok";
		}
		return msg;
	}

		
	/**
	    * 자유게시판 답글 등록
	    * @author 정예진
	    * @param HttpServletRequest,HttpServletResponse
	    * @return String - msg
	    * @throws Exception
	    */
		@RequestMapping(value = "rereplyLessonAddAjax.do", method = {RequestMethod.GET,RequestMethod.POST})
		@ResponseBody
		public String rereplyAddAjax(HttpServletRequest request, HttpServletResponse response) throws Exception{
			HttpSession session = request.getSession();
			String memberId = (String) session.getAttribute("memberId");
			
			String lessonSeq = request.getParameter("lessonSeq");
			String replyContent = request.getParameter("replyContent");
			String replyParentSeq = request.getParameter("replyParentSeq");
			String reSecret = request.getParameter("reSecret");
			
			System.out.println("lessonSeq : " + lessonSeq);
			System.out.println("replyContent : " + replyContent);
			System.out.println("replyParentSeq : " + replyParentSeq);
			System.out.println("reSecret값2 " + reSecret);
			
			if(("비밀댓글").equals(reSecret)) {
				reSecret = "Y";
			}else {
				reSecret = "N";
			}
			System.out.println("최종secret2 "+ reSecret);
			
			
			ReplyVO replyvo = new ReplyVO();
			replyvo.setLessonSeq(lessonSeq);
			replyvo.setReplyContent(replyContent);
			replyvo.setReplyParentSeq(replyParentSeq);
			replyvo.setReplySecretFlag(reSecret);
			replyvo.setInUserId(memberId);
			replyvo.setUpUserId(memberId);

			int insertResult = lessonService.insertLessonRereply(replyvo);

		    String msg="ng";
		    
			if(insertResult > 0) {
				msg = "ok";
			}
			return msg;
		}
		
		/**
	    * 자유게시판 댓글 삭제
	    * @author 정예진
	    * @param HttpServletRequest,HttpServletResponse
	    * @return String - msg
	    * @throws Exception
	    */
		@RequestMapping(value = "replyLessonDelAjax.do", method = {RequestMethod.GET,RequestMethod.POST})
		@ResponseBody
		public String replyDelAjax(HttpServletRequest request, HttpServletResponse response) throws Exception{
			
			String replySeq = request.getParameter("replySeq");
			System.out.println("replySeq : " + replySeq);
			int deleteResult = lessonService.deleteLessonReply(replySeq);

			
			
		    String msg="ng";

		    if(deleteResult  > 0) {
				msg = "ok";
			}
			return msg;
		}
   
	/**
	 * 자유게시판 좋아요/북마크 제거
	 * 
	 * @author 길민선
	 * @param BookgoodVO
	 * @return String - community/boardAdd
	 * @throws Exception
	 */
	@RequestMapping(value = "removeLessonBookgoodAjax.do", produces = "application/text; charser=utf-8")
	public @ResponseBody String removeBookgood(BookgoodVO vo) throws Exception {

		int delCnt = lessonService.deleteLessonBookgood(vo);
		int cnt = lessonService.selectLessonBookgoodCnt(vo);
		String str_cnt = Integer.toString(cnt);

		String msg = "";

		if (delCnt > 0) {
			msg = str_cnt;
		} else {
			msg = "no";
		}

		return msg;
	}

	/**
	 * 자유게시판 좋아요/북마크 추가
	 * 
	 * @author 길민선
	 * @param BookgoodVO
	 * @return String - community/boardAdd
	 * @throws Exception
	 */
	@RequestMapping(value = "addLessonBookgoodAjax.do", produces = "application/text; charser=utf-8")
	public @ResponseBody String addBookgood(BookgoodVO vo) throws Exception {

		int insCnt = lessonService.insertLessonBookgood(vo);
		int cnt = lessonService.selectLessonBookgoodCnt(vo);
		String str_cnt = Integer.toString(cnt);

		String msg = "";

		if (insCnt > 0) {
			msg = str_cnt;
		} else {
			msg = "no";
		}

		return msg;
	}
	
		
		
   /**
    * 강의 등록
    * @param lessonVO - 등록할 정보가 담긴 VO
    * @param
    * @return
    * @throws Exception 
    */
   @RequestMapping(value = "lessonAdd.do", method = {RequestMethod.GET, RequestMethod.POST})
   public String lessonAdd(HttpServletRequest request, Model model) throws Exception {
	
      return "lesson/lessonAdd";
   }
   
   /**
    * 강의 등록하는 ajax 
    * @param multipartRequest
    * @param response
    * @param request
    * @return
    * @throws Exception
    */
   @RequestMapping(value = "lesson_insAjax.do", method = RequestMethod.POST)
   @ResponseBody
   public String lessonAdd(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, HttpServletRequest request) throws Exception{
      HttpSession session = request.getSession();      
      multipartRequest.setCharacterEncoding("utf-8");
      
      
    //파일업로드
      List<AttachFileVO> fileVOList = fileLesson(multipartRequest, request);
      
    //파일 DB 저장
      Map<String, Object> filemap = new HashMap<String, Object>();
      filemap.put("list", fileVOList);
      System.out.println("filemap이다 이놈아  "+filemap.toString());
      int insertResult = lessonService.insertLessonFile(filemap);
      
      
    //강의 정보 Table에 Insert
      String lessonCategorySeq = multipartRequest.getParameter("lessonCategorySeq");
      String lessonTitle = multipartRequest.getParameter("lessonTitle");
      String lessonTitleComment = multipartRequest.getParameter("lessonTitleComment");
      String lessonBalance = multipartRequest.getParameter("lessonBalance");
      String lessonFlex = multipartRequest.getParameter("lessonFlex");
      String lessonStrong = multipartRequest.getParameter("lessonStrong");
      String lessonCore = multipartRequest.getParameter("lessonCore");
      String lessonIntro = multipartRequest.getParameter("lessonIntro");
      String lessonPrice = multipartRequest.getParameter("lessonPrice");
      String lessonMonth = multipartRequest.getParameter("lessonMonth");
      
      LessonVO vo = new LessonVO();
      
      String loginMemberId = (String)session.getAttribute("memberId");
      String fileSeq = (String) filemap.get("fileSeq");
      vo.setFileSeq(fileSeq);
      vo.setLessonCategorySeq(lessonCategorySeq);
      vo.setLessonTitle(lessonTitle);
      vo.setLessonTitleComment(lessonTitleComment);
      vo.setLessonBalance(lessonBalance);
      vo.setLessonFlex(lessonFlex);
      vo.setLessonStrong(lessonStrong);
      vo.setLessonCore(lessonCore);
      vo.setLessonIntro(lessonIntro);
      vo.setLessonPrice(lessonPrice);
      vo.setLessonMonth(lessonMonth);
      vo.setInUserId(loginMemberId);
      vo.setUpUserId(loginMemberId);
      lessonService.insertLesson(vo);
      
      String msg = "ng";
      
      if(insertResult > 0) {
         msg = "ok";
      }
       return msg;
      
 
   }
   
   /**
    * 파일 업로드 메서드
    * @param multipartRequest
    * @param request
    * @return
    * @throws Exception
    */
   private List<AttachFileVO> fileLesson(MultipartHttpServletRequest multipartRequest, HttpServletRequest request) 
	        throws Exception{
	       HttpSession session = request.getSession();
	       
	       List<AttachFileVO> fileVOList = new ArrayList<AttachFileVO>();
	       
	       Iterator<String> fileNames = multipartRequest.getFileNames();
	       System.out.println("fileNames 뭐냐 " + fileNames);
	       int cnt = 1;
	       while(fileNames.hasNext()) {
	           
	           
	           UUID uuid = UUID.randomUUID();
	           
	           System.out.println("uuid : " + uuid);
	            String fileName = fileNames.next();
	            System.out.println("fileName : " + fileName);
	            MultipartFile mFile = multipartRequest.getFile(fileName);
	            String originalFileName = mFile.getOriginalFilename();
	            System.out.println("originalFileName"+originalFileName);
	            File file = new File(CURR_IMAGE_REPO_PATH + "\\" + uuid.toString() + "_" + originalFileName);
	            if(mFile.getSize() != 0) {
	                if(!file.exists()) {
	                    if(file.getParentFile().mkdir()) {
	                        file.createNewFile();
	                    }
	                }
	                
	                mFile.transferTo(new File(CURR_IMAGE_REPO_PATH + "\\" + uuid.toString()  + "_" + originalFileName));
	            }
	            
	            String memberId = (String)session.getAttribute("memberId");
	            System.out.println("세션에 있니??  " + memberId);
	            
	            AttachFileVO attachvo = new AttachFileVO();
	            attachvo.setFileDetailSeq(Integer.toString(cnt));
	            attachvo.setFileRealName(originalFileName);
	            attachvo.setFileSaveName(uuid.toString()  + "_" + originalFileName);
	            attachvo.setFilePath("http://192.168.41.6:9999/upload/profit/" + uuid.toString()  + "_" + originalFileName);
	            attachvo.setInUserId(memberId);
	            attachvo.setUpUserId(memberId);
	            fileVOList.add(attachvo);
	            cnt++;
	          }
	        System.out.println("insert 할 것");
	        System.out.println("처음fileVOList "+ fileVOList);
	        return fileVOList;
	    }
   
   
   
   
   
   /**
    * 강의를 수정한다 
    * @param locale
    * @param model
    * @return
    */
   @RequestMapping(value = "lessonMod.do")
   public String lessonMod(@ModelAttribute("lessonVO") LessonVO lessonVO, AttachFileVO fileVO, Model model) throws Exception  {
      Map<String, Object> lessonDetailList = lessonService.selectLessonDetail(lessonVO);
      model.addAttribute("resultList", lessonDetailList);
      System.out.println("수정으로 간다" + model);
      return "lesson/lessonMod";
   }
   
   /**
    * 강의 수정 -파일수정 강의 수정
    * @param multipartRequest
    * @param response
    * @param request
    * @return
    * @throws Exception
    */
   @RequestMapping(value = "lesson_modAjax.do", method = RequestMethod.POST)
   @ResponseBody
   public String lessonModFinish(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, HttpServletRequest request) throws Exception{
	    HttpSession session = request.getSession();      
	    multipartRequest.setCharacterEncoding("utf-8");
	      
	      
	    //파일업로드
	    List<AttachFileVO> fileVOList = fileLesson(multipartRequest, request);
	      
	    //파일 DB 저장
	    Map<String, Object> filemap = new HashMap<String, Object>();
	    filemap.put("list", fileVOList);
	    System.out.println("filemap이다 이놈아22  "+filemap.toString());
	    int insertResult = lessonService.insertLessonFile(filemap);
	    
	  //강의 정보 Table에 update
	  String lessonSeq = multipartRequest.getParameter("lessonSeq");
      String lessonCategorySeq = multipartRequest.getParameter("lessonCategorySeq");
      String lessonTitle = multipartRequest.getParameter("lessonTitle");
      String lessonTitleComment = multipartRequest.getParameter("lessonTitleComment");
      String lessonBalance = multipartRequest.getParameter("lessonBalance");
      String lessonFlex = multipartRequest.getParameter("lessonFlex");
      String lessonStrong = multipartRequest.getParameter("lessonStrong");
      String lessonCore = multipartRequest.getParameter("lessonCore");
      String lessonIntro = multipartRequest.getParameter("lessonIntro");
      String lessonPrice = multipartRequest.getParameter("lessonPrice");
      String lessonMonth = multipartRequest.getParameter("lessonMonth");
	    
      System.out.println("강의 seq 는 무엇? "+ lessonSeq);
      System.out.println("카테고리는 무엇? "+lessonCategorySeq);
      System.out.println("제목 무엇? "+lessonTitle);
      System.out.println("코멘트는 무엇? "+lessonTitleComment);
      System.out.println("밸런스 무엇? "+lessonBalance);
      System.out.println("유연 무엇? "+lessonFlex);
      System.out.println("스트롱는 무엇? "+lessonStrong);
      System.out.println("코어 무엇? "+lessonCore);
      System.out.println("스트롱는 무엇? "+lessonStrong);
      System.out.println("인트로 무엇? "+lessonIntro);
      System.out.println("가격 무엇? "+lessonPrice);
      System.out.println("기간 무엇? "+lessonMonth);
       
      LessonVO vo = new LessonVO();
      String loginMemberId = (String)session.getAttribute("memberId");
      String fileSeq = (String) filemap.get("fileSeq");	//14
      System.out.println("여기 fileSeq는 뭐니 " + fileSeq);
      vo.setFileSeq(fileSeq);
      vo.setLessonSeq(lessonSeq);
      vo.setLessonCategorySeq(lessonCategorySeq);
      vo.setLessonTitle(lessonTitle);
      vo.setLessonTitleComment(lessonTitleComment);
      vo.setLessonBalance(lessonBalance);
      vo.setLessonFlex(lessonFlex);
      vo.setLessonStrong(lessonStrong);
      vo.setLessonCore(lessonCore);
      vo.setLessonIntro(lessonIntro);
      vo.setLessonPrice(lessonPrice);
      vo.setLessonMonth(lessonMonth);
      vo.setUpUserId(loginMemberId);
      lessonService.updateLesson(vo);
      
      String msg = "ng";
      
      if(insertResult > 0) {
         msg = "ok";
      }
       return msg;
	   
   }
   
   
   /**
    * 강의 삭제
 * @throws Exception 
    */
   @RequestMapping(value = "lesson_delAjax.do", method = RequestMethod.GET)
   @ResponseBody
   public String lessonDel(LessonVO lessonVO, Locale locale, Model model) throws Exception {
      String lessonSeq = lessonVO.getLessonSeq();
      System.out.println("lessonSeq?= " + lessonSeq);
      lessonVO.setLessonSeq(lessonSeq);
	  int cnt = lessonService.deleteLesson(lessonVO);
      String msg = "ng";
      
      if(cnt > 0) {
         msg = "ok";
      }
      System.out.println(msg);
       return msg;
   }
   
	/**
	 * 강의 결제
	 * @param locale
	 * @param model
	 * @return
	 */
   @RequestMapping(value = "buyLesson.do", method = RequestMethod.GET)
   public String buyLesson(@ModelAttribute("lessonVO") LessonVO lessonVO, AttachFileVO fileVO, Model model, HttpServletRequest request) throws Exception  { 
	  HttpSession session = request.getSession();
	  String memberId = (String) session.getAttribute("memberId");
	  lessonVO.setMemberId(memberId); 

	  Map<String, Object> lessonDetailList = lessonService.selectLessonDetail(lessonVO);
	  model.addAttribute("result", lessonDetailList);
	  System.out.println("강의구매리스트 "+lessonDetailList);
      
	  
	  return "lesson/buyLesson";
   }
 
   
   @RequestMapping(value = "buyLessonAddAjax.do", method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String buyLessonAddAjax(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		String lessonTitle = request.getParameter("lessonTitle");
		String lessonPrice = request.getParameter("lessonPrice");
		String lessonSeq = request.getParameter("lessonSeq");
		String lessonMonth = request.getParameter("lessonMonth");
		int month = Integer.parseInt(lessonMonth);
		System.out.println("string을int로 "+ month);
		
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY/MM/dd");
		//오늘 날짜를 기준으루..
		Calendar cal = Calendar.getInstance ( );
		System.out.println("cals는? "+cal);
		//lessonMonth개월 후의 날
		cal.add ( Calendar.MONTH, month);
		String date = sdf.format(cal.getTime());
		System.out.println(sdf.format(cal.getTime()));
		
//		String final_year = sdf.format(cal.get ( cal.YEAR ));
//		String final_month = sdf.format(cal.get ( cal.MONTH ) + 1);
//		String final_date = sdf.format(cal.get ( cal.DATE ));

//		System.out.println ( final_year );
//		System.out.println ( final_month );
//		System.out.println ( final_date );
		
//		String fYear = Integer.toString(final_year);
//		String fMonth = Integer.toString(final_month);
//		String fDate = Integer.toString(final_date);
		
//		String date = final_month;
				
		System.out.println("lessonTitle : " + lessonTitle);
		System.out.println("lessonPrice : " + lessonPrice );
		System.out.println("lessonSeq : " + lessonSeq );
		System.out.println("lessonMonth : " + lessonMonth );
		System.out.println("최종날짜는? " + date);
		
		BuyLessonVO buyLessonVO = new BuyLessonVO();
		buyLessonVO.setLessonSeq(lessonSeq);
		buyLessonVO.setLessonFinishDate(date);
		buyLessonVO.setInUserId(memberId);
		buyLessonVO.setUpUserId(memberId);
		
		int insertResult = lessonService.insertBuyLesson(buyLessonVO);

	    String msg="ng";
	    
		if(insertResult > 0) {
			msg = "ok";
		}
		
		return msg;
	}
   
   
   /**
    * 상세 강의 등록
    * @param locale
    * @param model
    * @return
    */
   @RequestMapping(value = "classAdd.do", method = {RequestMethod.GET, RequestMethod.POST})
   public String classAdd(@ModelAttribute("lessonVO") LessonVO lessonVO, AttachFileVO fileVO, Model model, HttpServletRequest request) throws Exception  {
	   HttpSession session = request.getSession();
	   String memberId = (String) session.getAttribute("memberId");
	   System.out.println("강의 추가하는 사람"+memberId);
	   
	   lessonVO.setMemberId(memberId);
	   Map<String, Object> lessonDetailList = lessonService.selectLessonDetail(lessonVO);
	   model.addAttribute("resultList", lessonDetailList);
	      System.out.println("디테일에서 seq가져오는" + model);
      return "lesson/classAdd";
   }
   
   @RequestMapping(value = "class_insAjax.do", method = RequestMethod.POST)
   @ResponseBody
   public String classAdd(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, HttpServletRequest request) throws Exception{
      HttpSession session = request.getSession();      
      multipartRequest.setCharacterEncoding("utf-8");
   
      //파일업로드
        List<AttachFileVO> fileVOList = fileLesson(multipartRequest, request);
        System.out.println("fileVOList 는 뭐야?? "+fileVOList);
        
      //파일 DB 저장
        Map<String, Object> filemap = new HashMap<String, Object>();
        filemap.put("list", fileVOList);
        System.out.println("filemap인데 파일이랑 영상이야  "+filemap);
        int cnt = lessonService.insertClassFile(filemap);
        System.out.println("cnt" + cnt);
        
      //상세 강의 Table(LESSON_DETAIL)에 Insert
        String lessonSeq = multipartRequest.getParameter("lessonSeq");
        String lessonDetailTitle = multipartRequest.getParameter("lessonDetailTitle");
        String lessonDetailContent = multipartRequest.getParameter("lessonDetailContent");

        LessonDetailVO vo = new LessonDetailVO();
        
        String loginMemberId = (String)session.getAttribute("memberId");
        String fileSeq = (String) filemap.get("fileSeq");
        vo.setFileSeq(fileSeq);
        vo.setLessonSeq(lessonSeq);
        vo.setLessonDetailTitle(lessonDetailTitle);
        vo.setLessonDetailContent(lessonDetailContent);
        vo.setInUserId(loginMemberId);
        vo.setUpUserId(loginMemberId);
        int cnt2 = lessonService.insertClass(vo);
        
        System.out.println("상세 파일 시퀀 " +fileSeq);
        System.out.println("상세 레슨 시퀀 " +lessonSeq);
        System.out.println("상세 타이틀 " +lessonDetailTitle);
        System.out.println("상세 내용 " +lessonDetailContent);
        
        
        String msg = "ng";
        
        if(cnt > 0 && cnt2>0) {
           msg = "ok";
        }
         return msg;
        
   
   }	   
	   
   /**
    * 상세 강의 디테일 
    * @param locale
    * @param model
    * @return
    */
   @RequestMapping(value = "classDetail.do", method = RequestMethod.GET)
   public String classDetail(@ModelAttribute("lDetailVO") LessonDetailVO lDetailVO, LessonVO lessonVO, AttachFileVO fileVO, Model model, HttpServletRequest request) throws Exception  {

	   HttpSession session = request.getSession();
	   String memberId = (String) session.getAttribute("memberId");
	   System.out.println("상세강의로갈memberId " + memberId);
	   if (memberId == null) {
		   memberId = "";
	   }
	   
	   //트레이너인지 아닌지 여부
	      int trainerFlag = lessonService.checkTrainer(memberId);
	      if(trainerFlag > 0) {
	    	  model.addAttribute("rightTrainer", "1");
	      }else {
	    	  model.addAttribute("rightTrainer", "0");
	      }
	   //상세강의 상세보기
	   Map<String, Object> classDetailList = lessonService.selectclassDetail(lDetailVO);
	   model.addAttribute("classResult", classDetailList);
	   System.out.println("뭐 들어있는지볼까 "+model);
	   
	   return "lesson/classDetail";
   }
	   
   
   @RequestMapping(value = "classMod.do", method = RequestMethod.GET)
   public String classMod(Locale locale, Model model) {
      
      return "lesson/classMod";
   }

   @RequestMapping(value = "test", method = RequestMethod.GET)
   public String test(Locale locale, Model model) {
      
      return "lesson/test";
   }
   
   
	   
   /**
    * 상세 강의 삭제
    * @throws Exception 
    */
   @RequestMapping(value = "class_delAjax.do")
   @ResponseBody
   public String classDel(LessonDetailVO lDetailVO, LessonVO lessonVO, Locale locale, Model model) throws Exception {
      String lessonDetailSeq = lDetailVO.getLessonDetailSeq();
      System.out.println("lessonDetailSeq?= " + lessonDetailSeq);
      lDetailVO.setLessonDetailSeq(lessonDetailSeq);
	  int cnt = lessonService.deleteClass(lDetailVO);
      String msg = "ng";
      
      if(cnt > 0) {
         msg = "ok";
      }
      System.out.println(msg);
       return msg;
   }
   
	   
   /**
    * 강의 수강선택하면 구매테이블update
    * @throws Exception 
    */
   @RequestMapping(value = "updBuyLessonAjax.do")
   @ResponseBody
   public String updBuyLesson(HttpServletRequest request, Model model) throws Exception {
	   HttpSession session = request.getSession();
	   String memberId = (String) session.getAttribute("memberId");
	   System.out.println("memberId업데이트하게나와랏 " + memberId);
	   if (memberId == null) {
		   memberId = "";
	   }
	   
      String lessonSeq = request.getParameter("lessonSeq");
      System.out.println("lessonSeq가져오삼= " + lessonSeq);
      
      BuyLessonVO vo = new BuyLessonVO();
      vo.setMemberId(memberId);
      vo.setLessonSeq(lessonSeq);
      System.out.println("여기1");
      
	  int cnt = lessonService.updBuyLesson(vo);
	  System.out.println("여기2");
      String msg = "ng";
      
      if(cnt > 0) {
         msg = "ok";
      }
      System.out.println("얌마"+msg);
       return msg;
   }
   
   

   
}
