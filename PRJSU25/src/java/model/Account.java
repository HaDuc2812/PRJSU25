/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HA DUC
 */
public class Account extends Users {

    private String u_name;
    private String email;
    private String password;
    private String role;
    private String status;
    private String departmentName;

    public Account() {
        super();
    }

    public Account(String u_name, String email, String password, String role, String status) {
        this.u_name = u_name;
        this.email = email;
        this.password = password;
        this.role = role;
        this.status = status;
    }

    public String getU_name() {
        return u_name;
    }

    public void setU_name(String u_name) {
        this.u_name = u_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    @Override
    public String toString() {
        return "Account{" + "u_name=" + u_name + ", email=" + email + ", password=" + password + ", role=" + role + '}';
    }

}
