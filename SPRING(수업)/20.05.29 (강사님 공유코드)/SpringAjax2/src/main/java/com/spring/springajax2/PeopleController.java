package com.spring.springajax2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


/*
@RestController : ������ 4���� �������� �����ϴ� ������̼� 
��Ʈ�ѷ� Ŭ������ @RestController�� ���̸� �޼��忡 @ResponseBody ������̼��� ������ �ʾƵ� 
���ڿ��� JSON ���� ������ �� �ִ�. 
�並 �����ϴ� �޼������ ������ �ִ� @Controller�ʹ� �ٸ��� @RestController�� ���ڿ�, ��ü ���� 
�����ϴ� �޼������ ������ �ִ�.
*/
@RestController
public class PeopleController {
	
	@Autowired
	private PeopleService peopleService;
	
	//produces �Ӽ��� �̿��� Response�� Content-Type�� ������ �� �ִ�
	@PostMapping(value="/getPeopleJSON.do", produces="application/json;charset=UTF-8")
	public List<PeopleVO> getPeopleJSONGET() {
		List<PeopleVO> list = peopleService.getPeoplejson();
	
		return list;
	}
	
	@PostMapping(value="/insertPeople.do", produces="application/json;charset=UTF-8")
	public Map<String, Object> insertPeople(PeopleVO vo) {
		Map<String, Object> retVal = new HashMap<String, Object>(); //���ϰ� ����
		try{
			peopleService.insertPeople(vo);
			
	        retVal.put("res", "OK");
		}
		catch (Exception e)
		{
			retVal.put("res", "FAIL");
        	retVal.put("message", "Failure");
		}
        
		return retVal;
	}

	@RequestMapping(value="/updatePeople.do", produces="application/json;charset=UTF-8")
	public Map<String, Object> updatePeople(PeopleVO vo) {

		Map<String, Object> retVal = new HashMap<String, Object>(); //���ϰ� ����
		try{
			peopleService.updatePeople(vo);
			
	        retVal.put("res", "OK");
		}
		catch (Exception e)
		{
			retVal.put("res", "FAIL");
        	retVal.put("message", "Failure");
		}
        
		return retVal;
	}
	
	@RequestMapping(value="/deletePeople.do", produces="application/json;charset=UTF-8")
	public Map<String, Object> deletePeople(@RequestParam(value="id") String id) {
		Map<String, Object> retVal = new HashMap<String, Object>(); //���ϰ� ����
		try{
			peopleService.deletePeople(id);
			
	        retVal.put("res", "OK");
		}
		catch (Exception e)
		{
			retVal.put("res", "FAIL");
        	retVal.put("message", "Failure");
		}
        
		return retVal;
	}
}
