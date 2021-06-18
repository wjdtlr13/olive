package com.olive.olive.schedule;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;

@Service("schedule.scheduleService")
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertSchedule(Schedule dto) throws Exception {
		try {
			if(dto.getAll_day()!=null) {
				dto.setStime("");
				dto.setEtime("");
			}
			
			if(dto.getStime().length()==0&&dto.getEtime().length()==0&&dto.getSday().equals(dto.getEday()))
				dto.setEday("");
			
			if(dto.getRepeat_cycle()!=0) {
				dto.setEday("");
				dto.setStime("");
				dto.setEtime("");
			}
			
			dao.insertData("schedule.insertSchedule", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Schedule> listMonth(Map<String, Object> map) throws Exception{
		List<Schedule> list=null;
		try {
			list=dao.selectList("schedule.listMonth", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public Schedule readSchedule(int num) throws Exception{
		Schedule dto=null;
		try {
			dto=dao.selectOne("schedule.readSchedule", num);
		} catch (Exception e) {
			throw e;
		}
		return dto;
	}

	@Override
	public void updateSchedule(Schedule dto) throws Exception{
		try {
			if(dto.getAll_day()!=null) {
				dto.setStime("");
				dto.setEtime("");
			}
			
			if(dto.getStime().length()==0&&dto.getEtime().length()==0&&dto.getSday().equals(dto.getEday()))
				dto.setEday("");
			
			if(dto.getRepeat_cycle()!=0) {
				dto.setEday("");
				dto.setStime("");
				dto.setEtime("");
			}
			dao.updateData("schedule.updateSchedule", dto);
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public void deleteSchedule(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("schedule.deleteSchedule", map);
		} catch (Exception e) {
			throw e;
		}
	}
}
