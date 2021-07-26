package kr.or.profit.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.profit.service.CommunityService;
import kr.or.profit.service.NoticeService;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.PageMaker;

@Controller
public class NoticeController {

	@Resource(name = "noticeService")
	private NoticeService noticeService;
	@Resource(name = "communityService")
	private CommunityService communityService;

	/**
	 * 공지사항 목록(noticeList)
	 *
	 * @author 박상빈
	 * @param HttpSession, Criteria, Model
	 * @return "notice/noticeList"
	 * @exception Exception
	 */
	@RequestMapping(value = "noticeList.do", method = RequestMethod.GET)
	public String noticeList(HttpSession ssion, Criteria cri, Model model) throws Exception {
		String memberId = (String) ssion.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		cri.setMemberId(memberId);
		List<?> noticeList = noticeService.noticeList(cri);
		model.addAttribute("data", noticeList);
		// 페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		// 전체 글 개수 세팅 - 검색결과과 무관하게 페이징 생성 => 수정필요 => 수정 완
		pageMaker.setTotalCount(noticeService.selectBoardCnt(cri));
		model.addAttribute("pageMaker", pageMaker);
		return "notice/noticeList";
	}

	/**
	 * 공지사항 상세보기(noticeDetail)
	 *
	 * @author 박상빈
	 * @param Map, Model
	 * @return "notice/noticeDetail"
	 * @exception Exception
	 */
	@RequestMapping(value = "noticeDetail.do", method = RequestMethod.GET)
	public String noticeDetail(@RequestParam Map<String, Object> map, Model model) throws Exception {
		noticeCommonHit(map);
		Map<String, Object> noticeDetail = noticeService.noticeDetail(map);
		List<?> noticeDetailFile = noticeService.noticeDetailFile(map);
		model.addAttribute("data", noticeDetail);
		if (!(noticeDetailFile.get(0) == null)) {
			model.addAttribute("noticeDetailFile", noticeDetailFile);
		}
		return "notice/noticeDetail";
	}

	/**
	 * 공지사항 등록(noticeAdd)
	 *
	 * @author 박상빈
	 * @param 화면용
	 * @return "notice/noticeAdd"
	 * @exception Exception
	 */
	@RequestMapping(value = "noticeAdd.do", method = RequestMethod.GET)
	public String noticeAdd() throws Exception {
		return "notice/noticeAdd";
	}

	/**
	 * 공지사항 등록(noticeAdd)
	 *
	 * @author 박상빈
	 * @param map, mtfRequest, request, response
	 * @return msg
	 * @exception Exception
	 */
	@RequestMapping(value = "noticeAdd.do", method = RequestMethod.POST)
	@ResponseBody
	public String noticeInsert(@RequestParam Map<String, Object> map, MultipartHttpServletRequest mtfRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession ssion = request.getSession();
		map.put("memberId", ssion.getAttribute("memberId"));
		String memberId = (String) map.get("memberId");
		//파일
//		List<MultipartFile> fileList = mtfRequest.getFiles("file");
		String src = mtfRequest.getParameter("src");
		//파일 등록
		List<String> noticeFileName = qnaProfileUpload(mtfRequest, request);
		//파일 번호 확인
		if (!(noticeFileName.get(0).equals("파일없음"))) {
			String tumnalil = fileNameCnt(noticeFileName, memberId);
			int tumnalil_img = Integer.parseInt(tumnalil)-1;
			map.put("tumnalil_img", tumnalil_img);
		}
		int noticeInsert = noticeService.noticeInsert(map);
		String msg = "ng";
		if(noticeInsert>0) {
			msg = "ok";
		}
		return msg;
	}

	/**
	 * 공지사항 수정하기(noticeMod)화면용
	 *
	 * @author 박상빈
	 * @param Map, Model
	 * @return "notice/noticeMod"
	 * @exception Exception
	 */
	@RequestMapping(value = "noticeMod.do", method = RequestMethod.GET)
	public String noticeMod(@RequestParam Map<String, Object> map, Model model) throws Exception {
		Map<String, Object> noticeDetail = noticeService.noticeDetail(map);
		List<?> noticeDetailFile = noticeService.noticeDetailFile(map);
		model.addAttribute("data", noticeDetail);
		if (!(noticeDetailFile.get(0) == null)) {
			model.addAttribute("noticeDetailFile", noticeDetailFile);
		} else {
			model.addAttribute("noticeDetailFile", "0");
		}
		return "notice/noticeMod";
	}

