package kr.or.profit.web;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.profit.service.CommunityService;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.PageMaker;
import kr.or.profit.vo.ReplyVO;
import net.sf.json.JSONObject;

/**
 * 
 * Handles requests for the application home page.
 */
@Controller
public class CommunityController {
	@Resource(name = "communityService")
	private CommunityService communityService;

	private static final Logger logger = LoggerFactory.getLogger(CommunityController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "recipeList", method = RequestMethod.GET)
	public String recipeList(Locale locale, Model model) {

		return "community/recipeList";
	}

	@RequestMapping(value = "recipeDetail", method = RequestMethod.GET)
	public String recipeDetail(Locale locale, Model model) {

		return "community/recipeDetail";
	}

	@RequestMapping(value = "recipeAdd", method = RequestMethod.GET)
	public String recipeAdd(Locale locale, Model model) {

		return "community/recipeAdd";
	}

	@RequestMapping(value = "recipeMod", method = RequestMethod.GET)
	public String recipeMod(Locale locale, Model model) {

		return "community/recipeMod";
	}

	/**
	 * 자유게시판 좋아요/북마크 제거
	 * 
	 * @author 길민선
	 * @param BookgoodVO
	 * @return String - community/boardAdd
	 * @throws Exception
	 */
	@RequestMapping(value = "removeBookgoodAjax.do", produces = "application/text; charser=utf-8")
	public @ResponseBody String removeBookgood(BookgoodVO vo) throws Exception {

		int delCnt = communityService.deleteBookgood(vo);
		int cnt = communityService.selectBookgoodCnt(vo);
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
	@RequestMapping(value = "addBookgoodAjax.do", produces = "application/text; charser=utf-8")
	public @ResponseBody String addBookgood(BookgoodVO vo) throws Exception {

		int insCnt = communityService.insertBookgood(vo);
		int cnt = communityService.selectBookgoodCnt(vo);
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
	 * 자유게시판 목록 페이지
	 * 
	 * @author 정예진
	 * @param model
	 * @return String - community/boardAdd
	 * @throws Exception
	 */
	@RequestMapping(value = "boardList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardList(Model model, HttpServletRequest request, Criteria cri,
			@RequestParam(value = "selCate", required = false) String selCate,
			@RequestParam(value = "selLev", required = false) String selLev,
			@RequestParam(value = "keyword", required = false) String keyword) throws Exception {

		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}

		cri.setMemberId(memberId);
		cri.setSelCate(selCate);
		cri.setSelLev(selLev);
		cri.setKeyword(keyword);

		// 자유게시판 인기글 목록
		List<Map<String, String>> boardTopList = communityService.selectBoardTopList(memberId);
		// System.out.println("boardTopList.size : " + boardTopList.size());
		model.addAttribute("boardTopList", boardTopList);
		// System.out.println("출력 : " + boardTopList.get(0).get("filePath"));

		// 자유게시판 목록
		List<Map<String, String>> boardList = communityService.selectBoardList(cri);

		model.addAttribute("boardList", boardList);

		System.out.println(model.toString());

		// 페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		// 전체 글 개수 세팅 - 검색결과과 무관하게 페이징 생성 => 수정필요 => 수정 완
		pageMaker.setTotalCount(communityService.selectBoardCnt(cri)); 
		
		System.out.println(communityService.selectBoardCnt(cri) + "가져오는 개수!!!!!!!!!!!!");

		model.addAttribute("pageMaker", pageMaker);
		
		//입력한 검색어 유지시키기
		model.addAttribute("selCate", selCate);
		model.addAttribute("selLev", selLev);
		model.addAttribute("keyword", keyword);

		return "community/boardList";
	}

	/**
	 * 자유게시판 상세 페이지
	 * 
	 * @author 정예진
	 * @param model
	 * @return String - community/boardAdd
	 * @throws Exception
	 */
	@RequestMapping(value = "boardDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String boardDetail(@ModelAttribute("communityVO") CommunityVO communityVO, Model model,
			HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		String communitySeq = communityVO.getCommunitySeq();

		CommunityVO paramVO = new CommunityVO();
		paramVO.setMemberId(memberId);
		paramVO.setCommunitySeq(communitySeq);

		// 게시글 상세정보
		Map<String, Object> boardDetail = communityService.selectBoardDetail(paramVO);

		// 댓글 내 프로필 사진 이미지 정보
		String myprofile = communityService.selectMyProfile(memberId);
		System.out.println("기본이미지 : " + myprofile);
		boardDetail.put("MyProfileImage", myprofile);

		// 댓글 목록 가져오기
		List<Map<String, Object>> replyList = communityService.selectReplyList(communitySeq);
		boardDetail.put("replyList", replyList);
		
		//댓글 수 가져오기
		Map<String,Object> replyCnt = communityService.selectReplyCnt(communitySeq);
		boardDetail.put("replyCnt", replyCnt.get("cnt"));

		// 조회수 증가
		communityService.increaseHit(communitySeq);

		// 최신 글 TOP5 가져오기
		List<Map<String, Object>> recentBoardList = communityService.recentBoardList();
		System.out.println("최신글 : " + recentBoardList);
		boardDetail.put("recentBoardList", recentBoardList);

		// 인기 글 TOP5 가져오기
		List<Map<String, Object>> bestBoardList = communityService.bestBoardList();
		System.out.println("인기글 : " + bestBoardList);
		boardDetail.put("bestBoardList", bestBoardList);

		model.addAttribute("BoardDetail", boardDetail);
		System.out.println("dddddddddddddddddddd");
		System.out.println("모델 : " + model.toString());

		return "community/boardDetail";
	}

	/**
	 * 자유게시판 글 수정
	 * 
	 * @author 정예진
	 * @param
	 * @return String - community/boardMod
	 * @throws Exception
	 */
	@RequestMapping(value = "boardMod", method = RequestMethod.GET)
	public String boardMod(CommunityVO communityVO, Model model, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		String communitySeq = communityVO.getCommunitySeq();

		CommunityVO paramVO = new CommunityVO();
		paramVO.setMemberId(memberId);
		paramVO.setCommunitySeq(communitySeq);

		// 게시글 상세정보
		Map<String, Object> boardDetail = communityService.selectBoardDetail(paramVO);

		model.addAttribute("BoardDetail", boardDetail);
		System.out.println("수정페이지");
		System.out.println(model.toString());
		return "community/boardMod";
	}

	/**
	 * 자유게시판 글 수정 Ajax
	 * 
	 * @author 정예진
	 * @param
	 * @return String - community/boardMod
	 * @throws Exception
	 */
	@RequestMapping(value = "boardModAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardModAjax(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");

		String communityCategorySeq = request.getParameter("cate_type");
		String title = request.getParameter("title");
		String editordata = request.getParameter("editordata");
		String tumnail = request.getParameter("tumnail_img");
		String communitySeq = request.getParameter("communitySeq");
		System.out.println("cate_type : " + communityCategorySeq);
		System.out.println("title : " + title);
		System.out.println("editordata : " + editordata);
		System.out.println("thumnail : " + tumnail);

		String fileSeq = null;

		if (!tumnail.equals("./resources/img/common/loading.gif")) {
			int index1 = tumnail.indexOf("profit/") + 44;
			String fileRealName = tumnail.substring(index1);

			int index2 = tumnail.indexOf("profit/") + 7;
			String fileSaveName = tumnail.substring(index2);
			System.out.println("path : " + tumnail);

			AttachFileVO filevo = new AttachFileVO();
			filevo.setFileRealName(fileRealName);
			filevo.setFileSaveName(fileSaveName);
			filevo.setFilePath(tumnail);
			filevo.setInUserId(memberId);
			filevo.setUpUserId(memberId);
			communityService.insertBoardFile(filevo);
			fileSeq = filevo.getFileSeq();
			System.out.println("fileSeq : " + fileSeq);
		}

		CommunityVO vo = new CommunityVO();
		vo.setCommunitySeq(communitySeq);
		vo.setCommunityCategorySeq(communityCategorySeq);
		vo.setCommonTitle(title);
		vo.setCommonContent(editordata);

		if (fileSeq == null) {
			vo.setFileSeq("0");
		} else {
			vo.setFileSeq(fileSeq);
		}
		vo.setUpUserId(memberId);

		int updateResult = communityService.updateBoard(vo);
		System.out.println("updateResult : " + updateResult);

		JSONObject jsonObject = new JSONObject();

		if (updateResult > 0) {
			jsonObject.put("msg", "ok");
			jsonObject.put("communitySeq", vo.getCommunitySeq());
		} else {
			jsonObject.put("msg", "ng");
		}
		String jsonInfo = jsonObject.toString();
		return jsonInfo;

	}

