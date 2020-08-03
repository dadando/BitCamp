package com.spring.mapper;

import java.util.List;

import com.spring.mb2replay.comment.CommentVO;

public interface CommentMapper {
    public int commentCount() throws Exception; // ´ñ±Û °³¼ö
    public List<CommentVO> commentList(int bno) throws Exception; // ´ñ±Û ¸ñ·Ï
    public int commentInsert(CommentVO comment) throws Exception; // ´ñ±Û ÀÛ¼º
    public int commentUpdate(CommentVO comment) throws Exception; // ´ñ±Û ¼öÁ¤
    public int commentDelete(int cno) throws Exception; // ´ñ±Û »èÁ¦
}
