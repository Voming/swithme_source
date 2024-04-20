package swithme.model.group.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import swithme.model.group.dto.GroupMylistDto;
import swithme.model.group.service.GroupService;
import swithme.model.member.dto.MemberInfoDto;

/**
 * Servlet implementation class GroupController
 */
@WebServlet("/group")
public class GroupController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	GroupService service = new GroupService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInfoDto loginInfo = (MemberInfoDto)request.getSession().getAttribute("loginInfo");
		if(loginInfo == null) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		String memberId = loginInfo.getMemId();
		System.out.println(memberId);
		List<GroupMylistDto> myGrouplist = service.selectMyList(memberId);
		System.out.println(myGrouplist.toString());
	
		request.getSession().setAttribute("myGrouplist", myGrouplist);

		request.getRequestDispatcher("/WEB-INF/views/group/grouphome.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
