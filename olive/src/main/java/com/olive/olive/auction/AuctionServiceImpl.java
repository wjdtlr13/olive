package com.olive.olive.auction;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;

@Service("auction.auctionService")
public class AuctionServiceImpl implements AuctionService{
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertAuction(Auction dto, String pathname) throws Exception {
		try {
			dao.insertData("auction.insertAuction", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Auction> listAuction(Map<String, Object> map) {
		List<Auction> list = null;
		
		try {
			list=dao.selectList("auction.listAuction", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("auction.dataCount", map);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Auction readAuction(int num) {
		Auction dto = null;
		try {
			dto=dao.selectOne("auction.readAuction", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("auction.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Auction preReadAuction(Map<String, Object> map) {
		Auction dto = null;
		try {
			dto=dao.selectOne("auction.preReadAuction", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Auction nextReadAuction(Map<String, Object> map) {
		Auction dto = null;
		try {
			dto=dao.selectOne("auction.nextReadAuction", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateAuction(Auction dto, String pathname) throws Exception {
		try {
			dao.updateData("auction.updateAuction", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteAuction(int num, String pathname, String userId) throws Exception {
		try {
			Auction dto = readAuction(num);
			if(dto==null || (! userId.equals("admin") && ! userId.equals(dto.getUserId())))
				return;
			
			dao.deleteData("auction.deleteAuction", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertAuctionLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("auction.insertAuctionLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int auctionLikeCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("auction.auctionLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("auction.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		try {
			list=dao.selectList("auction.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) throws Exception {
		int result=0;
		try {
			result=dao.selectOne("auction.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("auction.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;
		try {
			list=dao.selectList("auction.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result=0;
		try {
			result=dao.selectOne("auction.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("auction.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {
		Map<String, Object> countMap = null;
		try {
			countMap = dao.selectOne("auction.replyLikeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countMap;
	}



	

}