	/**
	 * 공지사항 수정(noticeMod)
	 *
	 * @author 박상빈
	 * @param 	Map, HttpServletRequest, HttpServletResponse
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value = "noticeMod.do", method = RequestMethod.POST)
	public void noticeModUpdate(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession ssion = request.getSession();
		String memboerId = (String) ssion.getAttribute("memberId");
		String communitySeq = (String) map.get("communitySeq");
		String fileSeq = (String) map.get("fileSeq");
		String fileDel = (String) map.get("fileDel");

		//파일없다면
		if (fileSeq == null || fileSeq == "") {
			map.put("fileSeq", "");
			map.put("fileDel", "");
			fileSeq = (String) map.get("fileSeq");
			fileDel = (String) map.get("fileDel");
		}
		//파일있다면
		if (fileDel != null || fileDel != "") {
			String[] fileDels = fileDel.split(",");
			//삭제하러간다
			for (int i = 0; i < fileDels.length; i++) {
				String fileDetailSeq = fileDels[i];
				noticeModDelFile(fileSeq, fileDetailSeq);
			}
		}
		int noticeModUpdate = noticeService.noticeModUpdate(map);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('공지사항이 수정 되었습니다'); location.href='noticeDetail.do?communitySeq=" + communitySeq + "';</script>");
		out.flush();
	}

	/**
	 * 공지사항 삭제(noticeDelete)
	 *
	 * @author 박상빈
	 * @param Map, HttpServletResponse
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value = "noticeDelete.do", method = RequestMethod.GET)
	public void noticeDelete(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception {
		int noticeDelete = noticeService.noticeDelete(map);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('공지사항이 삭제 되었습니다');location.href='noticeList.do';</script>");
		out.flush();
	}

	/**
	 * 파일 업로드
	 *
	 * @author 박상빈
	 * @param MultipartHttpServletRequest, HttpServletRequest
	 * @return fileAllList
	 * @exception Exception
	 */
	//파일 업로드
	public List<String> qnaProfileUpload(MultipartHttpServletRequest file, HttpServletRequest request) throws Exception {
		UUID uuid = UUID.randomUUID();
		//파일들
		List<MultipartFile> fileList = file.getFiles("file");
		//보낼때 쓸것들
		List<String> fileAllList = new ArrayList<>();
		for (MultipartFile mf : fileList) {
			String fileOriginalname = mf.getOriginalFilename();
			//파일없을때
			if (fileOriginalname.equals("")) {
				fileAllList.add("파일없음");
				return fileAllList;
			}
			// 업로드할 파일 이름
			String fileChangeName = uuid.toString() + "_" + fileOriginalname;
			String filepath = "\\\\192.168.41.6\\upload\\profit" + "\\" + fileChangeName;
			String fileRoad = "http://192.168.41.6:9999/upload/profit/" + fileChangeName;
			File f = new File(filepath);
			if (!f.exists()) {
				f.mkdirs();
			}
			mf.transferTo(f);
			fileAllList.add(fileRoad);
		}
		return fileAllList;
	}

