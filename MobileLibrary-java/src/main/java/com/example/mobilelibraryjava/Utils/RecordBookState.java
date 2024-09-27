package com.example.mobilelibraryjava.Utils;

public enum RecordBookState {
    NOT_APPLIED(0, "未申请"),
    PENDING_APPROVAL(1, "已申请，等待管理员审核"),
    BORROWED_SUCCESSFULLY(2, "已借阅成功,管理员已经批准");

    private final int value;
    private final String description;

    RecordBookState(int value, String description) {
        this.value = value;
        this.description = description;
    }

    public int getValue() {
        return value;
    }

    public String getDescription() {
        return description;
    }

    // 添加一个静态方法，根据整数值获取对应的枚举实例
    public static RecordBookState fromValue(int value) {
        for (RecordBookState state : values()) {
            if (state.getValue() == value) {
                return state;
            }
        }
        throw new IllegalArgumentException("Invalid record book state value: " + value);
    }
}
