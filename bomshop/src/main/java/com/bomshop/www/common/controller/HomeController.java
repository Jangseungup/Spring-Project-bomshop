package com.bomshop.www.common.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bomshop.www.common.service.HeaderService;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.goods.service.GoodsService;

@Controller
public class HomeController {
	
	@Inject
	GoodsService gs;
	
	@Inject
	HeaderService hs;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		//return "redirect:/goods/main";
		// 신상품 목록
		model.addAttribute("list", gs.list(cri));
		// 베스트 목록
		model.addAttribute("best_list", gs.best_list(cri));
		// 광고 목록
		model.addAttribute("gnoList", gs.getAdvertise());
		/* model.addAttribute("pageMaker",gs.getPageMaker(cri)); */
		return "home";
	}
	
	@GetMapping("/getBrandList")
	@ResponseBody
	public List<String> getBrandList() throws Exception{
		return hs.getBrandList();
	}
	
}