	/**
	 * 자유게시판 글 추가 페이지 이동
	 * 
	 * @author 정예진
	 * @param
	 * @return String - community/boardAdd
	 * @throws Exception
	 */
	@RequestMapping(value = "boardAdd.do", method = RequestMethod.GET)
	public String boardAdd() {

		return "community/boardAdd";
	}

	/**
	 * 게시판 이미지 업로드
	 * 
	 * @author 정예진
	 * @param MultipartFile,HttpServletRequest,HttpServletResponse
	 * @return
	 * @throws Exception
	 */

	@RequestMapping(value = "profileImage.do", method = RequestMethod.POST)
	@ResponseBody
	public void profileUpload(MultipartFile file, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html;charset=utf-8");
		System.out.println("휴...");
		PrintWriter out = response.getWriter();
		// 업로드할 폴더 경로
		String realFolder = request.getSession().getServletContext().getRealPath("profileUpload");
		UUID uuid = UUID.randomUUID();

		// 업로드할 파일 이름
		String org_filename = file.getOriginalFilename();
		String str_filename = uuid.toString() + "_" + org_filename;

		System.out.println("원본 파일명 : " + org_filename);
		System.out.println("저장할 파일명 : " + str_filename);

		String filepath = "\\\\192.168.41.6\\upload\\profit" + "\\" + str_filename;
		System.out.println("파일경로 : " + filepath);
		String finalpath = "http://192.168.41.6:9999/upload/profit/" + str_filename;
		System.out.println("최종경로 : " + finalpath);

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		file.transferTo(f);
		out.println(finalpath);
		out.close();
	}

