package kr.or.profit.web;

import java.io.File;
import java.util.ArrayList;
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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.profit.service.AdminMemberService;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.PageMaker;
import kr.or.profit.vo.ProcessVO;
import net.sf.json.JSONObject;

@Controller
public class AdminMemberController {

	private static final String CURR_IMAGE_REPO_PATH = "\\\\192.168.41.6\\upload\\profit";

	@Resource(name = "adminMemberService")
	private AdminMemberService adminMemberService;
	
	
	/*회원관리탭*/
	
	//회원 전체 리스트
	@RequestMapping(value = "adminMemberList.do", method = RequestMethod.GET)
	public String adminMemberList(Model model, HttpServletRequest request, Criteria cri) throws Exception {
		cri.setPerPageNum(10);
		List<MemberVO> memberList = adminMemberService.selectAdminMemberList(cri);
		model.addAttribute("memberList", memberList);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(adminMemberService.selectMemberListCnt(cri));
		model.addAttribute("pageMaker", pageMaker);
		
		return "adminMember/adminMemberList";
	}
	
	
	// 모달 상세보기 ajax
	@RequestMapping(value = "adminMemberDetailAjax.do", produces = "application/text; charset=utf-8")
	public @ResponseBody String adminMemberDetail(String memberId, HttpServletResponse response) throws Exception {
		MemberVO vo = adminMemberService.adminMemberDetail(memberId);
		JSONObject jsonObject = new JSONObject();

		if (vo != null) {
			jsonObject.put("msg", "ok");
			jsonObject.put("vo", vo);
		} else {
			jsonObject.put("msg", "no");
		}
		response.setCharacterEncoding("UTF-8");
		String jsonInfo = jsonObject.toString();
		System.out.println(jsonInfo);
		return jsonInfo;
		
	}
	
	//블랙리스트 추가
	@RequestMapping(value = "addBlacklistAjax.do", method = RequestMethod.GET)
	public @ResponseBody String addBlacklist(HttpServletRequest request, MemberVO vo) throws Exception {
		String msg = "";
		int cnt = adminMemberService.insertBlacklist(vo);
		
		if(cnt > 0) {
			msg = "ok";
		}else {
			msg = "no";
		}
		
		return msg;
	}
	
	//블랙리스트 해제
	@RequestMapping(value = "removeBlacklistAjax.do", method = RequestMethod.GET)
	public @ResponseBody String removeBlacklist(HttpServletRequest request, MemberVO vo) throws Exception {
		String msg = "";
		int cnt = adminMemberService.deleteBlacklist(vo.getMemberId());
		
		if(cnt > 0) {
			msg = "ok";
		}else {
			msg = "no";
		}
		
		return msg;
	}
	
	
	/*트레이너 승인 탭*/
	
	// 트레이너 승인 리스트
	@RequestMapping(value = "trainerPermitList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String fitness(Model model, HttpServletRequest request, Criteria cri) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			memberId = "";
		}
		cri.setPerPageNum(10);

		ProcessVO todayNumberList = adminMemberService.selectProcessNumberList();
		model.addAttribute("todayNumberList", todayNumberList);
		List<Map<String, Object>> processList = adminMemberService.selectProcessList(cri);
		model.addAttribute("processList", processList);
		
		// 페이징처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(adminMemberService.selectProcessListCnt(cri));
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("selStatus", cri.getSelStatus());
		model.addAttribute("selIdentity", cri.getSelIdentity());
		model.addAttribute("selDate", cri.getSelDate());
		model.addAttribute("searchKeyword", cri.getSearchKeyword());
		
