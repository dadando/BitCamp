import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;

public class GUI_Sangpum {
	public static void main(String[] args) {
        JFrame frame = new JFrame("상품관리 프로그램");
        frame.setPreferredSize(new Dimension(450, 250));
        frame.setLocation(500, 400);
        Container contentPane = frame.getContentPane();
        
        String colNames[] = {"상품코드", "상품명", "수량", "단가", "금액"};
        DefaultTableModel model = new DefaultTableModel(colNames, 0);
        JTable table = new JTable(model);  
 
        for (int i=0; i<colNames.length; i++) {
        	TableColumn column = table.getColumnModel().getColumn(i);
        	column.setPreferredWidth(90);
        }
        
        contentPane.add(new JScrollPane(table), BorderLayout.CENTER);
        
        JTextField txtCode = new JTextField(5);
        JTextField txtIrum = new JTextField(5);
        JTextField txtSu = new JTextField(3);
        JTextField txtDanga = new JTextField(5);
        
        JButton btnInsert = new JButton("추가");
        JButton btnDelete = new JButton("삭제");
        JButton btnUpdate = new JButton("수정");
        
        JPanel panel1 = new JPanel();
        panel1.add(new JLabel("상품코드"));
        panel1.add(txtCode);
        panel1.add(new JLabel(" 상품명"));
        panel1.add(txtIrum);
        panel1.add(new JLabel(" 수량"));
        panel1.add(txtSu);
        panel1.add(new JLabel(" 단가"));
        panel1.add(txtDanga);
        
        JPanel panel2 = new JPanel();
        panel2.add(btnInsert);
        panel2.add(btnDelete);
        panel2.add(btnUpdate);
        
        JPanel panel3 = new JPanel(new BorderLayout());
        //JPanel panel3 = new JPanel();
        //panel3.setLayout(new BorderLayout());
        panel3.add(panel1, BorderLayout.CENTER);
        panel3.add(panel2, BorderLayout.SOUTH);
        
        contentPane.add(panel3, BorderLayout.SOUTH);
        
        btnInsert.addActionListener(new EventActionListener(
        		table, txtCode, txtIrum, txtSu, txtDanga));
        btnDelete.addActionListener(new EventActionListener(table));
        btnUpdate.addActionListener(new EventActionListener(
        		table, txtCode, txtIrum, txtSu, txtDanga));

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}