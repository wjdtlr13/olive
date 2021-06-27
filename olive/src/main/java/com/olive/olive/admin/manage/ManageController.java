package com.olive.olive.admin.manage;

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
  
@Controller("admin.manageController")
@RequestMapping("/admin/memManage/*")
public class ManageController { 
	
	@Autowired
	private MemberSerivce service;
	
	@Autowired
	private MyUtil myUtil;
	
	//회원정보 리스트 
	@RequestMapping(value = "memList")
	public String listMember(
			@RequestParam(value = "page" ,defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath(); //경로 
		
		int rows=5;
		int total_page=0;
		int dataCount =0;
		
		//equalsIgnoreCase : keyword는 대소문자 구분을 안한다.
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword,"utf-8");
		}
		
		//전체 페이지 수 
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("keyword", keyword);
		map.put("condition", condition);

		
		//데이터 개수 가져와야 함
		dataCount = service.dataCount(map);
		if(dataCount!=0) {
			//전체 페이지 수 
			total_page=myUtil.pageCount(rows, dataCount);
		}
		

		
		if(current_page > total_page ) {
			current_page=total_page;
		}
		

		//데이터 가져오기
		int offset = (current_page-1)*rows;
		if(offset <0) {
			offset =0;
		}
		
		map.put("offset", offset);
		map.put("rows", rows);
		
		
		//회원 리스트 뿌려주기
		List<Member> list = service.listMember(map);
		
		//리스트 번호 가져오기- 각 게시물 번호?
		int listNum, n=0;
		for(Member dto :list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		//리스트 뿌려줄 페이지 주소 
		String query ="";
		String listUrl=cp+"admin/memManage/memList";
		//회원 상세조회
		String detailUrl=cp+"/admin/memManage/memDetail?page="+current_page;

		//검색 키워드 존재 시 => 검색하게되면 쿼리는 다음과 같다. 단 키워드는 인코딩하여 보내야 함
		if(keyword.length()!=0) {
			query ="condition="+condition+"&keyword="+URLEncoder.encode(keyword,"utf-8");
		}
		

		//검색 시 cp+"admin/memManage/memList"?condition=~~이렇게 붙음
		if(query.length()!=0) {
			listUrl = listUrl +"?"+query;
			detailUrl=cp+"/admin/memManage/memDetail?page="+current_page+"&"+query;
		}
		
		String paging =myUtil.paging(current_page, total_page, listUrl);
		
        model.addAttribute("list", list);

        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		

		return ".admin.memManage.memList";
	}
	
	

	
	//회원정보 상세리스트
	@RequestMapping("memDetail")
	public String detailListMember(
			@RequestParam String userId,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model
			) throws Exception {
		keyword = URLDecoder.decode(keyword,"utf-8");
		
		String query="page="+page;

		
		
		Member dto = service.readMember(userId);
		
		model.addAttribute("dto",dto);
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		
		
		return ".admin.memManage.memDetail";
	}
	//t신고 입력 
	@PostMapping("insert")
	public Map<String, Object> insertSubmit(Block dto, HttpSession session) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state ="true";
		
		try {
			dto.setBlockReqId(info.getUserId());
			service.insertBlock(dto); 
		} catch (Exception e) {
			state ="true";
			
			
		}
		Map<String , Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
	
	
	//신고회원리스트
	@RequestMapping("blockList")
	public String blockList(
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(value = "page" ,defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath(); //경로 
		
		int rows=15;
		int total_page=0;
		int dataCount =0;
		
		//equalsIgnoreCase : keyword는 대소문자 구분을 안한다.
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword,"utf-8");
		}
		
		//전체 페이지 수 
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("keyword", keyword);
		map.put("condition", condition);

		
		//데이터 개수 가져와야 함
		dataCount = service.dataCount(map);
		if(dataCount!=0) {
			//전체 페이지 수 
			total_page=myUtil.pageCount(rows, dataCount);
		}
		

		
		if(current_page > total_page ) {
			current_page=total_page;
		}
		

		//데이터 가져오기
		int offset = (current_page-1)*rows;
		if(offset <0) {
			offset =0;
		}
		
		map.put("offset", offset);
		map.put("rows", rows);
		
		
		//신고회원리스트 뿌려주기
		List<Block> list = service.blockList(map);
		
		
		//리스트 번호 가져오기- 각 게시물 번호?
		int listNum, n=0;
		for(Block dto :list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		//리스트 뿌려줄 페이지 주소 
		String query ="";
		String listUrl=cp+"admin/memManage/blockList";
		//검색 키워드 존재 시 => 검색하게되면 쿼리는 다음과 같다. 단 키워드는 인코딩하여 보내야 함
		if(keyword.length()!=0) {
			query ="condition="+condition+"&keyword="+URLEncoder.encode(keyword,"utf-8");
		}
		


		String paging =myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("blockList" , list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page",current_page);
		model.addAttribute("total_page",total_page);
		model.addAttribute("paging",paging);
		model.addAttribute("condition",condition);
		model.addAttribute("keyword",keyword);
			
		
		
		
		
		return ".admin.memManage.blockList";
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
