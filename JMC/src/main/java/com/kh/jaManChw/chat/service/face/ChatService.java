package com.kh.jaManChw.chat.service.face;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.socket.WebSocketMessage;

import com.kh.jaManChw.dto.ChatRoom;

public interface ChatService {

	public void chatMessage(String roomid, WebSocketMessage<?> message);

	public List<ChatRoom> getChatRoomAll(HttpSession session);
	
}
