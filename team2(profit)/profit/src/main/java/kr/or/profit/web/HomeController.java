package kr.or.profit.web;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;


/**
 * 
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "home.do", method = RequestMethod.GET)
	public String home() {
		return "main/home";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(Locale locale, Model model) {
		System.out.println("여기");
		return "main/home";
	}
	@RequestMapping(value = "aboutUs.do", method = RequestMethod.GET)
	public String aboutUs(Locale locale, Model model) {
		
		return "aboutUs";
	}	
	@RequestMapping(value = "blog.do", method = RequestMethod.GET)
	public String blog(Locale locale, Model model) {
		
		return "blog";
	}	
	@RequestMapping(value = "blogDetail.do", method = RequestMethod.GET)
	public String blogDetail(Locale locale, Model model) {
		
		return "blogDetail";
	}	
	@RequestMapping(value = "classes.do", method = RequestMethod.GET)
	public String classes(Locale locale, Model model) {
		return "classes";
	}	
	@RequestMapping(value = "classesDetail.do", method = RequestMethod.GET)
	public String classesDetail(Locale locale, Model model) {
		
		return "classesDetail";
	}	
	@RequestMapping(value = "contact.do", method = RequestMethod.GET)
	public String contact(Locale locale, Model model) {
		
		return "contact";
	}	
	@RequestMapping(value = "faq.do", method = RequestMethod.GET)
	public String faq(Locale locale, Model model) {
		
		return "faq";
	}
	@RequestMapping(value = "pricing.do", method = RequestMethod.GET)
	public String pricing(Locale locale, Model model) {
		
		return "pricing";
	}
}
