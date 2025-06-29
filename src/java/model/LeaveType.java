package model;

public class LeaveType {
    private int leaveTypeId;
    private String name;
    private String description;

    public LeaveType() {
    }

    public LeaveType(int leaveTypeId, String name, String description) {
        this.leaveTypeId = leaveTypeId;
        this.name = name;
        this.description = description;
    }

    public int getLeaveTypeId() {
        return leaveTypeId;
    }

    public void setLeaveTypeId(int leaveTypeId) {
        this.leaveTypeId = leaveTypeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
