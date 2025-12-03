
# Simple in-memory state management for Dual Mode (Chat vs Downloader)

# States
MODE_CHAT = "chat"
MODE_DOWNLOADER = "downloader"

# Storage: {user_id: "mode"}
_user_modes = {}

def get_user_mode(user_id):
    """Get the current mode for a user. Defaults to None (not selected)."""
    return _user_modes.get(user_id)

def set_user_mode(user_id, mode):
    """Set the mode for a user."""
    _user_modes[user_id] = mode

def is_chat_mode(user_id):
    return get_user_mode(user_id) == MODE_CHAT

def is_downloader_mode(user_id):
    return get_user_mode(user_id) == MODE_DOWNLOADER
