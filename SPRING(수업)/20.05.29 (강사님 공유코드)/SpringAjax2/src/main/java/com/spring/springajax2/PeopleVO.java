package com.spring.springajax2;

import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;

//@ToString, @EqualsAndHashCode, @Getter, @Setter, @RequiredArgsConstructor 어노테이션 묶음
//@RequiredArgsConstructor : final이나 @NonNull인 필드 값만 파라미터로 받는 생성자를 만듬.
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PeopleVO {
	
	private String id;
	private String name;
	private String job;
	private String address;
	private String bloodtype;
}
