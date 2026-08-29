package guanghe.gsite.framework.websocket.core.sender.local;

import guanghe.gsite.framework.websocket.core.sender.AbstractWebSocketMessageSender;
import guanghe.gsite.framework.websocket.core.sender.WebSocketMessageSender;
import guanghe.gsite.framework.websocket.core.session.WebSocketSessionManager;

/**
 * 本地的 {@link WebSocketMessageSender} 实现类
 *
 * 注意：仅仅适合单机场景！！！
 *
 * @author 光何
 */
public class LocalWebSocketMessageSender extends AbstractWebSocketMessageSender {

    public LocalWebSocketMessageSender(WebSocketSessionManager sessionManager) {
        super(sessionManager);
    }

}
