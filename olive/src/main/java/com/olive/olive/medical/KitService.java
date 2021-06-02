package com.olive.olive.medical;

import java.util.List;
import java.util.Map;

public interface KitService {
	public void insertKit(Kit dto, String pathname) throws Exception;

	public int dataCount(Map<String, Object> map);
	public List<Kit> listKit(Map<String,Object>map);
	
	public void updateHitCount(int num) throws Exception;
	public Kit readKit(int num);
	
	public void updateKit(Kit dto, String pathname) throws Exception;
	public void deleteKit(int num, String paghname) throws Exception;
	
}
