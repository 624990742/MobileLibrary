package com.example.mobilelibraryjava.Utils;

public enum UserRole {
    SUPER_ADMIN("superAdmin"),
    ADMIN("admin"),
    READER("reader");

    private final String roleName;

    UserRole(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleName() {
        return roleName;
    }
}
