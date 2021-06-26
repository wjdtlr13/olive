package com.olive.olive.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.FileManager;
import com.olive.olive.common.dao.CommonDAO;


@Service("notice.noticeService")
public class NoticeServiceImpl implements NoticeService{
	 
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertNotice(Notice dto, String mode) throws Exception {
		try {
			int seq = dao.selectOne("notice.seq");
			
			dto.setNum(seq);
			
			
			dao.insertData("notice.insertNotice",dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result =0;
		try {
			result=dao.selectOne("notice.dataCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list =null;
		
		try {
			list = dao.selectList("notice.listNotice",map);
		} catch (Exception e) {
			e.printStackTrace();

		}
		return list;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.selectOne("notice.updateHitCount",num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
		
	}

	@Override
	public Notice readNotice(int num) {
		Notice dto = null;
		
		try {
			dto= dao.selectOne("notice.readNotice", num);
		} catch (Exception e) {
			e.printStackTrace();

		}
				
		return dto;
	}

	@Override
	public void updateNotice(Notice dto) throws Exception {
		try {
		
			
			dao.updateData("notice.updateNotice",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
		
	}

	@Override
	public void deleteNotice(int num, String userId) throws Exception {
		
		try {
			Notice dto = readNotice(num);
			if(dto==null || (! userId.equals("admin"))) {
				return;
			}
			
			dao.deleteData("notice.deleteNotice",num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Notice preReadNotice(Map<String, Object> map) {
		Notice dto=null;

		try {
			dto=dao.selectOne("notice.preReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Notice nextReadNotice(Map<String, Object> map) {
		Notice dto=null;

		try {
			dto=dao.selectOne("notice.nextReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

}
