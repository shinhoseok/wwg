/**  
import java.io.File;

@Repository("cmPopDAO01")
public class CmPopDAO01 extends CmsDsDao {
	protected Logger log = Logger.getLogger(CmPopDAO01.class); //현재 클래스 이름을 Logger에 등록
	/** cmDAO */
    /**
			// 팝업리스트
			}else if(pstate.equals("PL")){
	
    	log.debug("==== CmPopDAO01 ctlCMS End ====");
		return result_map;
    }
	/**
		
		try{
			result_map = cmDAO.selectListGrid(param, "JiCmCms.getPopSelect");
		}catch(NullPointerException q){
	} 	

	/**
		log.debug("==== insertPop : START ====");
	    Map SITE_ADM_SESSION	= (Map)param.get(propertiesService.getString("SITE_ADM_SESSION_FN"));
		String sql = "";	

		try{
			// 등록자 id 셋팅
			// 팝업을 등록한다
			insert(sql, param);
			result_map.put("result", true);
		}catch(JSysException q){	
		log.debug("==== insertPop : END ====");
		return result_map;	
	}
	
	/**
	public Map updatePop(Map param) throws IOException, SQLException, NullPointerException, ArrayIndexOutOfBoundsException, Exception{
		log.debug("==== updatePop : START ====");
		Map result_map = new HashMap();
		log.debug("==== updateCode : END ====");
		return result_map;	
	}
	
