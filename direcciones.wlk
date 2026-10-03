import game.*
import personajes.*
import estados.*

class Frame {

    var property frameActual = 1
    var property posicion

    method image(personaje, nivel, estado) {
        return posicion.nombre() + "_" + personaje + nivel + estado.nombre() + "_" + frameActual + ".png"
    }

    method siguienteFrame(personaje) {
        personaje.estado().siguienteFrame(self, personaje)
    }

    method noHaySiguienteFrame(cantidadFrames) {
        if(frameActual < cantidadFrames) {
            frameActual = frameActual + 1
            return false
        }

        frameActual = 1
        return true
    }

    method iniciarFrames() {
        frameActual = 1
    }

    method casilleroSiguiente(position) {
        return posicion.casilleroSiguiente(position)
    }
}

object arriba {

    method nombre() {
        return "arriba"
    }

    method siguiente(position, personaje) {
        personaje.posicionDeMira(personaje.posicionArriba())
        return position.up(1)
    }

    method casilleroSiguiente(position) {
        return position.up(1)
    }
}


object abajo {

    method nombre() {
        return "abajo"
    }

    method siguiente(position, personaje) {
        personaje.posicionDeMira(personaje.posicionAbajo())
        return position.down(1)
    }

    method casilleroSiguiente(position) {
        return position.down(1)
    }
}


object derecha {

    method nombre() {
        return "derecha"
    }

    method siguiente(position, personaje) {
        personaje.posicionDeMira(personaje.posicionDerecha())
        return position.right(1)
    }

    method casilleroSiguiente(position) {
        return position.right(1)
    }
}


object izquierda {

    method nombre() {
        return "izquierda"
    }

    method siguiente(position, personaje) {
        personaje.posicionDeMira(personaje.posicionIzquierda())
        return position.left(1)
    }

    method casilleroSiguiente(position) {
        return position.left(1)
    }
}