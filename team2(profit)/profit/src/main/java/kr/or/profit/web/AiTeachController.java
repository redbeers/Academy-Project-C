//package kr.or.profit.web;
//
//import java.util.Locale;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//
//import java.io.File;
//import java.util.ArrayList;
//import java.util.Enumeration;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
// 
//import javax.servlet.http.HttpServletResponse;
// 
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.multipart.MultipartHttpServletRequest;
//import org.springframework.web.servlet.ModelAndView;
//
//
//import org.python.util.PythonInterpreter;
//
///**
// * 
// * Handles requests for the application home page.
// */
//@Controller
//public class AiTeachController {
//	
//	private static PythonInterpreter interpreter;
//	private static final Logger logger = LoggerFactory.getLogger(AiTeachController.class);
//
//	/**
//	 * Simply selects the home view to render by returning its name.
//	 */
//	@RequestMapping(value = "aiTeachList", method = RequestMethod.GET)
//	public String aiTeachList(Locale locale, Model model) {
//
//		return "aiTeach/aiTeachList";
//	}
//	
//	@RequestMapping(value = "aiTeachDetail", method = RequestMethod.GET)
//	public String aiTeachDetail(Locale locale, Model model) {
//		interpreter = new PythonInterpreter();
//        interpreter.exec("from java.lang import System");
//        interpreter.exec("s = 'Hello World'");
//        interpreter.exec("System.out.println(s)");
//        interpreter.exec("print(s)");
//        interpreter.exec("print(s[1:-1])");
//        
//		return "aiTeach/aiTeachDetail";
//	}
//	
//	@RequestMapping(value = "aiTeachAdd", method = RequestMethod.GET)
//	public String aiTeachAdd(Locale locale, Model model) {
//
//		return "aiTeach/aiTeachAdd";
//	}
//	
//	@RequestMapping(value = "test111", method = RequestMethod.GET)
//	public String test111(Locale locale, Model model) {
//
//		return "aiTeach/test111";
//	}
//
//}