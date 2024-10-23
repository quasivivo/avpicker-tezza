## Functionality:

- Import photos/videos from the photo library. (Features/Importer)
- Once imported, thumbnails of the media are displayed in a grid on the main screen. (Features/Gallery)
- Double-tapping any media opens a full-screen preview that allows users to swipe through the imported items. (Features/Viewer)
- Videos play in a loop and pause when the user swipes away. (Features/Viewer/MediaPlayerView)
- Users can delete imported media by long-pressing and confirming in a dialog.
- Swift Data is used to store the imported media. (Models/*)
- A Previewer helper was added to mock imported media for Previews. (Config/Previewer)
- A starter DI container was added to facilitate future expansion. (Config/Container)

## Limitations:

- To save time, PhotosUI was used instead of creating custom picker filter buttons as shown in the demo. This necessitated a combined photo/video picker.
- Images repopulate on subsquent launches, but videos do not due to an unresolved issue with the urls & temp storage.
- Multi-selection for deletions was not implemented, nor was optimization of the video player and page navigation for better performance. Only single selection deletions are possible, and there is some lag when swiping.
