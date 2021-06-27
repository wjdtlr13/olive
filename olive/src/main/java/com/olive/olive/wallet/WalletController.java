package com.olive.olive.wallet;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.olive.olive.common.MyUtil;
import com.olive.olive.member.SessionInfo;

@Controller("wallet.walletController")
@RequestMapping("/wallet/*")
public class WalletController {
	@Autowired
	private WalletService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("{menuItem}/list")
	public String list(
			@PathVariable String menuItem,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="0") int categoryNum,
			@RequestParam(defaultValue="") String startDate,
			@RequestParam(defaultValue="") String endDate,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		
   	    String cp = req.getContextPath();
   	    
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String gubun = "수입";
		if(menuItem.equals("expense")) {
			gubun = "지출";
		}
		
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", info.getUserId());
        map.put("gubun", gubun);
        map.put("categoryNum", categoryNum);
        map.put("startDate", startDate);
        map.put("endDate", endDate);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);

        // 글 리스트
        List<Wallet> list = service.listWallet(map);
       
        String query="";
        if(categoryNum!=0)
        	query="categoryNum="+categoryNum;
        if(startDate.length() != 0 && endDate.length() != 0 ) {
        	if(query.length() != 0)
        		query += "&";
        	query += "startDate="+startDate+"&endDate="+endDate;
        }
        
        String listUrl = cp+"/wallet/"+menuItem+"/list";
        if(query.length() != 0)
        	listUrl += "?" + query;
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
        
        List<Wallet> listCategory = service.listCategory(gubun);        

        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
        model.addAttribute("listCategory", listCategory);
        model.addAttribute("categoryNum", categoryNum);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        
		model.addAttribute("menuItem", menuItem);
		model.addAttribute("menuIndex", 5);
		
		return ".wallet.list";
	}
	
	@RequestMapping(value = "{menuItem}/insert", method = RequestMethod.GET)
	public String insertForm(
			@PathVariable String menuItem,
			Model model
			) throws Exception {
		
		String gubun = "수입";
		if(menuItem.equals("expense")) {
			gubun = "지출";
		}
		
		Calendar cal = Calendar.getInstance();
		String now = String.format("%tF", cal);
		
		List<Wallet> listCategory = service.listCategory(gubun);
		
		model.addAttribute("mode", "insert");
		model.addAttribute("now", now);
		model.addAttribute("listCategory", listCategory);
		
		model.addAttribute("menuItem", menuItem);
		model.addAttribute("menuIndex", 5);
		
		return ".wallet.write";
	}
	
	@RequestMapping(value = "{menuItem}/insert", method = RequestMethod.POST)
	public String insertSubmit(
			@PathVariable String menuItem,
			Wallet dto,
			HttpSession session,
			Model model
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		try {
			dto.setUserId(info.getUserId());
			service.insertWallet(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/wallet/"+menuItem+"/list";
	}
	
	@RequestMapping(value = "{menuItem}/update", method = RequestMethod.GET)
	public String updateForm(
			@PathVariable String menuItem,
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		String gubun = "수입";
		if(menuItem.equals("expense")) {
			gubun = "지출";
		}
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("userId", info.getUserId());
		Wallet dto = service.readWallet(map);
		if(dto == null) {
			return "redirect:/wallet/"+menuItem+"/list?page="+page;
		}
		
		List<Wallet> listCategory = service.listCategory(gubun);
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("listCategory", listCategory);
		
		model.addAttribute("menuItem", menuItem);
		model.addAttribute("menuIndex", 5);
		
		return ".wallet.write";
	}
	
	@RequestMapping(value = "{menuItem}/update", method = RequestMethod.POST)
	public String updateSubmit(
			@PathVariable String menuItem,
			Wallet dto,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		try {
			dto.setUserId(info.getUserId());
			service.updateWallet(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/wallet/"+menuItem+"/list?page="+page;
	}
	
	@RequestMapping(value = "{menuItem}/delete")
	public String delete(
			@PathVariable String menuItem,
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("userId", info.getUserId());

		service.deleteWallet(map);
		
		return "redirect:/wallet/"+menuItem+"/list?page="+page;
	}
	
	// 스터티스틱스
	@RequestMapping("stats")
	public String statistics (
			HttpSession session,			
			Model model
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Calendar cal = Calendar.getInstance();
		String date = String.format("%tF", cal);
		
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", info.getUserId());
        map.put("date", date);
        
        map.put("gubun", "수입");
        Wallet dayIncome = service.dayStatistics(map);
        Wallet monthIncome = service.monthStatistics(map);
        
        map.put("gubun", "지출");
        Wallet dayAxpense = service.dayStatistics(map);
        Wallet monthAxpense = service.monthStatistics(map);

		String [] week = {"일","월","화","수","목","금","토"};
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DATE);
		int w = cal.get(Calendar.DAY_OF_WEEK);
		
		String monthTitle = String.format("%04d. %02d", year, month);
		String dayTitle = String.format("%04d. %02d. %02d (%s) ", year, month, day, week[w-1]);
        
		model.addAttribute("dayIncome", dayIncome);
		model.addAttribute("monthIncome", monthIncome);

		model.addAttribute("dayAxpense", dayAxpense);
		model.addAttribute("monthAxpense", monthAxpense);

		model.addAttribute("date", date);
		model.addAttribute("monthTitle", monthTitle);
		model.addAttribute("dayTitle", dayTitle);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("day", day);
		
		model.addAttribute("menuItem", "statistics");
		model.addAttribute("menuIndex", 5);
		
		return ".wallet.stats";
	}
	
	
	@RequestMapping("statsMonth")
	@ResponseBody
	public Map<String, Object> statsMonth(
			@RequestParam int year,
			@RequestParam int month,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Calendar cal = Calendar.getInstance();
		cal.set(year, month-1, 1);
		String date = String.format("%tF", cal);
		
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", info.getUserId());
        map.put("date", date);
        
        map.put("gubun", "수입");
        Wallet monthIncome = service.monthStatistics(map);
        
        map.put("gubun", "지출");
        Wallet monthAxpense = service.monthStatistics(map);
		
		year = cal.get(Calendar.YEAR);
		month = cal.get(Calendar.MONTH) + 1;
		String monthTitle = String.format("%04d. %02d", year, month);		
		
		 Map<String, Object> model= new HashMap<String, Object>();
		 
		 model.put("monthIncome", monthIncome);
		 model.put("monthAxpense", monthAxpense);
		 
		 model.put("year", year);
		 model.put("month", month);
		 model.put("monthTitle", monthTitle);
		 
		 return model;
	}
	
	@RequestMapping("statsDay")
	@ResponseBody
	public Map<String, Object> statsDay(
			@RequestParam int year,
			@RequestParam int month,
			@RequestParam int day,
			HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Calendar cal = Calendar.getInstance();
		cal.set(year, month-1, day);
		String date = String.format("%tF", cal);
		
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", info.getUserId());
        map.put("date", date);
        
        map.put("gubun", "수입");
        Wallet dayIncome = service.dayStatistics(map);
        
        map.put("gubun", "지출");
        Wallet dayAxpense = service.dayStatistics(map);
		
        String [] week = {"일","월","화","수","목","금","토"};
		year = cal.get(Calendar.YEAR);
		month = cal.get(Calendar.MONTH)+1;
		day = cal.get(Calendar.DATE);
		int w = cal.get(Calendar.DAY_OF_WEEK);
		String dayTitle = String.format("%04d. %02d. %02d (%s) ", year, month, day, week[w-1]);	
		
		 Map<String, Object> model= new HashMap<String, Object>();
		 
		 model.put("dayIncome", dayIncome);
		 model.put("dayAxpense", dayAxpense);
		 
		 model.put("year", year);
		 model.put("month", month);
		 model.put("day", day);
		 model.put("dayTitle", dayTitle);
		 
		 return model;
	}
}
