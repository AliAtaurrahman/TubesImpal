/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lilaluna;

/**
 *
 * @author fursan
 */

import javax.swing.SwingUtilities;

public class main {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            OrderController controller = new OrderController();
            FormAddOrder form = new FormAddOrder(controller);
            form.setVisible(true);
        });
    }
}
