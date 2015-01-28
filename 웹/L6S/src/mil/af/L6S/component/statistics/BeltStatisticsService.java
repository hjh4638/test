package mil.af.L6S.component.statistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mil.af.L6S.component.SearchFilter;
import mil.af.L6S.component.belt.BeltGraphVO;
import mil.af.L6S.component.belt.BeltTableVO;

/**
 *  벨트 통계 전용 Service
 * @author 정성모
 */
@Service
public class BeltStatisticsService {

	@Autowired
	private BeltStatisticsDao beltStatisticsDao;

	public List<BeltGraphVO> belt1Count(SearchFilter searchFilter){
		return beltStatisticsDao.belt1Count(searchFilter);
	}
	
	public List<Object> getTableDatum(SearchFilter searchFilter){
		List<BeltTableVO> tableData = beltStatisticsDao.getTableDatum(searchFilter);
		List<Object> datum = new ArrayList<Object>();
		Map<String, Object> firstData;
		Map<String, Object> secondData;
		Map<String, String> thirdData;
		if(tableData != null)
		for(BeltTableVO table : tableData){
			thirdData = new HashMap<String, String>();
			thirdData.put(table.getState(), table.getCount());
			secondData = new HashMap<String, Object>();
			secondData.put(table.getBelt(), thirdData);
			firstData = new HashMap<String, Object>();
			firstData.put(table.getCode(), secondData);
			datum.add(firstData);
		}
		return datum;
	}
}
