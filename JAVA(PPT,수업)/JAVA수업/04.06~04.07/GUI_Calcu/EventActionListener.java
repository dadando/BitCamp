import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.StringTokenizer;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

public class EventActionListener implements ActionListener {
	JButton btn[];
	JTextField txtVal;
	
	EventActionListener(JButton btn[], JTextField txtVal)
	{
		this.btn = btn;
		this.txtVal = txtVal;
	}
	
	public void actionPerformed(ActionEvent e) {
		if (e.getActionCommand().equals("0"))
	    {
	    	txtVal.setText(txtVal.getText() + "0");
	    }
	    else if (e.getActionCommand().equals("1"))
	    {
	    	txtVal.setText(txtVal.getText() + "1");
	    }
	    else if (e.getActionCommand().equals("2"))
	    {
	    	txtVal.setText(txtVal.getText() + "2");
	    }
	    else if (e.getActionCommand().equals("3"))
	    {
	    	txtVal.setText(txtVal.getText() + "3");
	    }
	    else if (e.getActionCommand().equals("4"))
	    {
	    	txtVal.setText(txtVal.getText() + "4");
	    }
	    else if (e.getActionCommand().equals("5"))
	    {
	    	txtVal.setText(txtVal.getText() + "5");
	    }
	    else if (e.getActionCommand().equals("6"))
	    {
	    	txtVal.setText(txtVal.getText() + "6");
	    }
	    else if (e.getActionCommand().equals("7"))
	    {
	    	txtVal.setText(txtVal.getText() + "7");
	    }
	    else if (e.getActionCommand().equals("8"))
	    {
	    	txtVal.setText(txtVal.getText() + "8");
	    }
	    else if (e.getActionCommand().equals("9"))
	    {
	    	txtVal.setText(txtVal.getText() + "9");
	    }
	    else if (e.getActionCommand().equals("+"))
	    {
	    	txtVal.setText(txtVal.getText() + "+");
	    }
	    else if (e.getActionCommand().equals("-"))
	    {
	    	txtVal.setText(txtVal.getText() + "-");
	    }
	    else if (e.getActionCommand().equals("*"))
	    {
	    	txtVal.setText(txtVal.getText() + "*");
	    }
	    else if (e.getActionCommand().equals("/"))
	    {
	    	txtVal.setText(txtVal.getText() + "/");
	    }
	    else if (e.getActionCommand().equals("="))
	    {
	    	calcu();
	    }
	    else if (e.getActionCommand().equals("Clear")) {
	    	txtVal.setText("");
	    }
	    else {
	    	txtVal.setText(txtVal.getText().substring(0, txtVal.getText().length()-1));
	    }
	}
	
	void calcu() {
		String str = txtVal.getText();
		StringTokenizer token = new StringTokenizer(str, "+-*/", true);
		  
		String token_str = token.nextToken();  // 첫번째 토큰 읽음 
		if (input_check(token_str)) // input_check():토큰이 숫자인지 검사
		{
			JOptionPane.showMessageDialog(null, "수식 입력 오류-1!!!");// 토큰이 숫자가 아님
			return;  
		}
	
		int result = Integer.parseInt(token_str); // 토큰을 숫자로 변환
	  
		while(token.hasMoreTokens())  // 토큰이 없을때까지 반복
		{
			token_str = token.nextToken(); // 짝수번째 토큰 읽음(연산자)
			char ch = token_str.charAt(0);  // 문자열에서 연산자 추출
	   
			if (token.hasMoreTokens())
				token_str = token.nextToken();  // 홀수번째 토큰을 읽음(숫자)
			else
			{
				JOptionPane.showMessageDialog(null, "수식 입력 오류-2!!!");//연산자로 수식이 끝나는 경우
				return;
			}
	   
			if (input_check(token_str)) // input_check():토큰이 숫자인지 검사
			{
				JOptionPane.showMessageDialog(null, "수식 입력 오류-3!!!");
				return;
			}
			
			switch(ch)
			{
				case '+':
					result += Integer.parseInt(token_str);
					break;
				case '-':
				     result -= Integer.parseInt(token_str);
				     break;
				case '*':
					result *= Integer.parseInt(token_str);
					break;
				case '/':
					result /= Integer.parseInt(token_str); 
					break;
			} // switch
		} // while()
		txtVal.setText(txtVal.getText() + "=" + result);
	}
	
	boolean input_check(String str)
	{
		char ch;
		
		for (int i=0; i<str.length(); i++) //토큰을 전달 받아 문자열 길이만큼 한문자씩 검사
		{
			ch = str.charAt(i);  ////문자열에서 한문자씩 추출			
			if (ch < '0' || ch > '9') // ch가 숫자인지 검사(유니코드로 비교)
				return true;  // 숫자 아닌 문자가 있음
		}
		return false;
	}
}