		return "adminMember/trainerPermitList";
	}

	// 신청->검토 단계로 업데이트
	@RequestMapping("updateStatusBAjax.do")
	public @ResponseBody String updateStatusB(String processSeq) throws Exception {
		String message = "";
		int cnt = adminMemberService.updateStatusB(processSeq);
		if (cnt > 0) {
			message = "ok";
		}
		return message;
	}
	
	//관리자 메모 업데이트
	@RequestMapping(value = "adminMemoAjax.do", method = RequestMethod.POST)
	public @ResponseBody String adminMemo(ProcessVO vo, HttpServletRequest request) throws Exception {
		int cnt = adminMemberService.updateAdminMemo(vo);
		String msg = "";
		if(cnt > 0) {
			msg = "ok";
		}
		return msg;
	}
	
	
	
	// 관리자가 승인,보완,반려 선택 업데이트
	@RequestMapping(value = "updateStatusAjax.do", method = RequestMethod.POST)
	public @ResponseBody String updateProcessStatus(HttpServletResponse response, HttpServletRequest request, ProcessVO vo) throws Exception {
		// 1. process 테이블에 정보 update
		int cnt = adminMemberService.updateProcessStatus(vo);
		String msg = "";
		if(cnt > 0) {
			msg = "ok";
		}
		String processStatus = vo.getProcessStatus();
		
		// 2. 승인이었으면 trainer 테이블로 insert
		if(processStatus.equals("E")) {
			adminMemberService.insertTrainerInfo(vo);
			//member 테이블에서 gubun T 로 업데이트
			adminMemberService.updateGubunTrainer(vo);
			
		}
		
		
		// 3. 신청인한테 문자보내기 <Coolsms 요금때문에 일단 주석!! 정상 작동 됩니다>
/*		String memberName = vo.getMemberName();
		String memberMobile = vo.getMemberMobile();
		String text = "";
		if(processStatus.equals("E")) {
			text = "안녕하세요 PROFIT입니다." + memberName + "회원님께서는 PROFIT의 트레이너로 승인되었습니다. 앞으로 저희 PROFIT에서 다양한 활동 부탁드립니다.";
		}else if(processStatus.equals("C")){
			text = "안녕하세요 PROFIT입니다." + memberName + "회원님의 신청이 보완요청 처리되었습니다. 자세한 사항은 홈페이지의 신청내역의 결과사유를 참고하시길 바랍니다.";
		}else if(processStatus.equals("D")) {
			text = "안녕하세요 PROFIT입니다." + memberName + "회원님의 신청이 반려 처리되었습니다. 자세한 사항은 홈페이지의 신청내역의 결과사유를 참고하시길 바랍니다.";
		}
		
		System.out.println(memberName);
		System.out.println(memberMobile);
		System.out.println(text);
		
		
		String api_key = "NCSVDVNCRIIHWTR1";
		String api_secret = "WVU0LBZ7JQUZXQECBRQ7OCHPZHVSZWPJ";

		Coolsms coolsms = new Coolsms(api_key, api_secret);

		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", memberMobile); // 수신번호
		set.put("from", "01040487642"); // 발신번호
		set.put("text", text); // 문자내용
		set.put("type", "sms"); // 문자 타입

		System.out.println(set);

		JSONObject result = coolsms.send(set); // 보내기&전송결과받기
		System.out.println();

		if ((boolean) result.get("status") == true) {
			// 메시지 보내기 성공 및 전송결과 출력
			System.out.println("성공");
			System.out.println(result.get("group_id")); // 그룹아이디
			System.out.println(result.get("result_code")); // 결과코드
			System.out.println(result.get("result_message")); // 결과 메시지
			System.out.println(result.get("success_count")); // 메시지아이디
			System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수
		} else {
			// 메시지 보내기 실패
			System.out.println("실패");
			System.out.println(result.get("code")); // REST API 에러코드
			System.out.println(result.get("message")); // 에러메시지
		}*/
		return msg;
	}

	
	
	
	// 각 디테일 페이지
	@RequestMapping(value = "trainerPermitDetail.do", method = RequestMethod.GET)
	public String trainerPermitDetail(Model model,
			@RequestParam(value = "processSeq", required = false) String processSeq) throws Exception {

		ProcessVO detailVO = adminMemberService.selectProcessDetailBySeq(processSeq);
		model.addAttribute("detailVO", detailVO);

		String fileSeq = detailVO.getFileSeq();
		List<?> fileVO = adminMemberService.selectProcessFile(fileSeq);
		model.addAttribute("fileVO", fileVO);

		return "adminMember/trainerPermitDetail";
	}

	// 관리자가 트레이너 정보 수정
	@RequestMapping(value = "updateAdminPermitDetailAjax.do", method = RequestMethod.POST)
	public @ResponseBody String updateAdminPermitDetail(MultipartHttpServletRequest multipartRequest,
			HttpServletResponse response, HttpServletRequest request, ProcessVO processVO) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		String msg = "";
		// 1. 관리자가 선택한 파일 삭제
		AttachFileVO deleteVO = new AttachFileVO();
		deleteVO.setFileSeq(processVO.getFileSeq());
		String[] arrayParam = multipartRequest.getParameterValues("delFile");
		if (arrayParam != null) {
			for (int i = 0; i < arrayParam.length; i++) {
				System.out.println(arrayParam[i]);
				deleteVO.setFileDetailSeq(arrayParam[i]);
				adminMemberService.deleteFileDetailSeq(deleteVO);
			}
		}

		// 업로드할 파일 있는지 없는지 분기
		String fileDetailSeq = adminMemberService.selectFileDetailSeq(processVO.getFileSeq());
		String[] arrayText = multipartRequest.getParameterValues("text");
		int updCnt = 0;
		if (arrayText != null) {
			System.out.println("널이 아니다");
			// 파일업로드
			List<AttachFileVO> fileVOList = fileProcess(multipartRequest, request, processVO, fileDetailSeq);

			// 2.attach_file 테이블에 insert
			Map<String, Object> filemap = new HashMap<String, Object>();
			filemap.put("list", fileVOList);
			int insCnt = adminMemberService.insertFilebyAdmin(filemap);
			System.out.println(insCnt);

			// 3.process 테이블에 트레이너 정보 update
			updCnt = adminMemberService.updateProcessInfo(processVO);
			System.out.println(updCnt);

		} else {
			System.out.println("널이다");
			// 3.process 테이블에 트레이너 정보 update
			updCnt = adminMemberService.updateProcessInfo(processVO);
			System.out.println(updCnt);

		}
		if (updCnt > 0) {
			msg = "ok";
		}
		return msg;
	}

	// uploadAjax 안에서 사용하는 메서드
	public List<AttachFileVO> fileProcess(MultipartHttpServletRequest multipartRequest, HttpServletRequest request,
			ProcessVO processVO, String fileDetailSeq) throws Exception {

		List<AttachFileVO> fileVOList = new ArrayList<AttachFileVO>();
		Iterator<String> fileNames = multipartRequest.getFileNames();

		int detailSeq = Integer.parseInt(fileDetailSeq) + 1;
		while (fileNames.hasNext()) {
			UUID uuid = UUID.randomUUID();
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();

			File file = new File(CURR_IMAGE_REPO_PATH + "\\" + uuid.toString() + "_" + originalFileName);
			if (mFile.getSize() != 0) {
				if (!file.exists()) {
					if (file.getParentFile().mkdir()) {
						file.createNewFile();
					}
				}
				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH + "\\" + uuid.toString() + "_" + originalFileName));
			}
			AttachFileVO attachvo = new AttachFileVO();
			attachvo.setFileSeq(processVO.getFileSeq());
			attachvo.setFileDetailSeq(Integer.toString(detailSeq));
			attachvo.setFileRealName(originalFileName);
			attachvo.setFileSaveName(uuid.toString() + "_" + originalFileName);
			attachvo.setFilePath("http://192.168.41.6:9999/upload/profit/" + uuid.toString() + "_" + originalFileName);
			attachvo.setInUserId(processVO.getMemberId());
			attachvo.setUpUserId(processVO.getMemberId());
			fileVOList.add(attachvo);
			detailSeq++;
		}

		return fileVOList;
	}
	

}