	/**
	 * 자유게시판 글 등록
	 * 
	 * @author 정예진
	 * @param HttpServletRequest,HttpServletResponse
	 * @return String - msg
	 * @throws Exception
	 */
	@RequestMapping(value = "boardAddAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardAddAjax(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");

		String cate_type = request.getParameter("cate_type");
		String title = request.getParameter("title");
		String editordata = request.getParameter("editordata");
		String tumnail = request.getParameter("tumnail_img");
		System.out.println("cate_type : " + cate_type);
		System.out.println("title : " + title);
		System.out.println("editordata : " + editordata);
		System.out.println("thumnail : " + tumnail);

		String fileSeq = null;

		if (!tumnail.equals("./resources/img/common/loading.gif")) {
			int index1 = tumnail.indexOf("profit/") + 44;
			String fileRealName = tumnail.substring(index1);

			int index2 = tumnail.indexOf("profit/") + 7;
			String fileSaveName = tumnail.substring(index2);
			System.out.println("path : " + tumnail);

			AttachFileVO filevo = new AttachFileVO();
			filevo.setFileRealName(fileRealName);
			filevo.setFileSaveName(fileSaveName);
			filevo.setFilePath(tumnail);
			filevo.setInUserId(memberId);
			filevo.setUpUserId(memberId);
			communityService.insertBoardFile(filevo);
			fileSeq = filevo.getFileSeq();
			System.out.println("fileSeq : " + fileSeq);
		}

		CommunityVO vo = new CommunityVO();

