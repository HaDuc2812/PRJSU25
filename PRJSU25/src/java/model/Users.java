/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HA DUC
 */
public class Users {
//    id INT IDENTITY(1,1) PRIMARY KEY,
//    name VARCHAR(100) NOT NULL,
//    email VARCHAR(100) UNIQUE NOT NULL,
//    password VARCHAR(255) NOT NULL,
//    role VARCHAR(20) CHECK (role IN ('employee', 'manager', 'admin')) NOT NULL DEFAULT 'employee',
//    department_id INT,
//    FOREIGN KEY (department_id) REFERENCES departments(id)
//);

    private int users_id;
    private String u_name;
    private String email;
    private String password;
    private String role;
    private int d_id;

    public Users() {
    }

    public Users(int users_id, String u_name, String email, String password, String role, int d_id) {
        this.users_id = users_id;
        this.u_name = u_name;
        this.email = email;
        this.password = password;
        this.role = role;
        this.d_id = d_id;
    }

    public int getUsers_id() {
        return users_id;
    }

    public void setUsers_id(int users_id) {
        this.users_id = users_id;
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

    public int getD_id() {
        return d_id;
    }

    public void setD_id(int d_id) {
        this.d_id = d_id;
    }

}
