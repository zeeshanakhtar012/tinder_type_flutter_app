import 'package:shared_preferences/shared_preferences.dart';

class ArchiveManager {
  static const String _archivedChatsKey = 'archived_chats';

  // Get the list of archived room IDs
  static Future<List<String>> getArchivedChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_archivedChatsKey) ?? [];
  }

  // Archive a room
  static Future<void> archiveRoom(String roomId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> archivedRooms = await getArchivedChats();
    if (!archivedRooms.contains(roomId)) {
      archivedRooms.add(roomId);
      await prefs.setStringList(_archivedChatsKey, archivedRooms);
    }
  }

  // Unarchive a room
  static Future<void> unarchiveRoom(String roomId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> archivedRooms = await getArchivedChats();
    archivedRooms.remove(roomId);
    await prefs.setStringList(_archivedChatsKey, archivedRooms);
  }

  // Check if a room is archived
  static Future<bool> isRoomArchived(String roomId) async {
    List<String> archivedRooms = await getArchivedChats();
    return archivedRooms.contains(roomId);
  }
}
