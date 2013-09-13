
var canvas = document.getElementById('photopet');
var c = canvas.getContext('2d');
var img = new Image();
img.addEventListener('load', function () {
    c.drawImage(this, 0, 0, 400, 400); //  ultimi due sono le dimensioni (larghezza altezza) dell immagine (scalamento)
    }, false);
img.src = 'http://assets.dogtime.com/asset/image/50ef14a4b7a2a324360006c9/dog-looks-like-a-lion.jpg';
