package com.weeks2.strapi.school.day;

import com.weeks2.strapi.api.common.ClientRest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class DayService {
    @Value("${strapi.day}")
    private String url;
    @Autowired
    private ClientRest rest;

    public List<Day.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, DayList.class)
                .getDays().stream()
                .map(this::toDayWithId)
                .collect(Collectors.toList());
    }

    private Day.Attributes toDayWithId(Day day) {
        var l = day.getAttributes();
        l.setId(day.getId());
        return l;
    }

    public void create(HttpHeaders headers,Day.Attributes body) {
        log.info("Data: ");
        var payload = getDayPayload(body);
        var response = rest.httpPostRequest(url, headers,payload, DayData.class);
        log.info("response {}",response);
    }

    public void delete(HttpHeaders headers, int id){
        rest.httpDeleteRequest(url+"/"+id, headers);
    }

    public List<Day.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }

    public void put(HttpHeaders headers, int id, Day.Attributes body) {
        var payload = getDayPayload(body);
        log.info("Payload: "+payload);
        var response = rest.httpPutRequest(url+"/"+id, headers, payload, DayData.class).getData();
        log.info("{}",response);
    }

    private static DayPayload getDayPayload(Day.Attributes data) {
        var payload = new DayPayload();
        payload.setData(data);
        return payload;
    }
}
