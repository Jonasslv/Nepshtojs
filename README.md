# Nepshtojs
Webpage that get info from a Unix system and draw with canvas.

## Files:

1. bg.html : The webpage wich use HTML5 and canvas to draw in the screen.
2. systemdata.sh : The shell script who get system information and turn into json.
3. stats.json : The JSON file made with the shell script.
4. sp.sh : Shell script made to control spotify using D-BUS.
5. Images that are resources for the webpage.

# How to use:

You need to setup an apache server on your machine and put bg.html there and the image files of canvas, make sure your systemdata is generating the stats.json on the apache folder too, you can make a service for it but unfortunally the spotify plugin will not work in recent versions of spotify when runing as service.
Usage: In this first version I use it as my wallpaper. I run an Webkit browser on low level in my screen and pass the website as default page, on the future I want to make a full solution for this project (Webkit + Apache installation).

Image:
![Nepnep](https://media.discordapp.net/attachments/223594824681521152/715083925902589952/Captura_de_tela_de_2020-05-27_03-06-44.png?width=1177&height=658)
