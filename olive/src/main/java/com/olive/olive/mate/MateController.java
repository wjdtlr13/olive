package com.olive.olive.mate;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.olive.olive.common.MyUtil;
import com.olive.olive.member.SessionInfo;

@Controller("olive.mateController")
@RequestMapping("/mate/*")
public class MateController {
	
	@Autowired
	private MateService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("store")
	public String home() {
		return ".mate.home";
	}
	
	@RequestMapping("select")
	public String getSelect(
			HttpSession session,
			Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
        String userId = info.getUserId();
		String address = service.getAddress(userId);
		if(address==null) {
			model.addAttribute("address", "서울시 은평구 구산동");
			return ".mate.select";}
		String[] array = address.split(" ");
		address = array[0]+" "+array[1]+" "+array[2];
		model.addAttribute("address", address);
		return ".mate.select";
	}
	
	@RequestMapping("list")
	public String mainReq() {
		return ".mate.requestHome";
	}
	
	@PostMapping("register")
	public String goRegister(
			@RequestParam String eating_name,
			@RequestParam String eating_address,
			@RequestParam String eating_tel,
			@RequestParam String eating_url,
			@RequestParam int categoryNum,
			Model model) {
		model.addAttribute("eating_name", eating_name);
		model.addAttribute("eating_address", eating_address);
		model.addAttribute("eating_tel", eating_tel);
		model.addAttribute("eating_url", eating_url);
		model.addAttribute("categoryNum", categoryNum);
		return "/mate/register";
	}
	
	@PostMapping("registerSubmit")
	public String registerSubmit(
			@RequestParam String eating_name,
			@RequestParam String eating_address,
			@RequestParam String eating_tel,
			@RequestParam String eating_url,
			@RequestParam String eating_date,
			@RequestParam String eating_time,
			@RequestParam String mate_introduce,
			@RequestParam String mate_kind,
			@RequestParam String mate_etc,
			@RequestParam String userId,
			@RequestParam int categoryNum) {
		Mate mate = new Mate();
		Register register = new Register();
		
		mate.setMate_etc(mate_etc);
		mate.setMate_introduce(mate_introduce);
		mate.setMate_kind(mate_kind);
		mate.setUserId(userId);
		
		register.setEating_address(eating_address);
		register.setEating_date(eating_date);
		register.setEating_time(eating_time);
		register.setEating_name(eating_name);
		register.setEating_url(eating_url);
		register.setEating_tel(eating_tel);
		register.setCategoryNum(categoryNum);

		try {
			service.insertMate(mate);
			int mateNum = service.insertMate(mate);
			register.setMate_regi_num(mateNum);
			try {
				service.insertMate_Register(register);
				return "/mate/success";
			} catch (Exception e) {
				service.deleteMate(mateNum);
				e.printStackTrace();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/mate/failure";
	}
	
	@RequestMapping("deleteRegister")
	public String deleteRegister(
			@RequestParam(required=false) int mate_reg_num,
			@RequestParam(required=false) int mate_regi_num,
			@RequestParam String mode,
			@RequestParam String readMode,
			@RequestParam int page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mate_reg_num", mate_reg_num);
		map.put("mate_regi_num", mate_regi_num);
		try {
			service.deleteMate_Register(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String query = "mode="+readMode+"&page="+page;
		return "redirect:/mate/registerList?"+query;
	}
	
	@RequestMapping("registerList")
	public String registerList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(required=false) String categoryNum,
			@RequestParam(defaultValue="upcoming") String mode,
			HttpSession session,
			HttpServletRequest req,
			Model model) throws Exception {
		
   	    String cp = req.getContextPath();
   	    
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		
		System.out.println(mode);
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		// 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
		
		if(categoryNum!=null) {
			int cNum = Integer.parseInt(categoryNum);
        	map.put("categoryNum", cNum);}
        
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);

        // 글 리스트
        SessionInfo info=(SessionInfo)session.getAttribute("member");
        String userId = info.getUserId();
        map.put("userId", userId);
        map.put("mode", mode);
		
        
        List<Register> list = null;
        
        try {
			if(!mode.equals("available"))
				list = service.listMyRegister(map);
			else
				list=service.listRegister(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        
        // 리스트의 번호
        int listNum, n = 0;
        for(Register dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/mate/requestList";
        query+="mode="+mode;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        	if(categoryNum!=null) {
        		query+="&categoryNum="+categoryNum;
        	}
        } else if(categoryNum!=null) {
        	query="categoryNum="+categoryNum;
        }
         
        
        if(query.length()!=0) {
        	listUrl = cp+"/mate/registerList?" + query;
        	//articleUrl = cp+"/free/article?page=" + current_page + "&"+ query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
        
        List<Category> categoryList = service.listCategory();

        model.addAttribute("list", list);
        //model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("categoryNum", categoryNum);
        model.addAttribute("mode", mode);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".mate.registerList";
	}
	
	@RequestMapping("requestList")
	public String requestList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(required=false) String categoryNum,
			HttpSession session,
			HttpServletRequest req,
			Model model) throws Exception {
		
   	    String cp = req.getContextPath();
   	    
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		// 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
		
		if(categoryNum!=null) {
			int cNum = Integer.parseInt(categoryNum);
        	map.put("categoryNum", cNum);}
        
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);

        // 글 리스트
        SessionInfo info=(SessionInfo)session.getAttribute("member");
        String userId = info.getUserId();
        
        map.put("userId", userId);
		
        List<Request> list = null;
        
        try {
			list = service.listRequest(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        // 리스트의 번호
        int listNum, n = 0;
        for(Request dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/mate/requestList";
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        	if(categoryNum!=null) {
        		query+="&categoryNum="+categoryNum;
        	}
        } else if(categoryNum!=null) {
        	query="categoryNum="+categoryNum;
        }
         
        
        if(query.length()!=0) {
        	listUrl = cp+"/mate/requestList?" + query;
        	//articleUrl = cp+"/free/article?page=" + current_page + "&"+ query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        //model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".mate.registerList";
	}
	
	@RequestMapping("article")
	public String article(
			@RequestParam int mate_reg_num,
			@RequestParam int page,
			@RequestParam String mode,
			HttpSession session,
			Model model) {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
        String myUserId = info.getUserId();
        
        Register dto = service.readMate_Register(mate_reg_num);
        String userId = dto.getUserId();
        String reg_userId=dto.getReg_userId();
        model.addAttribute("dto", dto);
        if(myUserId.equals(userId)) 
        	model.addAttribute("mode", "mine");
        else if(!myUserId.equals(reg_userId)) {
        	if(myUserId.equals(reg_userId))
        		model.addAttribute("mode", "requested");
        	else
        		model.addAttribute("mode", "available");
        }
        else
        	model.addAttribute("mode", "mine");
        model.addAttribute("page", page);
        model.addAttribute("readMode", mode);
        return ".mate.article";
        
	}
	
	@RequestMapping("insertRequest")
	public String insertRequest(
			Request dto,
			HttpSession session,
			Model model) {
			
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			Mate mate = new Mate();
			mate.setMate_etc(dto.getMate_etc());
			mate.setMate_introduce(dto.getMate_introduce());
			mate.setMate_kind(dto.getMate_kind());
			mate.setUserId(info.getUserId());
			int mateNum =  service.insertMate(mate);
			dto.setMate_num(mateNum);
			service.insertMate_Request(dto);
		} catch (Exception e) {
			return "/mate/failure";
		}
		
		return "redirect:/mate/requestList";
	}
	
}
