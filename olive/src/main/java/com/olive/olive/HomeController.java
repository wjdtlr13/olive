package com.olive.olive;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return ".home";
	}    
	
	@RequestMapping(value = "/note", method = RequestMethod.GET)
	public String note(Locale locale, Model model) {
		
		return ".note";
	}   
	
	@RequestMapping(value = "/a", method = RequestMethod.GET)
	public String a(Locale locale, Model model) {
		
		return ".1";
	}   
	@RequestMapping(value = "/b", method = RequestMethod.GET)
	public String b(Locale locale, Model model) {
		
		return ".2";
	}    @RequestMapping(value = "/c", method = RequestMethod.GET)
	public String c(Locale locale, Model model) {
		
		return ".3";
	}    @RequestMapping(value = "/d", method = RequestMethod.GET)
	public String d(Locale locale, Model model) {
		
		return ".4";
	}    @RequestMapping(value = "/e", method = RequestMethod.GET)
	public String e(Locale locale, Model model) {
		
		return ".5";
	}    @RequestMapping(value = "/f", method = RequestMethod.GET)
	public String f(Locale locale, Model model) {
		
		return ".6";
	}    @RequestMapping(value = "/g", method = RequestMethod.GET)
	public String g(Locale locale, Model model) {
		
		return ".7";
	}    @RequestMapping(value = "/h", method = RequestMethod.GET)
	public String h(Locale locale, Model model) {
		
		return ".8";
	}    @RequestMapping(value = "/i", method = RequestMethod.GET)
	public String i(Locale locale, Model model) {
		
		return ".9";
	}   @RequestMapping(value = "/j", method = RequestMethod.GET)
	public String j(Locale locale, Model model) {
		
		return ".10";
	}   @RequestMapping(value = "/k", method = RequestMethod.GET)
	public String k(Locale locale, Model model) {
		
		return ".articleForm";
	}   @RequestMapping(value = "/l", method = RequestMethod.GET)
	public String l(Locale locale, Model model) {
		
		return ".houseForm";
	} @RequestMapping(value = "/m", method = RequestMethod.GET)
	public String m(Locale locale, Model model) {
		
		return ".imageForm";
	} @RequestMapping(value = "/n", method = RequestMethod.GET)
	public String n(Locale locale, Model model) {
		
		return ".writeForm";
	} @RequestMapping(value = "/o", method = RequestMethod.GET)
	public String o(Locale locale, Model model) {
		
		return ".listForm";
	} @RequestMapping(value = "/p", method = RequestMethod.GET)
	public String p(Locale locale, Model model) {
		
		return ".profileForm";
	} @RequestMapping(value = "/q", method = RequestMethod.GET)
	public String q(Locale locale, Model model) {
		
		return ".qnaForm";
	} @RequestMapping(value = "/r", method = RequestMethod.GET)
	public String r(Locale locale, Model model) {
		
		return ".walletForm";
	}
	
}
