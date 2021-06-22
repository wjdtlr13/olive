package com.olive.olive.auction;

import java.util.List;
import java.util.Map;

public interface AuctionService {
	public void insertAuction(Auction dto, String pathname) throws Exception;
	public List<Auction> listAuction(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Auction readAuction(int num);
	public void updateHitCount(int num) throws Exception;
	public Auction preReadAuction(Map<String, Object> map);
	public Auction nextReadAuction(Map<String, Object> map);
	public void updateAuction(Auction dto, String pathname) throws Exception;
	public void deleteAuction(int num, String pathname, String userId) throws Exception;
	
	public void insertAuctionLike(Map<String, Object> map) throws Exception;
	public int auctionLikeCount(int num);
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
}
