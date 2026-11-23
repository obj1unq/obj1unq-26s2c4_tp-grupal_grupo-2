
const musicaMenu      = new MusicaMenu(musica = game.sound("menu.mp3"))
const musicaImagen1   = new MusicaImagen(musica = game.sound("musica_imagen_1.mp3"))
const musicaGameOver  = new Musica(musica = game.sound("game_over.mp3"))

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

class MusicaImagen inherits MusicaMenu {}