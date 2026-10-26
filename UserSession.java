/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lilaluna;

/**
 *
 * @author Ali Ataurrahman
 */
import java.util.Date;

public class UserSession {
    private String sessionId;
    private Date loginTime;
    private User user;
    
    public UserSession(String sessionId, Date loginTime, User user){
        this.sessionId = sessionId;
        this.loginTime = loginTime;
        this.user = user;
    }
    
    public boolean validateSession(){
        return false;
    }
}
