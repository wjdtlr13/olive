package com.olive.olive.wallet;

import java.util.List;
import java.util.Map;

public interface WalletService {
	public void insertWallet(Wallet dto) throws Exception;
	public List<Wallet> listCategory(String gubun);
	
	public int dataCount(Map<String, Object> map);
	public List<Wallet> listWallet(Map<String, Object> map);
	public Wallet readWallet(Map<String, Object> map);
	public void updateWallet(Wallet dto) throws Exception;
	public void deleteWallet(Map<String, Object> map) throws Exception;
	
	public Wallet dayStatistics(Map<String, Object> map);
	public Wallet monthStatistics(Map<String, Object> map);
	public List<Wallet> yearStatistics(Map<String, Object> map);	
}
