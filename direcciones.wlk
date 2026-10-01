import game.*
import guerrero.*

class MiraADireccion {

  var property maxFramesMov
  var direccion
  var maxFramesAtaq
  var ataque = false
  var estadoActual = 1

  method image() {
    if(ataque){
        return direccion + "1_" + estadoActual + ".png"
    }
    return direccion + estadoActual + ".png"
  }
  

  method siguienteFrame(frames) {
    if (not ataque) {
        if (estadoActual < frames) {
            estadoActual = estadoActual + 1
        } else {
            estadoActual = 1
        }
    } else {
        self.siguienteFrameAtaque()
        }
  }
  method siguienteFrameAtaque(){
    if (estadoActual < maxFramesAtaq) {
            estadoActual = estadoActual + 1
        } else {
            estadoActual = 1
            ataque = false
    }
  }

  method atacar(){
    ataque       = true
    estadoActual = 1
  }

}


var abajo1     = new MiraADireccion(maxFramesMov = 6, direccion = "abajo_", maxFramesAtaq = 8)
var arriba1    = new MiraADireccion(maxFramesMov = 6, direccion = "arriba_", maxFramesAtaq = 8)
var derecha1   = new MiraADireccion(maxFramesMov = 6, direccion = "derecha_", maxFramesAtaq = 8)
var izquierda1 = new MiraADireccion(maxFramesMov = 6, direccion = "izquierda_", maxFramesAtaq = 8)


object moverArriba {
    method siguiente(position, personaje) {
        personaje.posicionDeMira(arriba1)
        return position.up(1)
    }
}

object moverAbajo {
    method siguiente(position, personaje) {
        personaje.posicionDeMira(abajo1)
        return position.down(1)
    }
}

object moverDerecha {
    method siguiente(position, personaje) {
        personaje.posicionDeMira(derecha1)
        return position.right(1)
    }
}

object moverIzquierda {
    method siguiente(position, personaje) {
        personaje.posicionDeMira(izquierda1)
        return position.left(1)
    }
}