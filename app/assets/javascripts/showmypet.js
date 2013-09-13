/**
 * Created with JetBrains RubyMine.
 * User: flaviacanino
 * Date: 12/09/13
 * Time: 16:09
 * To change this template use File | Settings | File Templates.
 */
var canvas = document.getElementById('showmypet');
var c = canvas.getContext('2d');
var img = new Image();
var photo = 'http://assets.dogtime.com/asset/image/50ef14a4b7a2a324360006c9/dog-looks-like-a-lion.jpg';
var photo2= 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSXoCfB4jvADHqzgDDTzaQ1j_PZMOHZEjDCyzxr-MKyE3T-Axzn';
addEventListener('load', function () {
  for(i=0; i<2; i++){
      for(j=0; j<2; j++){
          if(i%2==0){img.src = photo ; }
          else {img.src = photo2 ;}

          c.drawImage(img,j*200,i*200,200,200)
      }
  }
}, false);
