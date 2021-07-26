package kr.or.profit.web;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.stringtemplate.v4.compiler.CodeGenerator.list_return;

//import com.itextpdf.text.Document;
//import com.itextpdf.text.PageSize;
//import com.itextpdf.text.pdf.PdfWriter;
//import com.itextpdf.tool.xml.XMLWorker;
//import com.itextpdf.tool.xml.XMLWorkerFontProvider;
//import com.itextpdf.tool.xml.XMLWorkerHelper;
//import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
//import com.itextpdf.tool.xml.html.CssAppliersImpl;
//import com.itextpdf.tool.xml.html.Tags;
//import com.itextpdf.tool.xml.parser.XMLParser;
//import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
//import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
//import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
//import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

import kr.or.profit.service.TrainerPageService;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.PageMaker;
import kr.or.profit.vo.ProcessVO;
import net.sf.json.JSONObject;

@Controller
public class TrainerController {
	@Resource(name = "trainerPageService")
	private TrainerPageService trainerPageService;
	
	
	
	@RequestMapping(value = "chatAccountInfo.do", method = RequestMethod.GET)
	public String chatAccountInfo(HttpServletRequest request, Model model, Criteria cri,
			@RequestParam(value = "selDate", required = false) String selDate) throws Exception{
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		
		cri.setMemberId(memberId);
		cri.setSelDate(selDate);
		cri.setPerPageNum(10);
		
		List<Map<String,Object>> chatAccountList = trainerPageService.selectChatAccountList(cri);
		model.addAttribute("chatAccountList", chatAccountList);
		// 페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		//전체 글 개수 세팅
		int total = trainerPageService.selectChatCnt(cri);
		pageMaker.setTotalCount(total);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("selDate", selDate);
		model.addAttribute("totalCount" , total);
		
		//차트 정보 
		Map<String,Object> chartResult = trainerPageService.selectChartInfo(memberId);
		model.addAttribute("chartResult", chartResult);
		System.out.println("모델");
		
		System.out.println(model.toString());
		
		return "trainerPage/chatAccountInfo";
	}
	
	@RequestMapping(value = "myClassInfo.do", method = RequestMethod.GET)
	public String myClassInfo(@ModelAttribute("lessonVO") LessonVO lessonVO, AttachFileVO fileVO, Model model, HttpServletRequest request,
			   Criteria cri,
			   @RequestParam(value="selCate", required=false) String selCate, 
			   @RequestParam(value="selLev", required=false) String selLev,
			   @RequestParam(value="keyword", required=false) String keyword) throws Exception{
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		
		cri.setMemberId(memberId);
		cri.setSelCate(selCate);
		cri.setSelLev(selLev);
		cri.setKeyword(keyword);
		cri.setPerPageNum(10);
		
		List<Map<String,Object>> classList = trainerPageService.selectTrainerClassList(cri);
		model.addAttribute("classList", classList );
		
		// 페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//전체 글 개수 세팅
		int totalCount = trainerPageService.selectTrainerClassCnt(cri);
		System.out.println("개수 : " + totalCount);
		pageMaker.setTotalCount(totalCount);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("totalCount",totalCount);
		
		model.addAttribute("selCate", selCate);
	   	model.addAttribute("selLev", selLev);
	   	model.addAttribute("keyword", keyword);
		
		//구매 많은 순 차트 정보 (남자)
		List<Map<String,Object>> chartMaleResult = trainerPageService.selectBestClassMaleInfo(memberId);
		List<Map<String,Object>> chartFemaleResult = trainerPageService.selectBestClassFemaleInfo(memberId);
		model.addAttribute("chartMaleResult", chartMaleResult);
		model.addAttribute("chartFemaleResult", chartFemaleResult);
		System.out.println("모델");
		
		System.out.println(model.toString());
		return "trainerPage/myClassInfo";
	}
	
	 @RequestMapping(value = "updTrainerLessonAjax.do", method = RequestMethod.POST)
	 @ResponseBody
	 public String lessonModFinish(HttpServletRequest request) throws Exception{
		 HttpSession session = request.getSession();
			String memberId = (String) session.getAttribute("memberId");
			if (memberId == null) {
				memberId = "";
			}
			
		 String lessonSeq = request.getParameter("lessonSeq");
		 String upUserId = request.getParameter("upUserId");
		 String lessonPrivateFlag = request.getParameter("lessonPrivateFlag");
		 
		 //upUserId가 관리자인지 알아보기
		 Map<String,Object> adminFlag = trainerPageService.selectAdminFlag(upUserId);
		 String flag = (String)adminFlag.get("memberGubun");
		 System.out.println("flag : " + flag);
		 if(flag.equals("A")) {
			 System.out.println("여기안들어옴?");
			 return "A";
		 }else {
			 //관리자가 아니면 바꾸기
			 LessonVO vo = new LessonVO();
			 vo.setLessonSeq(lessonSeq);
			 vo.setLessonPrivateFlag(lessonPrivateFlag);
			 vo.setMemberId(memberId);
			 int updateResult = trainerPageService.updateLessonPrivate(vo);
			 if(updateResult > 0) {
				return "ok";
			 }else {
				 return "ng";
			 }
		 }
		 
		 
		 
	 }
	
