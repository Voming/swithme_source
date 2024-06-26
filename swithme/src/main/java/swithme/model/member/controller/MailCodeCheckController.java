package swithme.model.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MailCodeCheckController
 */
@WebServlet("/mailcode")
public class MailCodeCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MailCodeCheckController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String codeVal = request.getParameter("codeVal");
		String emailcodeVal = request.getParameter("emailcodeVal");
		System.out.println("codeVal: "+codeVal); 
		System.out.println("emailcodeVal: "+emailcodeVal); 
		
		if(emailcodeVal.equals(codeVal)) {
			response.getWriter().append("1");
		} else {
			response.getWriter().append("0");
		}
	}
	
}


