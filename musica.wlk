
const musicaMenu = new MusicaMenu(musica = game.sound("menu.mp3"))


class Musica {
    const musica
    method empezarMusica(){
        musica.play()
    }

    method pararMusica(){
        musica.stop()
    }
}
class MusicaMenu inherits Musica {

    override method empezarMusica(){
        musica.shouldLoop(true)
        super()
    }
}

