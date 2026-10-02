import game.*
import guerrero.*

class MiraADireccion {

  var property maxFramesMov
  var direccion
  var maxFramesAtaq
  var property ataque = false
  var estadoActual = 1

  method image(personaje, nivel) {
    if(ataque){
        return direccion + personaje + nivel + "ataque_" + estadoActual + ".png"
    }
    return direccion + personaje + nivel + "_" + estadoActual + ".png"
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



//var abajo1     = new MiraADireccion(maxFramesMov = 6, direccion = "abajo_", maxFramesAtaq = 8)
//var arriba1    = new MiraADireccion(maxFramesMov = 6, direccion = "arriba_", maxFramesAtaq = 8)
//var derecha1   = new MiraADireccion(maxFramesMov = 6, direccion = "derecha_", maxFramesAtaq = 8)
//var izquierda1 = new MiraADireccion(maxFramesMov = 6, direccion = "izquierda_", maxFramesAtaq = 8)


object moverArriba {
    method siguiente(position, personaje) {
        personaje.posicionDeMira(personaje.arriba())
        return position.up(1)
    }
}

object moverAbajo {
    method siguiente(position, personaje) {
        personaje.posicionDeMira(personaje.abajo())
        return position.down(1)
    }
}

object moverDerecha {
    method siguiente(position, personaje) {
        personaje.posicionDeMira(personaje.derecha())
        return position.right(1)
    }
}

object moverIzquierda {
    method siguiente(position, personaje) {
        personaje.posicionDeMira(personaje.izquierda())
        return position.left(1)
    }
}