package swithme.model.group.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import swithme.model.group.dto.GroupCreateDto;
import swithme.model.group.service.GroupService;
import swithme.model.member.dto.MemberInfoDto;

/**
 * Servlet implementation class GroupController
 */
@WebServlet("/group/create")
public class GroupCreateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	GroupService service = new GroupService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupCreateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/group/groupcreate.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/group/create doPost()");
		
		String uploadPath = request.getServletContext().getRealPath("files");
		//uploadPath:C:\workspace\Java\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\31_web_project\files
		System.out.println("uploadPath : " + uploadPath ); 
		File uploadPathFile = new File(uploadPath); //만약 필요한 파일이 만들어져있지 않다면 만들어줘
		if(!uploadPathFile.exists()) {
			uploadPathFile.mkdirs();
		}
		
		
		int uploadFileLimit = 10*1024*1024; //10M 제한
		
		//form enctype = "multipart/form-data"형태로 전달된 경우
		MultipartRequest multiReq = new MultipartRequest(request, 
				uploadPath, //서버에 저장할 디렉토리
				uploadFileLimit, //업로드 파일 크기 제한
				"UTF-8",
				new DefaultFileRenamePolicy() //was서버에 저장할 디렉토리에 동일 이름이 존재할 때 새로운 이름 부여 방식
				);
		
		
		//jsp -> controller file 딱 1개일 경우
		String filePath = multiReq.getFilesystemName("uploadfile");
		String fileName = null;
		String orginFileName = null;
		if(filePath == null) {
			System.out.println("첨부파일이 없었습니다.");
		}else {
			System.out.println("첨부파일 정보는===");
			System.err.println(filePath);
			fileName = multiReq.getFilesystemName("uploadfile"); // 서버에 저장된 파일이름
			orginFileName = multiReq.getOriginalFileName("uploadfile");
			
			File f1 = multiReq.getFile("uploadfile"); // name을 이용해서 파일 객체 생성 여부 확인 작업.
			if(f1==null) {// name을 이용해서 파일 객체 생성에 실패하면
				System.out.println("파일 업로드 실패");
			}else {
				System.out.println(f1.length()); // 그 파일의 크기 
			}
			System.out.println( fileName+"  :  "+orginFileName);
		}
		
		

		String groupName = multiReq.getParameter("groupName");
		String groupOpen = multiReq.getParameter("groupOpen");
		String groupPwdstr = multiReq.getParameter("groupPwd");
		String groupExp = multiReq.getParameter("groupExp");
		
		int groupPwd = 0;
		if(groupPwdstr != null && !groupPwdstr.equals("")) {
			try {
				groupPwd = Integer.parseInt(groupPwdstr);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		
		if(groupOpen.equals("open")) {
			groupOpen = "0";
		}else {
			groupOpen = "1";
		}
		
		
		MemberInfoDto loginInfo = (MemberInfoDto)request.getSession().getAttribute("loginInfo");
		if(loginInfo == null) {
			response.sendRedirect(request.getContextPath()+"/login");
			return;
		}
		String groupWriter = loginInfo.getMemId();
		
		System.out.println(groupName);
		System.out.println(groupOpen);
		System.out.println(groupPwd);
		System.out.println(groupExp);
		
		
		GroupCreateDto dto = new GroupCreateDto(groupWriter, groupName, groupOpen, groupPwd, groupExp, fileName, orginFileName);
		System.out.println(dto);
		int result = service.insert(dto, groupWriter);
		System.out.println(result);
		//response.sendRedirect(request.getContextPath()+"/group");
		response.getWriter().append(String.valueOf(result));
	}

}