	@RequestMapping(value = "classAccountInfo.do", method = RequestMethod.GET)
	public String classAccountInfo(HttpServletRequest request, Model model, Criteria cri,
			@RequestParam(value = "selDate", required = false) String selDate) throws Exception{
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		cri.setMemberId(memberId);
		cri.setSelDate(selDate);
		cri.setPerPageNum(10);

		List<Map<String,Object>> classAccountList = trainerPageService.selectClassAccountList(cri);
		model.addAttribute("classAccountList", classAccountList);
		// 페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		//전체 글 개수 세팅
		int total = trainerPageService.selectClassCnt(cri);
		pageMaker.setTotalCount(total);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("selDate", selDate);
		model.addAttribute("totalCount" , total);
		
//		차트 정보 
		Map<String,Object> chartResult = trainerPageService.selectChart2Info(memberId);
		model.addAttribute("chartResult", chartResult);
		System.out.println("모델");
		System.out.println(model.toString());

		return "trainerPage/classAccountInfo";
	}
	
	@RequestMapping(value = "teachList.do", method = RequestMethod.GET)
	public String teachList() throws Exception{
		return "trainerPage/teachList";
	}
	
	
	@RequestMapping(value = "chatAccountPdf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String chatAccountPdf(HttpServletRequest request, Model model) throws Exception{
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		
		
		String totalPrice = request.getParameter("totalPrice");
		String totalCount = request.getParameter("totalCount");
		String selDate = request.getParameter("selDate").substring(4,6);
		int vat = (int) (Integer.parseInt(totalPrice) * 0.2);
		int realPrice = Integer.parseInt(totalPrice) - vat; 
		System.out.println("totalPrice : " + totalPrice);
		System.out.println("totalCount : " + totalCount);
		System.out.println("selDate : " + selDate);
		
		//이름 가져오기
		Map<String,Object> memberInfo = trainerPageService.selectTrainer(memberId);
		String name = (String)memberInfo.get("memberName");		
				
		model.addAttribute("totalPrice" , totalPrice);
		model.addAttribute("totalCount" , totalCount);
		model.addAttribute("selDate" , selDate);
		model.addAttribute("name" , name);
		model.addAttribute("vat" , vat);
		model.addAttribute("realPrice" , realPrice);
		
		return "trainerPage/chatAccountPdf";
	}
	
	@RequestMapping(value = "classAccountPdf.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String classAccountPdf(HttpServletRequest request, Model model) throws Exception{
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		String selDate = request.getParameter("selDate");
		System.out.println("에휴");
		System.out.println(selDate);
		
		Map<String, Object> info = new HashMap<>();
		info.put("memberId", memberId);
		info.put("selDate", selDate);
		
		List<Map<String, Object>> AccountList = trainerPageService.selectAccountList(info);
		model.addAttribute("AccountList", AccountList);
		//이름 가져오기
		Map<String,Object> memberInfo = trainerPageService.selectTrainer(memberId);
		String name = (String)memberInfo.get("memberName");	
		model.addAttribute("name", name);
		
		//나머지 정보 가져오기
		Map<String,Object> remaininfo = trainerPageService.selectRemainInfo(info);
		model.addAttribute("remainInfo",remaininfo);
		
		System.out.println("모델...");
		System.out.println(model.toString());

		
		return "trainerPage/classAccountPdf";
	}
	
	@RequestMapping(value = "trainerInfo.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String trainerInfo(HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		
		//내 정보 가져오기
		Map<String,Object> myInfo = trainerPageService.selectMyInfo(memberId);
		model.addAttribute("myInfo", myInfo);
		System.out.println("모델....");
		System.out.println(model.toString());
		return "trainerPage/trainerInfo";
	}
	
  @RequestMapping(value = "trainerInfoModAjax.do")
  @ResponseBody
  public String trainerInfoModAjax(HttpServletRequest request, Model model) throws Exception {
	  HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		
		
	  String trainerGym = request.getParameter("trainerGym");
	  String trainerAward = request.getParameter("trainerAward");
	  String trainerCareer = request.getParameter("trainerCareer");
	  
	  System.out.println("trainerGym "+trainerGym);
	  System.out.println("trainerAward "+trainerAward );
	  System.out.println("trainerCareer "+trainerCareer);
	  
	  //내정보 수정
	  ProcessVO vo = new ProcessVO();
	  vo.setTrainerGym(trainerGym);
	  vo.setTrainerAward(trainerAward);
	  vo.setTrainerCareer(trainerCareer);
	  vo.setMemberId(memberId);;
	  int updateResult = trainerPageService.updateMyInfo(vo);
     String msg = "ng";
     
     if(updateResult > 0) {
        msg = "ok";
     }
      return msg;
  }
}