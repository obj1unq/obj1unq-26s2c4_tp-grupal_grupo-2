
const musicaMenu     = new MusicaMenu(archivo = "menu.mp3")

const musicaNivel1   = new MusicaNivel(archivo = "mapa1.mp3")
const musicaImagen1  = new MusicaImagen(archivo = "musica_imagen_1.mp3")

const musicaNivel2   = new MusicaNivel(archivo = "mapa2.mp3")
const musicaImagen2  = new MusicaImagen(archivo = "musica_imagen_2.mp3")

const musicaNivel3   = new MusicaNivel(archivo = "mapa3.mp3")
const musicaImagen3  = new MusicaImagen(archivo = "musica_imagen_3.mp3")

const musicaGameOver = new Musica(archivo = "game_over.mp3")
const subidaDeNivel  = new Musica(archivo = "subida_nivel.mp3")

const musicaGanador  = new MusicaImagen(archivo = "musica_imagen_ganador.mp3")

//SONIDOS CORTOS

const musicaTeleport = new Musica(archivo = "sonido_teleport.mp3")
const musicaEspadaHeroe = new Musica(archivo = "sonido_ataque_heroe.mp3")
const musicaEspadaOrco  = new Musica(archivo = "sonido_ataque_orcos.mp3")
const musicaEspadaReyOrco = new Musica(archivo = "sonido_ataque_reyorco.mp3")
const sonidoHeroeDolor = new Musica(archivo = "sonido_heroe_dolor.mp3")
const sonidoMuerteOrco = new Musica(archivo = "sonido_muerte_orco.mp3")
const sonidoObjeto     = new Musica(archivo = "sonido_objeto.mp3")
const sonidoPocion     = new Musica(archivo = "sonido_pocion.mp3")
const sonidoCrafteo    = new Musica(archivo = "sonido_crafteo.mp3")


class Musica {
    const archivo
    var musica = null

    method empezarMusica() {
        if (musica != null) {
            musica.stop()
        }

        musica = game.sound(archivo)
        self.configurar()
        musica.play()
    }

    method configurar() {
        musica.volume(0.75)
    }

    method pararMusica() {
        if (musica != null) {
            musica.stop()
        }
    }
}

class MusicaMenu inherits Musica {
    override method configurar() {
        musica.shouldLoop(true)
    }
}

class MusicaImagen inherits MusicaMenu {}

class MusicaNivel inherits MusicaMenu {}