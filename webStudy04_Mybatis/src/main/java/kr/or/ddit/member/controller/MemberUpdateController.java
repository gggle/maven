package kr.or.ddit.member.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.CommonException;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.mvc.ICommandHandler;
import kr.or.ddit.vo.MemberVO;

public class MemberUpdateController implements ICommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		MemberVO member = new MemberVO();
		req.setAttribute("member", member);
		try {
			BeanUtils.populate(member, req.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new CommonException(e);
		} // 파라미터 19번을 부르지 않아도 됨

		String goPage = null;

		String message = null;
		Map<String, String> errors = new LinkedHashMap<>();
		req.setAttribute("errors", errors);
		// 3. 검증
		boolean valid = validate(member, errors);
		System.err.println(valid);
		
		if (valid) {
			IMemberService service = new MemberServiceImpl();
			ServiceResult result = service.modifyMember(member);
			switch (result) {
			case INVALIDPASSWORD:
				goPage = "member/memberView";
				message = "비밀번호 불일치";
				break;
			case FAILED:
				goPage = "member/memberView";
				message = "서버 오류로 인한 실패";
				break;
			case OK:
				//goPage = "/member/memberView.do?who="+member.getMem_id();
				goPage = "redirect:/member/mypage.do";
				break;
			}
			req.setAttribute("message", message);
		} else {
			goPage = "member/memberView";
		}
		return goPage;
	}

	// 통과를 하지 못하면 memberview.jsp
	// 기존 입력데이터 . 에러메세지를 가지고 돌아간다 .
	

	private boolean validate(MemberVO member, Map<String, String> errors) {
		boolean valid = true;
		// 검증 룰
		if (StringUtils.isBlank(member.getMem_pass())) {
			valid = false;
			errors.put("mem_pass", "비밀번호 누락");
		}
		if (StringUtils.isBlank(member.getMem_name())) {
			valid = false;
			errors.put("mem_name", "회원명 누락");
		}
		if (StringUtils.isBlank(member.getMem_zip())) {
			valid = false;
			errors.put("mem_zip", "우편번호 누락");
		}
		if (StringUtils.isBlank(member.getMem_add1())) {
			valid = false;
			errors.put("mem_add1", "주소1 누락");
		}
		if (StringUtils.isBlank(member.getMem_add2())) {
			valid = false;
			errors.put("mem_add2", "주소2 누락");
		}
		if (StringUtils.isBlank(member.getMem_mail())) {
			valid = false;
			errors.put("mem_mail", "이메일 누락");
		}
		
		if (StringUtils.isNotBlank(member.getMem_bir())) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			// formatting : 특정 타입의 데이터를 일정 형식의 문자열로 변환.
			// parsing : 일정한 형식의 문자열을 특정 타입의 데이터로 변환
			try {

				formatter.parse(member.getMem_bir());
			} catch (ParseException e) {
				valid = false;
				errors.put("mem_bir", "날짜 형식 확인");
			}
		}
		
		return valid;
	}
}
