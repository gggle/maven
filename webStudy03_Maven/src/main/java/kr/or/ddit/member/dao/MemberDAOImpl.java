package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.db.ibaties.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.MemberVO;

/**
 * @author 한규연
 * @since 2018. 11. 21.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2018. 11. 21.     한규연       최초작성
 * Copyright (c) 2018 by DDIT All right reserved
 * </pre>
 */

public class MemberDAOImpl implements IMemberDAO {

	
	SqlMapClient sqlMapClient = CustomSqlMapClientBuilder.getSqlMapClient();
	
	@Override
	public MemberVO selectMember(String mem_id) {
		try {
			 MemberVO member = (MemberVO) sqlMapClient.queryForObject("Member.selectMember", mem_id);
			 return member;
		}catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	@Override
	public int insertMember(MemberVO member) {
		try {
				return sqlMapClient.update("Member.insertMember",member);
		}catch (SQLException e) {
				throw new RuntimeException(e);
			}
		
	}
	@Override
	public List<MemberVO> selectMemList() {
		try {
				return sqlMapClient.queryForList("Member.selectMemList");
			}catch (SQLException e) {
				throw new RuntimeException(e);
			}
	}
	@Override
	public int updateMember(MemberVO member) {
		try {
			return sqlMapClient.update("Member.updateMember",member);
	}catch (SQLException e) {
			throw new RuntimeException(e);
		}
}
	
	@Override
	public int deleteMember(String mem_id) {
		try {
			return sqlMapClient.delete("Member.deleteMember",mem_id);
			}catch (SQLException e) {
				throw new RuntimeException(e);
			}
	}

}
