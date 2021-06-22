package com.olive.olive.tips;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.olive.olive.common.FileManager;
import com.olive.olive.common.MyUtil;
import com.olive.olive.member.SessionInfo;

@Controller("tips.tipsController")
@RequestMapping("/tips/*")
public class TipsController {
	@Autowired
	private TipsService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,			
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		if(dataCount != 0)
			total_page = myUtil.pageCount(rows, dataCount);
		
		if(total_page<current_page)
			current_page = total_page;
		
		int offset = (current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Tips> list = service.listTips(map);
		
		int listNum, n = 0;
		for(Tips dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}
		
		String query="";
		String list_url=cp+"/tips/list";
		String articleUrl=cp+"/tips/article?page="+current_page;
		if(keyword.length()!=0) {
			query="condition="+condition+
					"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length()!=0) {
			list_url=cp+"/tips/list?"+query;
			articleUrl=cp+"/tips/article?page="+current_page+"&"+query;
		}
		
		String paging = myUtil.paging(current_page, total_page, list_url);
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("paging",paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		model.addAttribute("menuIndex", 2);
		
		return ".tips.list";
	}
	
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String createdForm(
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		model.addAttribute("menuIndex", 2);
		return ".tips.created";
	}
	
	@RequestMapping(value="/tips/created", method=RequestMethod.POST)
	public String createdSubmit(
			Tips dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"tips";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertTips(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/tips/list";
	}
	
	@RequestMapping(value="article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		service.updateHitCount(num);
		
		Tips dto = service.readTips(num);
		if(dto==null)
			return "redirect:/tips/list?"+query;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);
		
		Tips preReadDto = service.preReadTips(map);
		Tips nextReadDto = service.nextReadTips(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("menuIndex", 2);
		
		return ".tips.article";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Tips dto = service.readTips(num);
		if(dto==null) {
			return "redirect:/tips/list?page="+page;
		}
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/tips/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("menuIndex", 2);

		return ".tips.created";
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Tips dto,
			@RequestParam String page,
			HttpSession session) throws Exception{
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"tips";
		
		try {
			service.updateTips(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/tips/list?page="+page;
	}
	
	public String deleteFile(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"tips";
		
		Tips dto = service.readTips(num);
		if(dto==null) {
			return "redirect:/tips/list?page="+page;
		}
		
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/tips/list?page="+page;
		}
		
		try {
			if(dto.getSaveFilename()!=null) {
				fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				dto.setSaveFilename("");
				dto.setOriginalFilename("");
				service.updateTips(dto, pathname);
			}
		} catch (Exception e) {
		}
		
		return "redirect:/tips/update?num="+num+"&page="+page;
	}
	
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"tips";
		
		service.deleteTips(num, pathname, info.getUserId());
		
		return "redirect:/tips/list?"+query;
	}
	
	@RequestMapping(value="download")
	public void download(
			@RequestParam int num,
			HttpServletRequest req,
			HttpServletResponse resp,
			HttpSession session
			) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"tips";
		
		Tips dto = service.readTips(num);
		
		if(dto!=null) {
			boolean b=fileManager.doFileDownload(dto.getSaveFilename(), dto.getOriginalFilename(), pathname, resp);
		
			if(b) return;
		}
		
		resp.setContentType("text/html);charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print("<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>");
	}
	
	@RequestMapping(value="insertTipsLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertTipsLike(
			@RequestParam int num,
			HttpSession session
			) {
		String state="true";
		int tipsLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		try {
			service.insertTipsLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		tipsLikeCount = service.tipsLikeCount(num);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("tipsLikeCount", tipsLikeCount);
		
		return model;
	}
	
}
