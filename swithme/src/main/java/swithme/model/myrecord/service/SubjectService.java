package swithme.model.myrecord.service;


import static swithme.jdbc.common.MybatisTemplate.*;

import java.sql.Connection;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import swithme.model.myrecord.dao.RecordDao;
import swithme.model.myrecord.dao.SubjectDao;
import swithme.model.myrecord.dto.SubjectAddDto;
import swithme.model.myrecord.dto.SubjectDeleteDto;
import swithme.model.myrecord.dto.SubjectDifftimeDto;
import swithme.model.myrecord.dto.SubjectDto;

public class SubjectService {
	private SubjectDao dao = new SubjectDao();
	private RecordDao daoRecord = new RecordDao();
	
	//과목 이름만 
	public String selectOne(String memid) {
		String sujectName = null;
		SqlSession session = getSqlSession();
		sujectName= dao.selectOne(session, memid);
		session.close();
		return sujectName;
	}
	
	//과목 불러오기...? select 
	//TODO 유저 아이디에 맞는 것만
	public List<SubjectDto> select(String memId) {
		System.out.println(">>>>>>serv select  memId : "+memId);
		
		List<SubjectDto> result = null;
		SqlSession session = getSqlSession();
		result = dao.select(session, memId);
			System.out.println(">>>>>>serv select  result : "+result);
		session.close();
		return result;
	}
	
	
	//과목 추가 insert - 후 결과화면 조화 한번에 하기 (ajax)
	public List<SubjectDifftimeDto> insertSubjectAndSelectRecord( SubjectAddDto dto) {
		System.out.println(">>>>>>serv insertSubjectAndSelectRecord  dto : "+dto);
		
		List<SubjectDifftimeDto> result = null;
		int insertResult = -1;
		SqlSession session = getSqlSession();

		// insert subject
		insertResult = dao.insert(session, dto);
		
		// select record
		// 과목추가에 성공 여부와 상관없이 화면을 다시 display 해야 하므로 정보를 조회해 옴
		result = daoRecord.subjectDifftime(session, dto.getSubjectMemId());
		
		System.out.println(">>>>>>serv insert  result : "+result);
		session.close();
		return result;
	}
	

	//과목 추가 insert
	public int insert( SubjectAddDto dto) {
		System.out.println(">>>>>>serv insert  dto : "+dto);
		
		int result = -1;
		SqlSession session = getSqlSession();

		// insert subject
		result = dao.insert(session, dto);
		
		System.out.println(">>>>>>serv insert  result : "+result);
		session.close();
		return result;
	}
	

	//과목 수정 update
	public int update(SubjectAddDto dto) {
		//과목,맴버 ID를 조건으로 하는 행의 과목이름과 컬러 변경
		System.out.println(">>>>>>update  SubjectDto : "+dto);
		int result = -1;
		SqlSession session = getSqlSession();
		result = dao.update(session, dto);
			System.out.println(">>>>>>serv update  result : "+result);
		session.close();
		return result;
	}
	
	/*후순위*/
	//과목 삭제 delete DEL_DATE = default //조건 : 과목,맴버 아이디 
	public int delete(SubjectDeleteDto dto) {
		System.out.println(">>>>>>delete SubjectDeleteDto : "+dto);
		int result = -1;
		SqlSession session = getSqlSession();
		result = dao.delete(session, dto);
			System.out.println(">>>>>>serv delete  result : "+result);
		session.close();
		return result;
	}
	
}
