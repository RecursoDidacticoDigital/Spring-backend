package com.weeks2.strapi.school.group;

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
public class GroupService {
    @Value("${strapi.group}")
    private String url;
    @Autowired
    private ClientRest rest;

    public List<Group.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, GroupList.class)
                .getGroups().stream()
                .map(this::toGroupWithId)
                .collect(Collectors.toList());
    }

    private Group.Attributes toGroupWithId(Group group) {
        var l = group.getAttributes();
        l.setId(group.getId());
        return l;
    }

    public void create(HttpHeaders headers,Group.Attributes body) {
        log.info("Data: ");
        var payload = getGroupPayload(body);
        var response = rest.httpPostRequest(url, headers,payload, GroupData.class);
        log.info("response {}",response);
    }

    public void delete(HttpHeaders headers, int id){
        rest.httpDeleteRequest(url+"/"+id, headers);
    }

    public List<Group.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }

    public void put(HttpHeaders headers, int id, Group.Attributes body){
        var payload = getGroupPayload(body);
        log.info("Payload: "+payload);
        var response = rest.httpPutRequest(url+"/"+id, headers, payload, GroupData.class).getData();
        log.info("{}",response);
    }

    private static GroupPayload getGroupPayload(Group.Attributes data) {
        var payload = new GroupPayload();
        payload.setData(data);
        return payload;
    }
}
