package com.weeks2.strapi.school.timeblock;

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
public class TimeblockService {
    @Value("${strapi.timeblock}")
    private String url;
    @Autowired
    private ClientRest rest;

    public List<Timeblock.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, TimeblockList.class)
                .getTimeblocks().stream()
                .map(this::toTimeblockWithId)
                .collect(Collectors.toList());
    }

    private Timeblock.Attributes toTimeblockWithId(Timeblock timeblock) {
        var l = timeblock.getAttributes();
        l.setId(timeblock.getId());
        return l;
    }

    public void create(HttpHeaders headers,Timeblock.Attributes data) {
        log.info("Data: ");
        var payload = new TimeblockPayload();
        payload.setData(data);

        var response = rest.httpPostRequest(url, headers,payload, TimeblockData.class);
        log.info("response {}",response);
    }

    public List<Timeblock.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }
}
