package com.future.my.member.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.future.my.common.valid.Regist;
import com.future.my.common.vo.MessageVO;
import com.future.my.member.service.MemberService;
import com.future.my.member.vo.MemberVO;

@Controller // 사용자 요청을 받았을때는 이런식으로 어노테이션 선언
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Value("#{util['file.upload.path']}")
	private String CURR_IMAGE_PATH;
	
	@Value("#{util['file.download.path']}")
	private String WEB_PATH;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping("/registView") // 사용자 요청 URL(경로)
	public String registView(Model model, @ModelAttribute("member")MemberVO member) {
		
		return "member/registView";
	}
	
	@RequestMapping("/loginView") // 사용자 요청 URL(경로)
	public String loginView() {
		
		return "member/loginView";
	}
	
	@RequestMapping("/loginDo") // 사용자 요청 URL(경로)
	public String loginDo(MemberVO vo, HttpSession session, boolean remember, HttpServletResponse res) throws Exception {
		MemberVO user = null;
		user = memberService.loginMember(vo);
		// 사용자 입력 vo.getmemPw 비밀번호와 user.getMempw의 비밀번호가 일치하면 true, 않으면 false
		boolean match = passwordEncoder.matches(vo.getMemPw(), user.getMemPw());
		if(user == null || !match) {
			return "redirect:/loginView";
			}
		session.setAttribute("login", user);
		if(remember) {
			// 쿠키 생성
			Cookie cookie = new Cookie("rememberId", user.getMemId());
			res.addCookie(cookie);
		} else {
			Cookie cookie = new Cookie("rememberId", "");
			cookie.setMaxAge(0); // 유효시간을 0으로
			res.addCookie(cookie);
			
		}
		
		return "redirect:/";
	}
	
	
	@RequestMapping("/registDo") // 사용자 요청 URL(경로)
	public String registDo( Model model, @Validated(Regist.class) @ModelAttribute("member")MemberVO member, BindingResult result) {
		if(result.hasErrors()) {
//			@Validated 조건에 맞지 않으면 True 
			return "member/registView";
		}
		MessageVO msgVO = null;
		System.out.println(member);
		try {
			member.setMemPw(passwordEncoder.encode(member.getMemPw()));
			memberService.registMember(member);
		} catch (DuplicateKeyException e) {
			msgVO = new MessageVO(false, "회원가입", "중복 아이디 입니다.", "/registView", "회원가입");
			model.addAttribute("msgVO", msgVO);
			model.addAttribute("member", new MemberVO());
			
			return "member/registView";
		} catch (DataAccessException e) {
			msgVO = new MessageVO(false, "회원가입", "잘못된 입력입니다.", "/registView", "회원가입");
			model.addAttribute("msgVO", msgVO);
			model.addAttribute("member", new MemberVO());
			
			return "member/registView";
		} catch (Exception e) {
			msgVO = new MessageVO(false, "회원가입", "시스템에 문의하세요", "/registView", "회원가입");
			e.printStackTrace();
			model.addAttribute("msgVO", msgVO);
			model.addAttribute("member", new MemberVO());
			
			return "member/registView";
		}
		msgVO = new MessageVO(true, "회원가입", "회원가입 성공", "/loginView", "로그인");
		model.addAttribute("msgVO", msgVO);
		
		return "home";
	}
	
	@RequestMapping("/logoutDo") // 사용자 요청 URL(경로)
	public String logoutDo(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		System.out.println(CURR_IMAGE_PATH);
		if(session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		
		return "member/mypage";
	}
	
	@ResponseBody
	@PostMapping("/files/upload")
	public Map<String, Object> uploadFiles(HttpSession session, @RequestParam("uploadImage") MultipartFile file) throws Exception{ // MultipartFile 파일 형태로 받기
		
		MemberVO vo = (MemberVO)session.getAttribute("login");
		System.out.println(file);
		
		String imgPath = memberService.profileUpload(vo, CURR_IMAGE_PATH, WEB_PATH, file);
		Map<String, Object> map = new HashMap<>();
		map.put("message", "success");
		map.put("imagePath", imgPath);
		
		return map;
	}
}