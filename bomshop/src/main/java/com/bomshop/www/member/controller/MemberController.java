package com.bomshop.www.member.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.member.service.MemberService;
import com.bomshop.www.member.vo.LoginDTO;
import com.bomshop.www.member.vo.MemberAddressVO;
import com.bomshop.www.member.vo.NaverLoginBO;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping("**/member/**")
public class MemberController {
	
	@Inject
	NaverLoginBO naverLoginBO;
	
	@Inject
	MemberService mService;
	
	private String apiResult = null;
	
	
	@GetMapping("login")
	public String loginGet(Model model, HttpSession session,String gno) throws Exception{
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		session.setAttribute("gno", gno);
		model.addAttribute("url", naverAuthUrl);
		return "member/login";
	}
	
	@GetMapping("join")
	public String joinGet() throws Exception{
		return "member/join";
	}
	
	@GetMapping("license")
	public String licenseGet() throws Exception{
		return "member/license";
	}
	
	@GetMapping("naverLogin")
	public String naverLogin() throws Exception{
		return "";
	}
	
	@GetMapping("/join_complete")
	public String joinComplete() throws Exception{
		return "member/join_complete";
	}
	
	@RequestMapping(value="/callbackkakao", method= {RequestMethod.GET, RequestMethod.POST})
	public String callbackkakao(@RequestParam("code") String code) {
		System.out.println(code);
		return "member/login";
	}
	
	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session,
			RedirectAttributes rttr) throws Exception {
		
		System.out.println("naver login success callBack start");
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		
		//1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); //String형식의 json데이터
		/** apiResult json 구조
		{"resultcode":"00",
		"message":"success",
		"response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		**/
		//2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		//3. 데이터 파싱
		//Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		//response의 nickname값 파싱
		String email = (String)response_obj.get("email");
		System.out.println(email);
		//4.파싱 닉네임 세션으로 저장
		// true : member 없음, false : 있음
		boolean isMember = mService.emailCheck(email);
		
		if(isMember) {
			// 새로운 로그인
			// 가입으로
			model.addAttribute("email", email);
			return "member/simple_join";
		}else {
			MemberVO member = mService.getUserById(email);
			session.setAttribute("naverLogin",email); //세션 생성
			rttr.addAttribute("mid", member.getMid());
			rttr.addAttribute("mpw", member.getMpw());
			System.out.println("login Check2");
			return "redirect:/member/loginpost";
		}
		}
		
	
		@PostMapping("googleLogin")
		public String googleLogin(Model model,RedirectAttributes rttr,HttpSession session,String email) throws Exception{
			System.out.println("google : "+email);
			boolean isMember = mService.emailCheck(email);
			
			if(isMember) {
				// 새로운 로그인
				// 가입으로
				model.addAttribute("email", email);
				return "member/simple_join";
			}else {
				MemberVO member = mService.getUserById(email);
				session.setAttribute("googleLogin",email); //세션 생성
				rttr.addAttribute("mid", member.getMid());
				rttr.addAttribute("mpw", member.getMpw());
				return "redirect:/member/loginpost";
			}
		}
	
		@GetMapping("loginpost")
		public String loginpost(String mid, String mpw, Model model) {
			model.addAttribute("mid", mid);
			model.addAttribute("mpw", mpw);
			return "member/loginpost";
		}
		
		//로그아웃
		@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
		public String logout(HttpSession session)throws IOException {
		session.invalidate();
		
		return "redirect:/";
	}
		
		@GetMapping("/idCheck")
		@ResponseBody
		public boolean idCheck(@RequestParam("mid") String mid) throws Exception{
			boolean idCheck = false;
			idCheck = mService.idCheck(mid);
			return idCheck;
		}
		
		@GetMapping("/emailCheck")
		@ResponseBody
		public boolean emailCheck(@RequestParam("memail") String memail) throws Exception{
			boolean emailCheck = false;
			emailCheck = mService.emailCheck(memail);
			return emailCheck;
		}
		
		@PostMapping("/join")
		public String joinPost(
				@RequestParam("zipNo") String zipNo,
				@RequestParam("address1") String addr1,
				@RequestParam("address2") String addr2,
				MemberVO vo,
				RedirectAttributes rttr
				) throws Exception{
			zipNo = zipNo.replaceAll("," , "");
			System.out.println(zipNo);
			System.out.println(zipNo+","+addr1+","+addr2);
			System.out.println(vo);
			boolean isJoin = false;
			
			// service
			isJoin = mService.addMember(vo,zipNo,addr1,addr2);
			
			if(isJoin) {
				rttr.addAttribute("isJoin", true);
			}else {
				rttr.addAttribute("isJoin", false);
			}
			
			return "redirect:/member/join_complete";
		}
		
		@GetMapping("simple_join")
		public String simple_join(String email,Model model) {
			model.addAttribute("email", email);
			return "simple_join";
		}
		
		@PostMapping("loginPost")
		public ModelAndView loginPost(
				LoginDTO dto,
				ModelAndView mav
				) throws Exception{
			System.out.println("loginController");
			mav.addObject("loginDTO", dto);
			//mav.setViewName("redirect:/");
			return mav;
		}
		
		@PostMapping(value="/updateAll" ,produces = "application/text; charset=utf8")
		@ResponseBody
		public String updateAll(int mno, String memail, String mpw) throws Exception{
			String msg = mService.updateAll(mno, memail,mpw);
			return msg;
		}
		
		@PostMapping(value="updatePassword",produces = "application/text; charset=utf8")
		@ResponseBody
		public String updatePassword(int mno,String mpw) throws Exception{
			String msg = mService.updatePassword(mno,mpw);
			return msg;
			
		}
		
		@PostMapping(value="updatePasswordUsingID",produces = "application/text;charset=utf-8")
		@ResponseBody
		public String updatePasswordUsingID(String mid,String mpw) throws Exception{
			String msg = mService.updatePasswordUsingID(mid,mpw);
			return msg;
		}
		
		@PostMapping("addAddrInfo")
		@ResponseBody
		public List<MemberAddressVO> addAddrInfo(MemberAddressVO vo) throws Exception{
			mService.addAddrInfo(vo);
			return mService.getAddrList(vo.getMno());
		}
		
		@PostMapping("addrDelete")
		@ResponseBody
		public List<MemberAddressVO> addrDelete(int mno,String memo) throws Exception{
			mService.deleteAddr(mno,memo);
			return mService.getAddrList(mno);
		}
		
		@PostMapping("setMainAddr")
		@ResponseBody
		public List<MemberAddressVO> setMainAddr(int mno, String memo) throws Exception{
			mService.setMainAddr(mno,memo);
			return mService.getAddrList(mno);
		}

}