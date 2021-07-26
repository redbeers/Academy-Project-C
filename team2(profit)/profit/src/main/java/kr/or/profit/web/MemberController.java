package kr.or.profit.web;

import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.mail.iap.Response;

import kr.or.profit.cmmn.TestMailer;
import kr.or.profit.service.MemberService;
import kr.or.profit.vo.KakaoProfile;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.OAuthToken;
import net.sf.json.JSONObject;

@Controller
public class MemberController {

	@Resource(name = "testMailer")
	private TestMailer testMailer;

	@Resource(name = "memberService")
	private MemberService memberService;

	// 민선-카카오 로그인
	@RequestMapping(value = "kakaoCallback.do", produces = "application/json; charset=utf-8", method = { RequestMethod.GET,
			RequestMethod.POST })
	@ResponseBody // data를 리턴해주는 컨트롤러 함수가 된다
	public ModelAndView kakaoCallback(String code, HttpSession session) throws Exception {
		// 2단계 시작
		// POST 방식으로 key=value 데이터를 요청을해야한다 내가(카카오쪽으로)
		// 이떄 필요한 라이브러리가 있다 RestTemplate(과거 자바 - HttpURLConnection, 안드로이드에서 많이 사용하는
		// Retrofit2)
		RestTemplate rt = new RestTemplate();
		// 1. Http 헤더를 만들어야 한다 => HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		// 여기 역할 => 내가 지금 전송한 바디 데이터가 키 밸류 데이터라고 알려주는 것
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// 바디 데이터 담을 오브젝트 하나 만들기 => HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "489bf5bfcd8cd45e45a5eb837d76e305");
		params.add("redirect_uri", "http://localhost:9999/kakaoCallback.do");
		params.add("code", code);

		// HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		// 왜 HttpEntity에 담냐면 exchange라는 함수가 HttpEntity를 담게 되어 있어서
		// kakaoTokenRequest 이게 헤더값을 가지고 있는 엔티티가 된다
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);

		// 실제 요청! => Http 요청하기 - Post 방식으로 - 그리고 response 변수의 응답 받음
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST,
				kakaoTokenRequest, String.class);

		// json 데이터를 오브젝트에 담기 => 제이슨 데이터를 자바에서 처리하기 위해서 자바오브젝트로 바꾼 것
		// 라이브러리 종류 : Gson, Json Simple, ObjectMapper
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);

		System.out.println("카카오 엑세스 토큰 : " + oauthToken.getAccess_token());

		/////////////////////////// 두번째 단계
		RestTemplate rt2 = new RestTemplate();

		// HttpHeader 오브젝트 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = new HttpEntity<>(headers2);

		// HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		ResponseEntity<String> response2 = rt2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
				kakaoProfileRequest2, String.class);
		// 두번째 단계 => return response2.getBody(); : 코드 받고 액세스 토큰 요청받고 액세스 토큰으로 회원정보까지
		// 조회해서 그 결과가 담겨서 보여진다

		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);

		// Member오브젝트 :
