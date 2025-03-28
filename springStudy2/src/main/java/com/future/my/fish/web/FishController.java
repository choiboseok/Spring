package com.future.my.fish.web;

import java.util.ArrayList;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.future.my.fish.service.FishService;
import com.future.my.fish.vo.FishVO;

@Controller
public class FishController {
	@Autowired
	FishService fishService;
	
//	@ModelAttribute("List")
//	public ArrayList<FishVO> getList(){
//		return fishService.getInfo();
//	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		ArrayList<FishVO> arr = fishService.getInfo();
		model.addAttribute("arr", arr );
		return "home";
	}
}