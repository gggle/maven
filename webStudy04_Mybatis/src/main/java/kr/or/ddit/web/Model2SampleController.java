package kr.or.ddit.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.web.model2.SampleModelGenerator;

@WebServlet("/model2Sample.do")
public class Model2SampleController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//1.요청분석
		
		//2.의존객체생성
		SampleModelGenerator generator = new SampleModelGenerator();	
		
		//3.로직메소드를 호출
		String model = generator.generate();
		
		//4.데이터공유
		req.setAttribute("model",model);
		
		//5.뷰레이어를 선택
		String view ="/WEB-INF/views/model2SampleView.jsp";
		
		//6.이동
		RequestDispatcher rd = req.getRequestDispatcher(view);
		rd.forward(req, resp);
		
	}
}
