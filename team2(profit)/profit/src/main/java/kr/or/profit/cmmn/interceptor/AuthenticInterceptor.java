package kr.or.profit.cmmn.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticInterceptor extends HandlerInterceptorAdapter {

	/**
	 * 세션에 계정정보(Account)가 있는지 여부로 인증 여부를 체크한다. 계정정보(Account)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 로그인 세션이 없다면 login 페이지로 이동
		String id = (String) request.getSession().getAttribute("memberId");
		String requestUrl = request.getRequestURL().toString();
		String contextPath = request.getContextPath();

//		System.out.println(request.getRequestURL());
//		System.out.println(request.getRequestURL());
//		System.out.println(request.getRequestURL());
//		System.out.println(request.getRequestURL());
//		System.out.println(request.getRequestURL());
//		System.out.println(request.getRequestURL());
//		System.out.println(request.getQueryString());

		Enumeration<String> params = request.getParameterNames();
		StringBuilder url = new StringBuilder();
		
		url.append(request.getContextPath());
		System.out.println(request.getContextPath());
		
		if(request.getServletPath() == null) {
			request.getSession().setAttribute("returnUrl", url.toString());
		}
		
		
		url.append(request.getServletPath());
		
		System.out.println(request.getServletPath());
		url.append("?");
		url.append(request.getQueryString());
		
		System.out.println(request.getQueryString());
		
//		while (params.hasMoreElements()) {
//			String key = (String) params.nextElement();
//
//			String urlParam = String.format("%s=%s", key, request.getParameter(key));
//			url.append(urlParam);
//
//			System.out.println(url.toString());
//
//		}
		System.out.println(url.toString());
		
		request.getSession().setAttribute("returnUrl", url.toString());

		// 로그인 경로 제외
		if (requestUrl.contains(contextPath + "/login.do")) {
			return true;
		}

		// 리소스 경로 제외
		if (requestUrl.contains(contextPath + "/resources")) {
			return true;
		}

		if (id == null) {
			response.sendRedirect(contextPath + "/login.do");
			return false;
		}

		return true;
	}


}
