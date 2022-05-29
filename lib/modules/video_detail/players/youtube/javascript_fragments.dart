String hidePauseOverlayJs =
    "document.querySelector('.ytp-pause-overlay').style.display='none';";
String fullScreenJs =
    "player.playVideo(); var playerIframe=document.getElementById('player'); var requestFullScreen = playerIframe.requestFullScreen || playerIframe.mozRequestFullScreen || playerIframe.webkitRequestFullScreen; if (requestFullScreen) { requestFullScreen.bind(playerIframe)(); }";
