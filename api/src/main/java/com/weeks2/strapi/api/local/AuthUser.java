package com.weeks2.strapi.api.local;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AuthUser {
    private int id;
    private String username;
    private String email;
    private String provider;
    private boolean confirmed;
    private boolean blocked;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int tenantId;
    private String tenantRole;
}
