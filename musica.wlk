
const musicaMenu = new MusicaMenu(archivo = "menu.mp3")

const musicaNivel1 = new MusicaNivel(archivo = "mapa1.mp3")
const musicaImagen1 = new MusicaImagen(archivo = "musica_imagen_1.mp3")

const musicaNivel2 = new MusicaNivel(archivo = "mapa2.mp3")
const musicaImagen2 = new MusicaImagen(archivo = "musica_imagen_2.mp3")

const musicaNivel3 = new MusicaNivel(archivo = "mapa3.mp3")
const musicaImagen3 = new MusicaImagen(archivo = "musica_imagen_3.mp3")

const musicaGameOver = new Musica(archivo = "game_over.mp3")
const subidaDeNivel = new Musica(archivo = "subida_nivel.mp3")


class Musica {
    const archivo
    var musica = null

    method empezarMusica() {
        musica = game.sound(archivo)
        self.configurar()
        musica.play()
    }

    method configurar() {}

    method pararMusica() {
        musica.stop()
    }
}

class MusicaMenu inherits Musica {
    override method configurar() {
        musica.shouldLoop(true)
    }
}

class MusicaImagen inherits MusicaMenu {}

class MusicaNivel inherits MusicaMenu {}