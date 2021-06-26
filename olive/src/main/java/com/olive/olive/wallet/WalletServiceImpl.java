package com.olive.olive.wallet;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;

@Service("wallet.walletService")
public class WalletServiceImpl implements WalletService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertWallet(Wallet dto) throws Exception {
		try {
			dao.insertData("wallet.insertWallet", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Wallet> listCategory(String gubun) {
		List<Wallet> list = null;
		
		try {
			list = dao.selectList("wallet.listCategory", gubun);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("wallet.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Wallet> listWallet(Map<String, Object> map) {
		List<Wallet> list = null;
		
		try {
			list = dao.selectList("wallet.listWallet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Wallet readWallet(Map<String, Object> map) {
		Wallet dto = null;
		
		try {
			dto = dao.selectOne("wallet.readWallet", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateWallet(Wallet dto) throws Exception {
		try {
			dao.updateData("wallet.updateWallet", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteWallet(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("wallet.deleteWallet", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Wallet dayStatistics(Map<String, Object> map) {
		Wallet dto = null;
		try {
			dto = dao.selectOne("wallet.dayStatistics", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Wallet monthStatistics(Map<String, Object> map) {
		Wallet dto = null;
		try {
			dto = dao.selectOne("wallet.monthStatistics", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public List<Wallet> yearStatistics(Map<String, Object> map) {
		List<Wallet> list = null;
		try {
			list = dao.selectList("wallet.yearStatistics", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}	
}
