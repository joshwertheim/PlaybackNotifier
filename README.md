PlaybackNotifier
================

Goal: Simple program meant to pull the currently playing media file in either of the iTunes or Spotify applications and post it as a local notification.

Personally, I like to know the current song playing. I know the music in my library, but if I'm working on a task, I prefer to have glanceable information. I had always wanted this feature, but it wasn't native. That's why I decided to attempt to write the feature myself. I couldn't integrate it directly with iTunes, but that obstacle actually became a cool opportunity. I could work to add compatibility with music services other than iTunes.

Current features:
iTunes and Spotify support

WIP... ideas:<br>
Add support for album artwork so that the graphic will be shown instead of the application icon in the notification alert.<br>
Refactor a few files to reflect support for Spotify and not just iTunes.<br>
Planning to add ability to also show notifications for other applications<br>
    <ol>Rdio's app doesn't have a proper API at time of writing. Might try to find a workaround of some sort.</ol>
