package com.weeks2.strapi.school.classroom;

import com.weeks2.strapi.api.common.ClientRest;
import com.weeks2.strapi.school.subject.Subject;
import com.weeks2.strapi.school.subject.SubjectService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.stream.Collectors;
import java.time.format.TextStyle;
import java.util.Locale;

@Service
@Slf4j
public class ClassroomService {
    @Value("${strapi.classroom}")
    private String url;
    @Autowired
    private ClientRest rest;
    @Autowired
    private SubjectService subject;

    private final LocalTime[] startTimeblockIds = new LocalTime[]{
            LocalTime.of(7, 0),
            LocalTime.of(8, 30),
            LocalTime.of(10, 30),
            LocalTime.of(12, 0),
            LocalTime.of(13, 30),
            LocalTime.of(15, 0),
            LocalTime.of(16, 30),
            LocalTime.of(18, 30),
            LocalTime.of(20, 0),
    };

    private int getDayId(Subject.Attributes subject, DayOfWeek dayOfWeek){
        return switch (dayOfWeek) {
            case MONDAY -> subject.getDayid1();
            case TUESDAY -> subject.getDayid2();
            case WEDNESDAY -> subject.getDayid3();
            case THURSDAY -> subject.getDayid4();
            case FRIDAY -> subject.getDayid5();
            default -> 0;
        };
    }

    private final LocalTime[] endTimeblockIds = new LocalTime[]{
            LocalTime.of(8, 30),
            LocalTime.of(10, 0),
            LocalTime.of(12, 0),
            LocalTime.of(13, 30),
            LocalTime.of(15, 0),
            LocalTime.of(16, 30),
            LocalTime.of(18, 0),
            LocalTime.of(20, 0),
            LocalTime.of(21, 30),
    };
    private int getSpanishDayId(Subject.Attributes subject, DayOfWeek dayOfWeek){
        String spanishDay = dayOfWeek.getDisplayName(TextStyle.FULL, new Locale("es", "ES")).toLowerCase();
        return switch (spanishDay) {
            case "lunes" -> subject.getDayid1();
            case "martes" -> subject.getDayid2();
            case "miércoles" -> subject.getDayid3();
            case "jueves" -> subject.getDayid4();
            case "viernes" -> subject.getDayid5();
            default -> 0;
        };
    }

    public boolean isClassroomOccupied(List<Subject.Attributes> subjects){
        LocalDate now = LocalDate.now();
        LocalTime currentTime = LocalTime.now();
        DayOfWeek dayOfWeek = now.getDayOfWeek();

        for(Subject.Attributes subject : subjects){
            int dayId = getSpanishDayId(subject, dayOfWeek);
            int timeBlockId = getTimeBlockId(subject, dayId);

            if(isOccupied(dayId, timeBlockId, currentTime)){
                return true;
            }
        }
        return false;
    }

    private int getTimeBlockId(Subject.Attributes subject, int dayId){
        switch(dayId){
            case 1: return subject.getTimeblockid1();
            case 2: return subject.getTimeblockid2();
            case 3: return subject.getTimeblockid3();
            case 4: return subject.getTimeblockid4();
            case 5: return subject.getTimeblockid5();
            default: return 0;
        }
    }

    private boolean isOccupied(int dayId, int timeBlockId, LocalTime currentTime){
        if(timeBlockId <= 0 || timeBlockId > startTimeblockIds.length){
            return false;
        }

        LocalTime startTime = startTimeblockIds[timeBlockId -1];
        LocalTime endTime = endTimeblockIds[timeBlockId -1];

        return currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
    }

    public boolean getAvailable(HttpHeaders authHeader, String name){
        List<Subject.Attributes> subjects = subject.fetch(authHeader).stream()
                .filter(subj-> subj.getClassroom().equals(name))
                .collect(Collectors.toList());
        return isClassroomOccupied(subjects);
    }

    public List<Classroom.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, ClassroomList.class)
                .getClassrooms().stream()
                .map(this::toClassroomWithId)
                .collect(Collectors.toList());
    }

    private Classroom.Attributes toClassroomWithId(Classroom classroom) {
        var l = classroom.getAttributes();
        l.setId(classroom.getId());
        return l;
    }

    public void create(HttpHeaders headers,Classroom.Attributes data) {
        log.info("Data: ");
        var payload = new ClassroomPayload();
        payload.setData(data);

        var response = rest.httpPostRequest(url, headers,payload, ClassroomData.class);
        log.info("response {}",response);
    }

    public void delete(HttpHeaders headers, int id){
        rest.httpDeleteRequest(url+"/"+id, headers);
    }

    public List<Classroom.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }

    public List<Classroom.Attributes> findByName(HttpHeaders authHeader, String name) {
        return fetch(authHeader).stream()
                .filter(classroom -> classroom.getName().equals(name))
                .collect(Collectors.toList());
    }

    public void put(HttpHeaders headers, int id, Classroom.Attributes body){
        var payload = getClassroomPayload(body);
        var response = rest.httpPutRequest(url+"/"+id, headers, payload, ClassroomData.class).getData();
        log.info("{}",response);
    }

    public void patch(HttpHeaders headers, int id, Classroom.Attributes body){
        var payload = getClassroomPayload(body);
        var response = rest.httpPatchRequest(url+"/"+id, headers, payload, ClassroomData.class).getData();
        log.info("{}",response);
    }

    private static ClassroomPayload getClassroomPayload(Classroom.Attributes data) {
        var payload = new ClassroomPayload();
        payload.setData(data);
        return payload;
    }
}
