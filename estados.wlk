import game.*


class Frame {
    var property frameActual = 1
    var property posicion

    method image(personaje, nivel, estado) {
        return posicion.nombre() + "_" + personaje + nivel.nivel() + estado.nombre() + "_" + frameActual + ".png"
    }

    method siguienteFrame(personaje) {
        personaje.estado().siguienteFrame(self, personaje)
    }

    method puedeAvanzar(cantidadFrames) {
        if (frameActual < cantidadFrames) {
            frameActual += 1
            return false
        }
        return true
    }

    method reiniciar() {
        frameActual = 1
    }

    method casilleroSiguiente(position) {
        return posicion.casilleroSiguiente(position)
    }


}



class Estado {
    const nombre
    const puedeMover
    const puedeAtacar
    const maxFramesEstado

    method nombre() {
        return nombre
    }

    method puedeMover() {
        return puedeMover
    }

    method puedeAtacar() {
        return puedeAtacar
    }

    method siguienteFrame(frame, personaje) {
        if (frame.puedeAvanzar(maxFramesEstado)) {
            personaje.estado(normal)
            frame.reiniciar()
        }
    }

    
}

class Normal inherits Estado {}

class Ataque inherits Estado {}

class Danio inherits Estado {}


class MuerteGoblin inherits Estado {
    override method siguienteFrame(frame, personaje) {
        if (frame.puedeAvanzar(maxFramesEstado)) {
            game.removeVisual(personaje)
        }
    }
}

class MuerteGuerrero inherits Estado {

    override method siguienteFrame(frame, personaje) {
        frame.puedeAvanzar(maxFramesEstado)
    }
    
}


var normal = new Normal(nombre = "normal", puedeMover = true, puedeAtacar = true, maxFramesEstado = 6)

var ataque = new Ataque(nombre = "ataque", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)

var danio = new Danio(nombre = "danio", puedeMover = false, puedeAtacar = false, maxFramesEstado = 6)

var muerteGoblin = new MuerteGoblin(nombre = "muerte", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)

var muerteGuerrero = new MuerteGuerrero(nombre = "muerte", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)