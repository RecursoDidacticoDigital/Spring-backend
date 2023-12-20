package com.weeks2.strapi.school.day;

import com.weeks2.strapi.common.ClientRest;
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

    public void create(HttpHeaders headers,Day.Attributes data) {
        log.info("Data: ");
        var payload = new DayPayload();
        payload.setData(data);

        var response = rest.httpPostRequest(url, headers,payload, DayData.class);
        log.info("response {}",response);
    }

    public List<Day.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }
}