	/**
	 * 공지사항 파일 수정(등록)
	 *
	 * @author 박상빈
	 * @param Map, MultipartHttpServletRequest, HttpServletRequest
	 * @return msg
	 * @exception Exception
	 */
	@RequestMapping(value = "qnaProfileUploadMod.do", method = RequestMethod.POST)
	@ResponseBody
	public String qnaProfileUploadMod(@RequestParam Map<String, Object> map, Model model, MultipartHttpServletRequest file, HttpServletRequest request) throws Exception {
		HttpSession ssion = request.getSession();
		String memberId = (String)ssion.getAttribute("memberId");
		String fileSeq = (String)map.get("fileSeq");
		String msg = "ng";
		System.out.println("온다" + map);
		//파일 나누기
		List<String> noticeFileName = qnaProfileUpload(file, request);
		if(fileSeq == null || fileSeq == "") {
			fileSeq = noticeService.noticeFileCnt();
			map.put("fileSeq", fileSeq);
			noticeService.fileSeq(map);
		}
		Map<String, Object> imgindexs = new HashMap<String, Object>();
		for (String list : noticeFileName) {

			if (!(list.equals("파일없음"))) {
				//파일이름 자르기1(처음이름)
				int index1 = list.indexOf("profit/") + 44;
				String fileRealName = list.substring(index1);
				//파일이름 자르기2(저장할이름)
				int index2 = list.indexOf("profit/") + 7;
				String filesavename = list.substring(index2);
				//파일이름 한곳에 넣기
				imgindexs.put("fileSeq", fileSeq);
				imgindexs.put("imgFile", list);
				imgindexs.put("fileRealName", fileRealName);
				imgindexs.put("filesavename", filesavename);
				imgindexs.put("memberId", memberId);
			}
			//파일 이름 디비 저장
			int noticeFileUploadMod = noticeService.noticeFileUploadMod(imgindexs);
			//파일 seq
			if (noticeFileUploadMod > 0) {
				msg = "ok";
			}
		}
		return msg;
	}

	/**
	 * 파일 자르기
	 *
	 * @author 박상빈
	 * @param List, String
	 * @return cnt
	 * @exception Exception
	 */
	//파일 자르기
	public String fileNameCnt(List<String> noticeFileName, String memberId) throws Exception {
		String cnt = "0";
		int fileDetailSeq = 1;
		Map<String, Object> imgindexs = new HashMap<String, Object>();
		for (String list : noticeFileName) {
			if (!(list.equals("파일없음"))) {
				//파일이름 자르기1(처음이름)
				int index1 = list.indexOf("profit/") + 44;
				String fileRealName = list.substring(index1);
				//파일이름 자르기2(저장할이름)
				int index2 = list.indexOf("profit/") + 7;
				String filesavename = list.substring(index2);
				//파일이름 한곳에 넣기
				if (!(cnt == "0")) {
					imgindexs.put("cnt", cnt);
				}
				imgindexs.put("fileDetailSeq", fileDetailSeq);
				imgindexs.put("imgFile", list);
				imgindexs.put("fileRealName", fileRealName);
				imgindexs.put("filesavename", filesavename);
				imgindexs.put("memberId", memberId);
			} else {
				imgindexs.put("fileDetailSeq", fileDetailSeq);
				imgindexs.put("imgFile", "파일없음");
				imgindexs.put("fileRealName", "파일없음");
				imgindexs.put("filesavename", "파일없음");
				imgindexs.put("memberId", memberId);
			}
			//파일 이름 디비 저장
			int noticeFileUpload = noticeService.noticeFileUpload(imgindexs);
			//파일 seq
			cnt = noticeService.noticeFileCnt();
			fileDetailSeq++;
		}
		return cnt;
	}

	/**
	 * 공지사항 파일 삭제
	 *
	 * @author 박상빈
	 * @param String, String
	 * @return
	 * @throws Exception
	 */
	public void noticeModDelFile(String fileSeq, String fileDetailSeq) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fileSeq", fileSeq);
		map.put("fileDetailSeq", fileDetailSeq);
		int noticeModDelFile = noticeService.noticeModDelFile(map);
	}

	/**
	 * 공지사항 파일 다운로드(qnaProfileDownload)
	 *
	 * @author 박상빈
	 * @param Map, HttpServletResponse
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "qnaProfileDownload.do", method = RequestMethod.POST)
	public void qnaProfileDownload(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception {
		Map<String, Object> resultMap = noticeService.qnaProfileDownload(map);
		String storedFileName = (String) resultMap.get("fileSaveName");
		String originalFileName = (String) resultMap.get("fileSaveName");
		byte[] fileByte = org.apache.commons.io.FileUtils.readFileToByteArray(new File("\\\\192.168.41.6\\upload\\profit" + "\\" + storedFileName));
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	/**
	 * 조회수 증가
	 *
	 * @author 박상빈
	 * @param map
	 * @return
	 * @exception Exception
	 */
	public void noticeCommonHit(Map<String, Object> map) throws Exception {
		int noticeCommonHit = noticeService.noticeCommonHit(map);
	}
}