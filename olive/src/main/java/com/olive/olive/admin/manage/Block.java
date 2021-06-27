package com.olive.olive.admin.manage;

public class Block {
	
	private String blockReqId;
	private String blockedId;
	private int categoryNum;
	private String block_date;
	private int warn_cnt;
	private int listNum;
	
	
	
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getWarn_cnt() {
		return warn_cnt;
	}
	public void setWarn_cnt(int warn_cnt) {
		this.warn_cnt = warn_cnt;
	}
	public String getBlockReqId() {
		return blockReqId;
	}
	public void setBlockReqId(String blockReqId) {
		this.blockReqId = blockReqId;
	}
	public String getBlockedId() {
		return blockedId;
	}
	public void setBlockedId(String blockedId) {
		this.blockedId = blockedId;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getBlock_date() {
		return block_date;
	}
	public void setBlock_date(String block_date) {
		this.block_date = block_date;
	}
	
	
	

}
