package com.olive.olive.mate;

import java.util.List;
import java.util.Map;


public interface MateService {
	
	public String getAddress(String userId);
	
	public int insertMate(Mate dto) throws Exception;
	public int updateMate(Mate dto) throws Exception;
	public int deleteMate(int num) throws Exception;
	
	public int insertMate_Register(Register dto) throws Exception;
	public int deleteMate_Register(Map<String, Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Category> listCategory();
	
	public List<Register> listMyRegister(Map<String, Object> map);
	public List<Register> listRegister(Map<String, Object> map);
	
	public Register readMate_Register(int num);
	
	public int updateMate_RegisterAccept(Map<String, Object> map) throws Exception;
	
	public int insertMate_Request(Request dto) throws Exception;
	public int deleteMate_Request(int num) throws Exception;

	public List<Request> readItsRequest(int reg_num) throws Exception;

	public int updateMate_RequestDeny(int mate_req_num) throws Exception;
	public int updateMate_RequestAccept(int mate_req_num) throws Exception;
	public int updateMate_RequestExcept(Map<String, Object> map) throws Exception;

	public List<Register> listRequest(Map<String, Object> map);

	

	
	
}
