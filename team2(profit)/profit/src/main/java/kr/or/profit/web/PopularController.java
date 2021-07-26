package kr.or.profit.web;

import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.profit.service.PopularService;
import kr.or.profit.vo.PopularVO;

/**
 * 
 * Handles requests for the application home page.
 */
@Controller
public class PopularController {
	
	@Resource(name = "popularService")
	private PopularService popularService;


	@RequestMapping(value = "Add", method = RequestMethod.GET)
	public String addSampleView(@ModelAttribute("popularVO") PopularVO popularVO, Model model) throws Exception {
		popularService.insertPopular(popularVO);
		return "main/home";
	}
	
}