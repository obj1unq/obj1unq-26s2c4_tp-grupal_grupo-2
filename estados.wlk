
import game.*
import personajes.*

class Frame {
    var property frameActual = 1
    var property posicion

    method image(personaje, nivel, estado) {
        return estado.image(personaje, nivel, posicion.nombre(), frameActual)
    }

    method siguienteFrame(personaje) {
        const estadoActual = personaje.estado()

        if (self.puedeAvanzar(estadoActual.maxFramesEstado())) {
            if (estadoActual.finalizar(personaje)) {
                self.reiniciar()
            }
        }
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

    method maxFramesEstado() {
        return maxFramesEstado
    }   

    method nombre() {
        return nombre
    }

    method puedeMover() {
        return puedeMover
    }

    method puedeAtacar() {
        return puedeAtacar
    }

    method finalizar(personaje) {
        personaje.estado(normal)
        return true
    }

    method image(personaje, nivel, direccion, numeroFrame) {
        return direccion + "_" + personaje + nivel.nivel() + self.nombre() + "_" + numeroFrame + ".png"
    }
}


class Normal inherits Estado {}

class Ataque inherits Estado {}

class Danio inherits Estado {}


class MuerteGoblin inherits Estado {
    override method finalizar(personaje) {
        game.removeVisual(personaje)
        generadorGoblins.eliminar(personaje)
        return false
    }
}


class MuerteGuerrero inherits Estado {
    override method finalizar(personaje) {
        return false
    }
}


class Transformacion inherits Estado {

    override method image(personaje, nivel, direccion, numeroFrame) {
        return personaje + "_" + self.nombre() + "_" + numeroFrame + ".png"
    }
}


var normal = new Normal(nombre = "normal", puedeMover = true, puedeAtacar = true, maxFramesEstado = 6)

var ataque = new Ataque(nombre = "ataque", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)

var danio = new Danio(nombre = "danio", puedeMover = false, puedeAtacar = false, maxFramesEstado = 6)

var muerteGoblin = new MuerteGoblin(nombre = "muerte", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)

var muerteGuerrero = new MuerteGuerrero(nombre = "muerte", puedeMover = false, puedeAtacar = false, maxFramesEstado = 8)

var transformacion = new Transformacion(nombre = "transformacion", puedeMover = false, puedeAtacar = false, maxFramesEstado = 2)