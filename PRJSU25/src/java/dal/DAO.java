/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Department;
import model.LeaveRequest;
import model.Users;

/**
 *
 * @author HA DUC
 */
public class DAO extends DBContext {

    public DAO() {
        super();
    }
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public Users login(String name, String password) {
        Users user = null;

        try {
            Connection conn = DBContext.getConnection();
            String sql = "SELECT id, name, email, password, role, department_id FROM users WHERE name = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new Users();
                user.setUsers_id(rs.getInt("id"));
                user.setU_name(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setD_id(rs.getInt("department_id"));

                System.out.println("DEBUG: role = " + user.getRole()); // check this prints correctly
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public Users checkAccountExist(String email) {
        String sql = "select * from Users\n" + " where email=? ";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Users(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                // Handle closing errors
                ex.printStackTrace();
            }
        }
        return null;
    }

    public String getDepartmentNameById(int id) {
        String name = null;

        try {
            conn = DBContext.getConnection();
            String sql = "select name from departments where id =?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return name;
    }

    //insert leave request into database
    public void insertLeaveRequest(int userId, int leaveTypeId, Date startDate, Date endDate, String reason) {
        String sql = "INSERT INTO leave_requests (user_id, leave_type_id, start_date, end_date, reason, status, approved_by) "
                + "VALUES (?, ?, ?, ?, ?, 'pending', NULL)";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, leaveTypeId);
            ps.setDate(3, startDate);
            ps.setDate(4, endDate);
            ps.setString(5, reason);
            ps.executeUpdate();
            System.out.println("✅ Leave request inserted successfully.");
        } catch (SQLException e) {
            System.err.println("❌ Failed to insert leave request: " + e.getMessage());
        }
    }
//get list of requestr from user with user id = ?

    public List<LeaveRequest> getLeaveRequestByUserId(int user_id) {
        List<LeaveRequest> list = new ArrayList<>();
        String sql = "select * from leave_requests  where user_id = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, user_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                LeaveRequest lr = new LeaveRequest();
                lr.setId(rs.getInt("id"));
                lr.setUserId(rs.getInt("user_id"));
                lr.setLeaveTypeId(rs.getInt("leave_type_id"));
                lr.setStartDate(rs.getDate("start_date"));
                lr.setEndDate(rs.getDate("end_date"));
                lr.setReason(rs.getString("reason"));
                lr.setStatus(rs.getString("status"));
                lr.setRequestedAt(rs.getTimestamp("requested_at"));
                lr.setApprovedBy(rs.getObject("approved_by") != null ? rs.getInt("approved_by") : null);
                list.add(lr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    //get all leave request

    public List<LeaveRequest> getAllLeaveRequest() {
        List<LeaveRequest> list = new ArrayList<>();
        String sql = "select * from leave_requests";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                LeaveRequest lr = new LeaveRequest();
                lr.setId(rs.getInt("id"));
                lr.setUserId(rs.getInt("user_id"));
                lr.setLeaveTypeId(rs.getInt("leave_type_id"));
                lr.setStartDate(rs.getDate("start_date"));
                lr.setEndDate(rs.getDate("end_date"));
                lr.setReason(rs.getString("reason"));
                lr.setStatus(rs.getString("status"));
                lr.setApprovedBy(rs.getInt("approved_by"));
                list.add(lr);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean approveLeaveRequest(int requestId, int adminId) {
        String updateSql = "UPDATE leave_requests SET status = 'approved', approved_by = ? WHERE id = ?";;
        String updateBalaceSql = "UPDATE leave_balances SET used_days = used_days + DATEDIFF(day, ?, ?) WHERE user_id = ? AND leave_type_id = ?";
        PreparedStatement ps1 = null, ps2 = null, ps3 = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);
            //get request details
            ps1 = conn.prepareStatement("SELECT user_id, leave_type_id, start_date, end_date FROM leave_requests WHERE id = ?");
            ps1.setInt(1, requestId);
            rs = ps1.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                int leaveTypeId = rs.getInt("leave_type_id");
                Date start = rs.getDate("start_date");
                Date end = rs.getDate("end_date");

                //update leave_request table in the db
                ps2 = conn.prepareStatement(updateSql);
                ps2.setInt(1, adminId);
                ps2.setInt(2, requestId);
                ps2.executeUpdate();
                // update leave balance
                ps3 = conn.prepareStatement(updateBalaceSql);
                ps3.setDate(1, start);
                ps3.setDate(2, end);
                ps3.setInt(3, userId);
                ps3.setInt(4, leaveTypeId);
                //commit the transactions
                conn.commit();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps1 != null) {
                    ps1.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                if (ps3 != null) {
                    ps3.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true); // reset auto-commit
                }
                if (conn != null) {
                    conn.close();
                }
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
        return false;
    }

    public void rejectLeaveRequest(int requestId, int adminId) {
        String sql = "UPDATE leave_requests SET status='rejected', approved_by=? WHERE id=?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, adminId);
            ps.setInt(2, requestId);
            ps.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