		vo.setCommunityCategorySeq(cate_type);
		vo.setCommonTitle(title);
		vo.setCommonContent(editordata);

		if (fileSeq == null) {
			System.out.println("널이라고");
			vo.setFileSeq("0");
		} else {
			vo.setFileSeq(fileSeq);
		}
		vo.setInUserId(memberId);
		vo.setUpUserId(memberId);

		int insertResult = communityService.insertBoard(vo);
		System.out.println("insertResult : " + insertResult);
		String msg = "ng";

		JSONObject jsonObject = new JSONObject();

		if (insertResult > 0) {
			jsonObject.put("msg", "ok");
			jsonObject.put("communitySeq", vo.getCommunitySeq());
		} else {
			jsonObject.put("msg", "ng");
		}
		String jsonInfo = jsonObject.toString();
		return jsonInfo;

	}

	/**
	 * 자유게시판 댓글 등록
	 * 
	 * @author 정예진
	 * @param HttpServletRequest,HttpServletResponse
	 * @return String - msg
	 * @throws Exception
	 */
	@RequestMapping(value = "replyAddAjax.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String replyAddAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");

		String communitySeq = request.getParameter("communitySeq");
		String replyContent = request.getParameter("replyContent");

		System.out.println("communitySeq : " + communitySeq);
		System.out.println("replyContent : " + replyContent);

		ReplyVO replyvo = new ReplyVO();
		replyvo.setCommunitySeq(communitySeq);
		replyvo.setReplyContent(replyContent);
		replyvo.setInUserId(memberId);
		replyvo.setUpUserId(memberId);

		int insertResult = communityService.insertBoardReply(replyvo);

		String msg = "ng";

		if (insertResult > 0) {
			msg = "ok";
		}
		return msg;
	}

	/**
	 * 자유게시판 답글 등록
	 * 
	 * @author 정예진
	 * @param HttpServletRequest,HttpServletResponse
	 * @return String - msg
	 * @throws Exception
	 */
	@RequestMapping(value = "rereplyAddAjax.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String rereplyAddAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");

		String communitySeq = request.getParameter("communitySeq");
		String replyContent = request.getParameter("replyContent");
		String replyParentSeq = request.getParameter("replyParentSeq");

		System.out.println("communitySeq : " + communitySeq);
		System.out.println("replyContent : " + replyContent);
		System.out.println("replyParentSeq : " + replyParentSeq);

		ReplyVO replyvo = new ReplyVO();
		replyvo.setCommunitySeq(communitySeq);
		replyvo.setReplyContent(replyContent);
		replyvo.setReplyParentSeq(replyParentSeq);
		replyvo.setInUserId(memberId);
		replyvo.setUpUserId(memberId);

		int insertResult = communityService.insertBoardRereply(replyvo);

		String msg = "ng";

		if (insertResult > 0) {
			msg = "ok";
		}
		return msg;
	}

	/**
	 * 자유게시판 댓글 삭제
	 * 
	 * @author 정예진
	 * @param HttpServletRequest,HttpServletResponse
	 * @return String - msg
	 * @throws Exception
	 */
	@RequestMapping(value = "replyDelAjax.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String replyDelAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String replySeq = request.getParameter("replySeq");
		System.out.println("replySeq : " + replySeq);
		int deleteResult = communityService.deleteBoardReply(replySeq);

		String msg = "ng";

		if (deleteResult > 0) {
			msg = "ok";
		}
		return msg;
	}

	/**
	 * 자유게시판 글 삭제
	 * 
	 * @author 정예진
	 * @param HttpServletRequest,HttpServletResponse
	 * @return String - msg
	 * @throws Exception
	 */
	@RequestMapping(value = "BoardDelAjax.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String BoardDelAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String communitySeq = request.getParameter("communitySeq");
		System.out.println("CommunitySeq : " + communitySeq);
		int deleteResult = communityService.deleteBoard(communitySeq);

		String msg = "ng";

		if (deleteResult > 0) {
			msg = "ok";
		}
		return msg;
	}

}
