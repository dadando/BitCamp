import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

public class EventActionListener implements ActionListener {
     JTable table;
     JTextField txtHakbun, txtIrum, txtKor, txtEng, txtMath, txtTot, txtAvg, 
     	txtGrade;
     DrawingPanel drawpanel;
     
     EventActionListener() {
     }
     EventActionListener(JTable table) {
    	 this.table = table;
     }
     EventActionListener(JTable table, DrawingPanel drawpanel) {
    	 this.table = table;
    	 this.drawpanel = drawpanel;
     }
     EventActionListener(JTable table, JTextField txtHakbun, JTextField txtKor,
       JTextField txtEng, JTextField txtMath) {
         this.table = table;
         this.txtHakbun = txtHakbun;
         this.txtKor = txtKor;
         this.txtEng = txtEng;
         this.txtMath = txtMath;
     }
     EventActionListener(JTable table, JTextField txtHakbun, JTextField txtIrum, 
       JTextField txtKor, JTextField txtEng, JTextField txtMath) {
         this.table = table;
         this.txtHakbun = txtHakbun;
         this.txtIrum = txtIrum;
         this.txtKor = txtKor;
         this.txtEng = txtEng;
         this.txtMath = txtMath;
     }
     
     public void actionPerformed(ActionEvent e) {
    	 if (e.getActionCommand().equals("추가"))
    	 {
    		 insert();
    	 }
    	 else if (e.getActionCommand().equals("삭제"))
    	 {
    		 delete();
    	 }
    	 else if (e.getActionCommand().equals("수정"))
    	 {
    		 update();
    	 }
    	 else 
    	 {
    		 draw();
    	 }
     }
     
     void insert()
     {	 
    	 int rowNum, i;
    	 String hakbun;
     
    	 Sungjuk obj = new Sungjuk();
    	 obj.hakbun = txtHakbun.getText().trim();
         obj.irum = txtIrum.getText().trim();
         obj.kor = Integer.parseInt(txtKor.getText().trim());
         obj.eng = Integer.parseInt(txtEng.getText().trim());
         obj.math = Integer.parseInt(txtMath.getText().trim());
         
         DefaultTableModel model = (DefaultTableModel) table.getModel();
         rowNum = model.getRowCount();
         for (i=0; i<rowNum; i++)
         {
             hakbun = model.getValueAt(i, 0).toString().trim();
             if (obj.hakbun.equals(hakbun))
             {
            	 System.out.println("중복 오류!!");
            	 return;
             }
         }
         obj.process();
      
         Object arr[] = new Object[8];
         arr[0] = obj.hakbun;
         arr[1] = obj.irum;
         arr[2] = obj.kor;
         arr[3] = obj.eng;
         arr[4] = obj.math;
         arr[5] = obj.tot;
         arr[6] = Math.round(obj.avg * 100) / 100.;
         arr[7] = obj.grade;
         
         model.addRow(arr);
         System.out.println("추가 성공!!");
         
         txtHakbun.setText("");
         txtIrum.setText("");
         txtKor.setText("");
         txtEng.setText("");
         txtMath.setText("");
     }
     
     void delete()
     {
    	 int row = table.getSelectedRow();
         if (row == -1)
             return;
         
         DefaultTableModel model = (DefaultTableModel) table.getModel();
         model.removeRow(row);   
         System.out.println("삭제 성공!!");
     }
     
     void update()
     {
    	 int i, rowNum;
    	 String hakbun = null;
         DefaultTableModel model = (DefaultTableModel) table.getModel();
         Sungjuk obj = new Sungjuk();
      
         obj.hakbun = txtHakbun.getText().trim();
         obj.kor = Integer.parseInt(txtKor.getText().trim());
         obj.eng = Integer.parseInt(txtEng.getText().trim());
         obj.math = Integer.parseInt(txtMath.getText().trim());
         obj.process();
         
         rowNum = model.getRowCount();
         for (i=0; i<rowNum; i++)
         {
             hakbun = model.getValueAt(i, 0).toString().trim();
             if (obj.hakbun.equals(hakbun))
             {
            	 model.setValueAt(obj.kor, i, 2);
                 model.setValueAt(obj.eng, i, 3);
                 model.setValueAt(obj.math, i, 4);
                 model.setValueAt(obj.tot, i, 5);
                 model.setValueAt((Math.round(obj.avg * 100)) / 100., i, 6);
                 model.setValueAt(obj.grade, i, 7);
                 System.out.println("수정 성공!!");
                 txtHakbun.setText("");
                 txtKor.setText("");
                 txtEng.setText("");
                 txtMath.setText("");
                 return;
              }
          }
         System.out.println("수정 실패!!");
     }
     
     void draw()
     {
    	 int kor=0, eng=0, math=0;
    	 double avg=0;
      
    	 int row = table.getSelectedRow();
    	 if (row == -1)
    		 return;
         
    	 DefaultTableModel model = (DefaultTableModel) table.getModel();
     
         kor = (Integer)model.getValueAt(row, 2);
         eng = (Integer)model.getValueAt(row, 3);
         math = (Integer)model.getValueAt(row, 4);
         avg = (Double)model.getValueAt(row, 6);
      
         drawpanel.setScores(kor, eng, math, (int)Math.round(avg));
         drawpanel.repaint();
     }
 }