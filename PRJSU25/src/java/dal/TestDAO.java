/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Account;

/**
 *
 * @author HA DUC
 */
public class TestDAO {

    public static void main(String[] args) {
        DAO dao = new DAO();
        List<Account> accounts = dao.getAllAccount();

        if (accounts == null) {
            System.out.println("getAllAccounts() returned null.");
            return;
        }

        System.out.println("Total accounts found: " + accounts.size());

        for (Account acc : accounts) {
            System.out.println("ID: " + acc.getUsers_id());
            System.out.println("Name: " + acc.getU_name());
            System.out.println("Email: " + acc.getEmail());
            System.out.println("Role: " + acc.getRole());
            System.out.println("Status: " + acc.getStatus());
            System.out.println("Department" + acc.getDepartmentName());
            System.out.println("-------------------------");
        }
    }
}
//        int testId = 1; // replace with a valid user ID in your DB
//
//        Account acc = dao.getAccountById(testId);
//
//        if (acc != null) {
//            System.out.println("Account Found:");
//            System.out.println("ID: " + acc.getUsers_id());
//            System.out.println("Name: " + acc.getU_name());
//            System.out.println("Email: " + acc.getEmail());
//            System.out.println("Role: " + acc.getRole());
//            System.out.println("Status: " + acc.getStatus());
//            System.out.println("Department ID: " + acc.getDepartmentId());
//        } else {
//            System.out.println("No account found with ID: " + testId);
//        }
    
//        int testId = 3; // 👈 Change this to the ID you want to test
//
//        String deptName = dao.getDepartmentNameById(testId);
//
//        if (deptName != null) {
//            System.out.println("Department name for ID " + testId + ": " + deptName);
//        } else {
//            System.out.println("No department found for ID " + testId);
//        }
//    }
//}