//		System.out.println("카카오 아이디(시퀀스 번호)" + kakaoProfile.getId());
//		System.out.println("카카오 이메일" + kakaoProfile.getKakao_account().getEmail());;
//		System.out.println("-------------------------------");
//		System.out.println("memberId : " +kakaoProfile.getId()+ "@K");
//		System.out.println("memberPwd : " +kakaoProfile.getId()+ "@K");
//		System.out.println("memberName : " + kakaoProfile.getKakao_account().getProfile().getNickname());
//		System.out.println("memberNickname : " +kakaoProfile.getKakao_account().getProfile().getNickname());
//		System.out.println("memberEmail : " + kakaoProfile.getKakao_account().getEmail());

		MemberVO vo = new MemberVO();
		vo.setMemberId(kakaoProfile.getId() + "@Kakao");
		vo.setMemberPwd(kakaoProfile.getId() + "@Kakao");
		vo.setMemberName(kakaoProfile.getKakao_account().getProfile().getNickname());
		vo.setMemberNickname(kakaoProfile.getKakao_account().getProfile().getNickname());
		vo.setMemberEmail(kakaoProfile.getKakao_account().getEmail());

		// 가입자인지 비가입자인이 체크해서 처리
		String memberId = kakaoProfile.getId() + "@Kakao";
		int cnt = memberService.kakaoSelectById(memberId);
		System.out.println(cnt);
		if (cnt == 0) {
			// 회원가입
			memberService.kakaoInsertMember(vo);
			// 로그인처리까지
			session.setAttribute("memberId", vo.getMemberId());
			session.setAttribute("memberNickname", vo.getMemberNickname());
			session.setAttribute("memberGubun", "U");
			System.out.println("1111");
		} else {
			// 로그인처리 & 이미 변경한 정보 있을 수 있기때문에 테이블에서 닉네임과 구분 가져와서 setting
			MemberVO gubunVO = memberService.selectKakaoGubun(memberId);
			session.setAttribute("memberId", vo.getMemberId());
			session.setAttribute("memberNickname", gubunVO.getMemberNickname());
			session.setAttribute("memberGubun", gubunVO.getMemberGubun());
			System.out.println("2222");

		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:home.do");
		return mav;

	}

	@RequestMapping(value = "login.do", method = RequestMethod.GET)
	public String loginForm(Locale locale, Model model) {

		return "member/loginForm";
	}

	@RequestMapping(value = "join.do", method = RequestMethod.GET)
	public String joinForm(Locale locale, Model model) {

		return "member/joinForm";
	}

	@RequestMapping(value = "findId.do", method = RequestMethod.GET)
	public String findId(@RequestParam Map<String, Object> map, Model model) {
		return "member/findId";
	}

	@RequestMapping(value = "findPwd.do", method = RequestMethod.GET)
	public String findPwd(Locale locale, Model model) {

		return "member/findPwd";
	}

	@RequestMapping(value = "joinAjax.do", method = RequestMethod.POST)
	public void joinMemberTable(@ModelAttribute MemberVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		memberService.insertMember(vo);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter(); 
		out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='home.do';</script>"); 
		out.flush();
		
	}

	@RequestMapping("idcheckAjax.do")
	@ResponseBody
	public String selectMemberIdCheck(String memberId) throws Exception {
		String message = "";
		int cnt = memberService.selectMemberIdCheck(memberId);
		System.out.println(cnt);
		if (cnt == 0) {
			message = "ok";
		}
		System.out.println(message);
		return message;
	}

	@RequestMapping("nicknamecheckAjax.do")
	@ResponseBody
	public String selectMemberNicknameCheck(String memberNickname) throws Exception {
		String message = "";
		int cnt = memberService.selectMemberNicknameCheck(memberNickname);
		if (cnt == 0) {
			message = "ok";
		}
		return message;
	}

	@RequestMapping("emailcheckAjax.do")
	@ResponseBody
	public String selectMemberEmailCheck(String memberEmail) throws Exception {
		String message = "";
		int cnt = memberService.selectMemberEmailCheck(memberEmail);
		if (cnt == 0) {
			message = "ok";
		}
		return message;
	}
	
	//로그인!!!
	@RequestMapping("loginSubmitAjax.do")
	public @ResponseBody String loginProcessing(MemberVO vo, HttpSession session) throws Exception {
		String msg = "";
		//회원정보VO 가져오기
		MemberVO membervo = memberService.selectMemberCount(vo);
		JSONObject jsonObject = new JSONObject();
		
		if (membervo != null) {
			// 널이 아니면 => 로그인 가능
			// session 생성
			session.setAttribute("memberId", membervo.getMemberId());
			session.setAttribute("memberNickname", membervo.getMemberNickname());
			session.setAttribute("memberGubun", membervo.getMemberGubun());
			session.setAttribute("trainerChatFlag", "N");
			msg = (String) session.getAttribute("returnUrl");
			System.out.println(msg);
			jsonObject.put("sts", "OK");
			jsonObject.put("returnUrl", session.getAttribute("returnUrl"));
		} else {
			// 널이면 회원정보 없는것!
			jsonObject.put("sts", "NO");
		}
		return jsonObject.toString();
	}

	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("memberId");
		session.removeAttribute("memberNickname");
		session.removeAttribute("memberGubun");
		session.removeAttribute("returnUrl");
		return "redirect:home.do";

	}

	@RequestMapping(value = "/sendmailAjax.do")
	@ResponseBody
	public String sendmail(String memberEmail, String emailNum) {
		try {
			testMailer.sendMail(memberEmail, "PROFIT 회원가입 인증메일입니다. 인증번호를 확인해주세요.",
					"안녕하세요 PROFIT 입니다.\n회원님의 인증번호는 " + emailNum + " 입니다.\n 홈페이지에서 이메일 인증번호를 입력하시면 회원가입이 완료됩니다 :) ");
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
		return "ok";
	}

	// 아이디 찾기
	@RequestMapping(value = "findIdAjax.do", produces = "application/text; charset=utf-8")
	public @ResponseBody String selectByFindId(MemberVO vo) throws Exception {

		String id = memberService.selectByFindId(vo);

		JSONObject jsonObject = new JSONObject();

		if (id != null) {
			jsonObject.put("msg", "ok");
			jsonObject.put("id", id);
		} else {
			jsonObject.put("msg", "no");
		}
		String jsonInfo = jsonObject.toString();
		return jsonInfo;
	}

	// 비밀번호 찾기
	@RequestMapping(value = "findPwdAjax.do", produces = "application/text; charset=utf-8")
	public @ResponseBody String selectByFindPwd(MemberVO vo) throws Exception {

		// db에 정보 있는지 확인
		int cnt = memberService.selectByFindPwd(vo);
		
		JSONObject jsonObject = new JSONObject();
		if (cnt == 1) {
			//일단 여기서 ok 메세지 보내기
			jsonObject.put("msg", "ok");
			
			// 임시비밀번호 생성
			String tempPwd = getRamdomPassword(10);
			System.out.println(tempPwd);

			// member테이블에서 임시 비밀번호로 변경
			MemberVO tempVO = new MemberVO();
			tempVO.setMemberId(vo.getMemberId());
			tempVO.setMemberPwd(tempPwd);
			memberService.updateTempPwd(tempVO);

			// 메일보내기
			try {
				testMailer.sendMail(vo.getMemberEmail(), "안녕하세요 PROFIT입니다. 임시 비밀번호를 확인해주세요.",
						"안녕하세요 PROFIT 입니다.\n회원님의 임시비밀번호는 " + tempPwd+ " 입니다."
								+ "\n 임시비밀번호로 로그인 하신 후 내정보에서 비밀번호를 변경해주세요 :) ");
			} catch (Exception e) {
				e.printStackTrace();
				return "fail";
			}
			
			
		}else {
			jsonObject.put("msg", "no");
		}
		String jsonInfo = jsonObject.toString();
		return jsonInfo;
		
	}

	public String getRamdomPassword(int size) {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a',
				'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
				'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&' };
		StringBuffer sb = new StringBuffer();
		SecureRandom sr = new SecureRandom();
		sr.setSeed(new Date().getTime());
		int idx = 0;
		int len = charSet.length;
		for (int i = 0; i < size; i++) {
			idx = sr.nextInt(len);
			sb.append(charSet[idx]);
		}
		return sb.toString();
	}
}
