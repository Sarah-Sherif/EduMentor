package com.asu.EduMentor.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public abstract class User implements CRUD{

    private int userID;
    private String firstName;
    private String lastName;
    private userType role;
    private String email;
    private String password;
    private boolean isDeleted = false;

    public User(String firstName, String lastName, userType role, String email, String password)
    {
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
        this.email = email;
        this.password = password;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public userType getRole() {
        return role;
    }

    public void setRole(userType role) {
        this.role = role;
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

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Override
    public abstract Object create();

    @Override
    public abstract Object update(Object updatedObject);

    @Override
    public abstract Object read(int id);

    @Override
    public abstract List<Object> readAll();

    @Override
    public boolean delete(int id)
    {
        String sqlQuery = "UPDATE public.\"User\" SET \"isDeleted\" = TRUE WHERE \"UserID\" = ?";
        try(Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sqlQuery))
        {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
        catch (SQLException e)
        {
            //e.printStackTrace();
            throw new RuntimeException("Error deleting admin", e);
        }
    }

    public static User findByEmail(String email) {
        String sql = "SELECT * FROM public.\"User\" WHERE \"Email\" = ? AND \"isDeleted\" = FALSE";
        try (PreparedStatement stmt = DBConnection.getInstance().getConnection().prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int role = rs.getInt("Role");
                return switch (role) {
                    case 0 -> new Admin(rs.getString("FirstName"), rs.getString("LastName"),
                            rs.getString("Email"), rs.getString("Password"), rs.getBoolean("Status"));
                    case 1 -> new Mentor(rs.getString("FirstName"), rs.getString("LastName"),
                            rs.getString("Email"), rs.getString("Password"), rs.getDouble("TotalHours"));
                    case 2 -> new Mentee(rs.getString("FirstName"), rs.getString("LastName"),
                            rs.getString("Email"), rs.getString("Password"),
                            rs.getInt("NumberOfAttendedSessions"), rs.getDouble("LearningHours"));
                    default -> throw new IllegalArgumentException("Invalid role in database");
                };
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding user by email", e);
        }
        return null;
    }

}