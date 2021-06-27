package com.olive.olive.admin.manage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;
 
@Service("admin.manage.memberSerivce") 
public class MemberServiceImpl implements MemberSerivce{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result =0;
		
		try {
			result = dao.selectOne("admin.dataCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@Override
	public List<Member> listMember(Map<String, Object> map) throws Exception {
		List<Member> list = null;
		try {
			list = dao.selectList("admin.listMember",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Member readMember(String userId) throws Exception {
		Member dto = null;
		
		try {
			dto = dao.selectOne("admin.detailMemberlist",userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
	

	//신고회원리스트
	@Override
	public List<Block> blockList(Map<String, Object> map) throws Exception {
		List<Block> list =null;
		try {
			list = dao.selectList("admin.blockList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public void updateBlockMember(String userId) throws Exception {
		
		try {
			dao.updateData("admin.handling_block",userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
	}

	//신고하기
	@Override
	public void insertBlock(Block dto) throws Exception {
		try {
			dao.insertData("admin.insertBlock",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	//신고된 회원 warn_cnt 증가
	@Override
	public void updateWarncnt(String blockedId) throws Exception {
		try {
			dao.updateData("admin.updateWarncnt", blockedId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	
	



	
	
}
