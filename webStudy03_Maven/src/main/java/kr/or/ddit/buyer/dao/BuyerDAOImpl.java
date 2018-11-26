package kr.or.ddit.buyer.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.db.ibaties.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.BuyerVO;

public class BuyerDAOImpl implements IBuyerDAO {

	SqlMapClient sqlMapClient = CustomSqlMapClientBuilder.getSqlMapClient();
	@Override
	public List<BuyerVO> selectAllBuyer() {
		try {
			return sqlMapClient.queryForList("Buyer.selectAllBuyer");
			}catch (SQLException e) {
				throw new RuntimeException(e);
			}
	}
	@Override
	public BuyerVO selectBuyer(String buyer_id) {
		try {
			return (BuyerVO) sqlMapClient.queryForObject("Buyer.selectBuyer",buyer_id);
			}catch (SQLException e) {
				throw new RuntimeException(e);
			}
	}

}
